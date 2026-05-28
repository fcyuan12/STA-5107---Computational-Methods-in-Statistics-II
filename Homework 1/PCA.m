classdef PCA
    properties 
        X  % n*k matrix of explanatory variables
        Xbar
        n  % number of explanatory variables
        k  % number of observation
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
        function [m] = plot_data(m, filename)
            fig = figure;
            if m.n == 2
                scatter(m.X(1,:), m.X(2,:), 'filled');
                xlabel('$X_1$', 'Interpreter', 'latex');
                ylabel('$X_2$', 'Interpreter', 'latex');
                grid on;
                saveas(fig, filename, 'epsc');
                close(fig);
            elseif m.n == 3
                scatter3(m.X(1,:), m.X(2,:), m.X(3,:), 'filled');
                xlabel('$X_1$', 'Interpreter', 'latex');
                ylabel('$X_2$', 'Interpreter', 'latex');
                zlabel('$X_3$', 'Interpreter', 'latex');
                grid on;
                saveas(fig, filename, 'epsc');
                close(fig);
            else
                disp('n is neither 2 nor 3.')
            end    
        end     
        function [m] = fit(m)
            m.C = cov(m.X');
            [m.U, m.S, ~] = svd(m.C);
        end  
        function [m] = plot_direction(m, filename)
            m.Xbar = mean(m.X, 2);
            fig = figure;
            color = ['c', 'g', 'r'];
            if m.n == 2
                scatter(m.X(1,:), m.X(2,:), 'filled');
                hold on
                for t = 1:2
                    plot( ...
                        m.Xbar(1)+2.5*sqrt(m.S(t,t))*[-m.U(1, t) m.U(1, t)], ...
                        m.Xbar(2)+2.5*sqrt(m.S(t,t))*[-m.U(2, t) m.U(2, t)], color(t), 'LineWidth', 2);
                end         
                xlabel('$X_1$', 'Interpreter', 'latex');
                ylabel('$X_2$', 'Interpreter', 'latex');
                grid on;
                saveas(fig, filename, 'epsc');
                close(fig);
            elseif m.n == 3
                scatter3(m.X(1,:), m.X(2,:), m.X(3,:), 'filled');
                hold on
                xlabel('$X_1$', 'Interpreter', 'latex');
                ylabel('$X_2$', 'Interpreter', 'latex');
                zlabel('$X_3$', 'Interpreter', 'latex');          
                for t = 1:3
                    plot3( ...
                        m.Xbar(1)+2.5*t^2*sqrt(m.S(t,t))*[-m.U(1, t) m.U(1, t)], ...
                        m.Xbar(2)+2.5*t^2*sqrt(m.S(t,t))*[-m.U(2, t) m.U(2, t)], ...
                        m.Xbar(3)+2.5*t^2*sqrt(m.S(t,t))*[-m.U(3, t) m.U(3, t)], color(t), 'LineWidth', 2);
                end                 
                grid on;
                saveas(fig, filename, 'epsc');
                close(fig);
            else
                disp('n is neither 2 nor 3.')
            end    
        end   
        function [m] = plot_PCscore(m, filename)
            m.Z = m.U(:, 1:2)' * m.X;

            fig = figure;
            scatter(m.Z(1, :), m.Z(2, :), 'filled');
            xlabel('1st principal dimension');
            ylabel('2nd principal dimension');
            grid on;
            saveas(fig, filename, 'epsc');
            close(fig);
        end 
        function [m] = plot_S(m, filename)
            m.s = diag(m.S);

            fig = figure;
            plot(m.s, '*-');
            xticks(0:1:m.n);

            xlabel('Index of principal component');
            ylabel('Singular value');
            saveas(fig, filename, 'epsc');
            close(fig);
        end    
        function [m] = plot_R(m, filename)
            m.R = cumsum(m.s) / sum(m.s);
            
            fig = figure;
            plot(m.R, '*-');
            xticks(0:1:m.n);
            ylim([0 1]);
            xlabel('Number of selected principal components');
            ylabel('Explained variance ratio');            
            saveas(fig, filename, 'epsc');
            close(fig);         
        end     
    end     
end