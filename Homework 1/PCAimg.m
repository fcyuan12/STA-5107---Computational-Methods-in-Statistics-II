classdef PCAimg
    properties 
        X  % n*k matrix of explanatory variables
        Xbar 
        n  % number of explanatory variables
        k  % number of images
        n1 % 1st dimension of each figure
        n2 % 2nd dimension of each figure
        C  % n*n matrix of sample covariance of X
        U  % eigenvectors
        S  % eigenvalues (diagonal matrix)
        s  % sigular values of Cov(X)
        Z  % principal components scores (PC scores)
        R  % explained ratio
    end
    methods 
        function [m] = get_dim(m)
            [m.n, m.k] = size(m.X);
        end         
        function [m] = plot_mean(m, filename)
            m.Xbar = mean(m.X, 2);

            fig = figure;
            imagesc(reshape(m.Xbar, m.n1, m.n2));
            colormap("gray");
            axis equal off;
            saveas(fig, filename, 'epsc');
            close(fig);
        end    
        function [m] = fit(m)
            m.C = cov(m.X');
            [m.U, m.S, ~] = svd(m.C);
        end  
        function [m] = plot_S(m, filename)
            m.s = diag(m.S);

            fig = figure;
            plot(m.s, '-');
            xlabel('Index of principal component');
            ylabel('Singular value');

            % Plot the zoomed-in section
            axes('Position', [0.55, 0.55, 0.3, 0.3]); 
            plot(m.s(1:100), '-r'); 
            % title('Zoomed view of the first 100 singular values');
            xlabel('Index of principal component');
            ylabel('Singular value');

            saveas(fig, filename, 'epsc');
            close(fig);
        end  
        function [m] = plot_R(m, filename)
            m.R = cumsum(m.s) / sum(m.s);
            
            fig = figure;
            plot(m.R, '*-');
            ylim([0 1]);
            xlabel('Number of selected principal components');
            ylabel('Explained variance ratio');    

            % Plot the zoomed-in section
            axes('Position', [0.55, 0.55, 0.3, 0.3]); 
            plot(m.R(1:200), '*-r'); 
            xlabel('Number of selected principal components');
            ylabel('Explained variance ratio');    

            saveas(fig, filename, 'epsc');
            % close(fig);         
        end  
        function [m] = plot_PCi(m, i, filename)
            fig = figure;
            imagesc(reshape(m.U(:, i), 64, 56))
            colormap("gray")
            axis equal off
            saveas(fig, filename, 'epsc');
            close(fig);
        end
        function [m] = plot_reconstruction(m, d, i, filename)
            U1   = m.U(:, 1:d);
            Xrec = m.Xbar + U1 * U1' * m.X(:, i);
            Xerr = abs(m.X(:, i) - Xrec);   

            fig = figure;
            subplot(3, 1, 1);
            imagesc(reshape(m.X(:, i), m.n1, m.n2));
            colormap(gray);
            axis equal off;
            title(sprintf('Original'), 'FontSize', 6);

            subplot(3, 1, 2);
            imagesc(reshape(Xrec, m.n1, m.n2));
            colormap(gray);
            axis equal off;
            title(sprintf('Reconstrunction'), 'FontSize', 6);

            subplot(3, 1, 3);
            imagesc(reshape(Xerr, m.n1, m.n2));
            colormap(gray);
            axis equal off;
            title(sprintf('Absolute error'), 'FontSize', 6);

            saveas(fig, filename, 'epsc');
            close(fig);
        end     
    end     
end