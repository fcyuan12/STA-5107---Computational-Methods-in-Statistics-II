classdef LDA
    properties
        % n: number of dimension for each observation
        % k: number of observations for each class
        % C: number of classes
        X0   % n*kC data (original form)
        X    % n*k*C data
        mu_j
        mu_C
        Sb
        Sw
        V    % eigenvector
        D    % eigenvalue
        U    % U = V(:, 1:d); selected eigenvector
        Z    % Z = U'X; projection
        Z0
    end
    methods
        function [dt] = init(dt, k, C)
            dt.X = reshape(dt.X0, [], k, C);
        end    
        function [dt] = fit(dt)
            % 1. mu_c
            dt.mu_j = squeeze(mean(dt.X, 2));
            dt.mu_C = mean(dt.mu_j, 2);
            
            % 2-1. Sb
            dt.Sb = (dt.mu_j - dt.mu_C) * (dt.mu_j - dt.mu_C)';
            
            % 2-2. Sw
            dt.Sw = zeros(size(dt.Sb));
            for j = 1:size(dt.X, 3)
                for i = 1:size(dt.X, 2)
                    dt.Sw = dt.Sw + (dt.X(:,i,j) - dt.mu_j(:, j)) * (dt.X(:,i,j) - dt.mu_j(:, j))';
                end
            end

            % 3. 
            [dt.V, dt.D] = eig(dt.Sb, dt.Sw, 'chol'); %eigs(dt.Sb, dt.Sw)
            
            % 4.
            dt.V = fliplr(dt.V);
            dt.D = flipud(fliplr(dt.D));
        end  
        function [dt] = proj(dt, d)
            dt.U  = dt.V(:, 1:d);
            dt.Z  = dt.U' * dt.X0;
            % for `d=1`:
            % dt.Z0 = reshape(dt.Z, [], size(dt.X, 3));
        end    
        function [] = plot_eigval(dt, filename)
            fig = figure;

            plot(diag(dt.D), '-*');
            xticks(0:1:size(dt.X0, 1));
            xlabel('Index of eigenvalue');
            ylabel('Eigenvalue');
            saveas(fig, filename, 'epsc');
            close(fig);
        end    
        function [] = plot_proj(dt, filename)        
            fig = figure;
            hold on

            % for `d=1`:
            % color = 'rgbcm';
            % for c = 1:size(dt.Z0, 2)   
            %     plot(dt.Z0(:, c), [color(c) '*']);
            %     hold on
            % end 

            % for `d=2`:
            [~, k, C] = size(dt.X);
            for c = 1:C
                plot(dt.Z(1, (c-1)*k+1:c*k), dt.Z(2, (c-1)*k+1:c*k), '*', 'LineWidth', 2); 
            end  
            saveas(fig, filename, 'epsc');
            close(fig);
        end    
    end
end    
