classdef KF
    properties
        n
        d
        T
        A
        B
        Gamma
        Q
        Lambda
        % data
        x0
        P0
        x
        y
        % result
        xhat
        Phat
        err
    end
    methods
        function [dt] = DGP(dt)
            dt.x(:, 1) = dt.x0; % x0

            for t = 1:dt.T
                dt.x(:, t+1) = dt.A * dt.x(:, t)   + dt.Gamma * sqrt(dt.Q) * randn(dt.n, 1);
                dt.y(:, t+1) = dt.B * dt.x(:, t+1) + sqrt(dt.Lambda) * randn(dt.d, 1);
            end
        end
        function [dt] = fit(dt)
            % initalization
            dt.xhat(:, 1)    = dt.x0; 
            dt.Phat(:, :, 1) = dt.P0;
            for t = 1:dt.T
                
                % prediction
                mu = dt.A * dt.xhat(:, t);
                P  = dt.A * dt.Phat(:, :, t) * dt.A' + dt.Gamma * dt.Q * dt.Gamma';

                % correction
                dt.Phat(:, :, t+1) = inv(inv(P) + dt.B' / dt.Lambda * dt.B); 
                Ghat = dt.Phat(:, :, t+1) * dt.B' / dt.Lambda; 
                dt.xhat(:, t+1) = mu + Ghat * (dt.y(:, t+1) - dt.B * mu);

                dt.err(t+1) = norm(dt.x(:, t+1) - dt.xhat(:, t+1)) / norm(dt.x(:, t+1));
            end    
        end
        function [] = plot_2D_x(dt, savename)
            fig = figure;
            plot3(dt.x(1,:), dt.x(2,:), 0:dt.T, 'b-', 'LineWidth', 2);
            xlabel('1st dimension of $x_{k}$', 'Interpreter', 'latex');
            ylabel('2nd dimension of $x_{k}$', 'Interpreter', 'latex');
            zlabel('$k$', 'Interpreter', 'latex');
            grid on;

            saveas(fig, savename, 'epsc');
            close(fig);
        end    
        function [] = plot_2D_path(dt, savename)
            fig = figure; 
            plot3(dt.x(1,:), dt.x(2,:), 0:dt.T, 'b-', 'LineWidth', 2);
            hold on;
            plot3(dt.xhat(1,:), dt.xhat(2,:), 0:dt.T, 'r-', 'LineWidth', 2);
            xlabel('1st dimension of $x_{k}$', 'Interpreter', 'latex');
            ylabel('2nd dimension of $x_{k}$', 'Interpreter', 'latex');
            zlabel('$k$', 'Interpreter', 'latex');
            legend('$x_k$', '$\widehat{x}_k$', 'Interpreter', 'latex');
            grid on;

            saveas(fig, savename, 'epsc');
            close(fig);
        end    
        function [] = plot_error(dt, savename)
            fig = figure;
            plot(1:dt.T, dt.err(2:end), 'LineWidth', 2);
            xlabel('$k$', 'Interpreter', 'latex');
            ylabel('Relative estimation error', 'Interpreter', 'latex');

            saveas(fig, savename, 'epsc');
            close(fig);
        end
    end
end
