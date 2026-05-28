classdef SMC
    properties
        T
        n
        sig1
        sig2
        x
        y
        xs
        xhat
    end
    methods
        function [dt] = DGP1(dt)
            % x0 ~ U[0, 1]
            dt.x(1) = rand(1);

            for t = 2:dt.T+1
                dt.x(t) = sqrt(abs(dt.x(t-1))) + dt.sig1 * randn(1);
                dt.y(t) = dt.x(t)^2 + dt.sig2 * randn(1);
            end
        end 
        function [dt] = DGP2(dt)
            % x0 ~ N(0, 10)
            dt.x(1) = sqrt(10) * randn(1);

            for t = 2:dt.T+1
                dt.x(t) = dt.x(t-1) / 2 + (25 * dt.x(t-1)) / (1 + dt.x(t-1)^2) + 8 * cos(1.2 * t) + dt.sig1 * randn(1);
                dt.y(t) = dt.x(t)^2 / 20 + dt.sig2 * randn(1);
            end
        end    
        function [dt] = fit1(dt)
            % Initialization
            dt.xs(:, 1) = rand(dt.n, 1);
            
            for t = 2:dt.T+1
                % Prediction
                xp = sqrt(abs(dt.xs(:, t-1))) + dt.sig1 * randn(dt.n, 1);
                
                % Update
                v = dt.y(t) - xp.^2;
                w = exp(-0.5 * v.^2 ./ (dt.sig2^2));
                w = w / sum(w);
            
                % Resample
                idx = randsample(1:dt.n, dt.n, true, w);
                dt.xs(:, t) = xp(idx);
            
                dt.xhat(t) = mean(dt.xs(:, t));
            end
        end
        function [dt] = fit2(dt)
            % Initialization
            dt.xs(:, 1) = dt.sig1 * randn(dt.n, 1);
            
            for t = 2:dt.T+1
                % Prediction
                xp = dt.xs(:, t-1) / 2 + (25 * dt.xs(:, t-1)) ./ (1 + dt.xs(:, t-1).^2) + 8 * cos(1.2 * t) + dt.sig1 * randn(dt.n, 1);
                
                % Update
                v = dt.y(t) - xp.^2 / 20;
                w = exp(-0.5 * v.^2 ./ (dt.sig2^2));
                w = w / sum(w);
            
                % Resample
                idx = randsample(1:dt.n, dt.n, true, w);
                dt.xs(:, t) = xp(idx);
            
                dt.xhat(t) = mean(dt.xs(:, t));
            end
        end    
        function [] = plot_hist(dt, savename)
            fig = figure;
            t_opt = [1, 5, 10, 15, 20];
            
            for i = 1:length(t_opt)
                histogram(dt.xs(:, t_opt(i)+1), 'Normalization', 'pdf', 'FaceAlpha', 0.5, 'NumBins', 50);
                xlabel(sprintf('x_{%d}', t_opt(i)));
                ylabel('Density');

                saveas(fig, sprintf('%s_%d', savename, t_opt(i)), 'epsc');      
            end    
            close(fig);
        end
        function [] = plot_path(dt, savename)
            fig = figure;
            hold on;
            plot(1:dt.T, dt.x(2:end), 'b-*');
            plot(1:dt.T, dt.xhat(2:end), 'k-*');
            plot(1:dt.T, dt.y(2:end), 'r-*');
            xlabel('$t$', 'Interpreter', 'latex');
            ylabel('$x_t, \widehat{x}_t$, or $y_t$', 'Interpreter', 'latex');
            legend('$x_t$', '$\widehat{x}_t$', '$y_t$', 'Interpreter', 'latex');

            saveas(fig, savename, 'epsc');
            close(fig);
        end    
    end    
end    