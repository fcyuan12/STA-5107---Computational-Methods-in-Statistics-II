classdef Optim
    properties
        f       % objective function
        g       % graident of the objecitve function
        delta   % step size for graident decent
        x1      % initial value
        tol     % converge tolerance 
        T       % temperature
        maxIter % maximum iteration
        alpha 
        lb      % lower bound for domain
        ub      % upper bound for domain
        % ----- result ----- %
        fx      % f(xk)
        xk      % path of minimizer
        gk      % graident path of minimizer
    end
    methods
        function [dt] = DGD(dt) % Deterministic Gradient Descent
            % initialization
            dt.xk(1) = dt.x1;
            dt.gk(1) = dt.g(dt.x1);
            dt.fx(1) = dt.f(dt.x1);
            k = 1;

            while norm(dt.gk(k)) >= dt.tol 
                dt.xk(k+1) = dt.xk(k) - dt.delta * dt.gk(k);
                dt.gk(k+1) = dt.g(dt.xk(k));
                k = k + 1;
                dt.fx(k) = dt.f(dt.xk(:, k));
            end
        end
        function [dt] = SGD(dt) % Stochastic Gradient Descent
            % initialization
            dt.xk(1) = dt.x1;
            dt.gk(1) = dt.g(dt.x1);
            dt.fx(1) = dt.f(dt.x1);
            k = 1;

            while k <= dt.maxIter
                dt.xk(k+1) = dt.xk(k) - dt.delta * dt.gk(k) + sqrt(2 * dt.delta * dt.T) * randn(1); 
                % if dt.xk(k+1) < dt.lb  || dt.xk(k+1) > dt.ub
                %     dt.xk(k+1) = dt.xk(k);
                % end
                dt.xk(k+1) = max(dt.lb, min(dt.ub, dt.xk(k+1)));
                dt.gk(k+1) = dt.g(dt.xk(k));
                k = k + 1;
                dt.fx(k) = dt.f(dt.xk(:, k));
            end
        end
        function [dt] = SA(dt)
            % initialization
            dt.xk(:, 1) = dt.x1;
            dt.fx(1) = dt.f(dt.x1);
            k = 1;
            
            while k <= dt.maxIter
                yk = dt.xk(:, k) + sqrt(dt.T) * randn(length(dt.x1), 1);
                yk = max(dt.lb, min(dt.ub, yk));
                
                rho = min(exp(-(dt.f(yk) - dt.f(dt.xk(:, k))) / dt.T), 1);
                if rand(1) <= rho
                    dt.xk(:, k+1) = yk;
                else
                    dt.xk(:, k+1) = dt.xk(:, k);
                end    
                
                dt.T = dt.T * dt.alpha;
                k = k + 1;
                dt.fx(k) = dt.f(dt.xk(:, k));
            end    
        end    
        function [] = plot_xk(dt, savename)
            fig = figure;
            if isscalar(dt.x1)
                plot(dt.xk);
                xlabel('$k$', 'Interpreter', 'latex');
                ylabel('$x_k$', 'Interpreter', 'latex');
    
                saveas(fig, savename, 'epsc');
                close(fig);
            else
                plot(dt.xk(1, :)); hold on;
                plot(dt.xk(2, :));
                xlabel('$k$', 'Interpreter', 'latex');
                ylabel('$x_k, y_k$', 'Interpreter', 'latex');
                legend('$x_k$', '$y_k$', 'Interpreter', 'latex');

                saveas(fig, savename, 'epsc');
                close(fig); 
            end
        end 
        function [] = plot_fxk(dt, savename)
            fig = figure;
            plot(dt.fx);
            xlabel('$k$', 'Interpreter', 'latex');
            if isscalar(dt.x1)
                ylabel('$E(x_k)$', 'Interpreter', 'latex');
            else
                ylabel('$E(x_k, y_k)$', 'Interpreter', 'latex');
            end    
            
            saveas(fig, savename, 'epsc');
            close(fig);
        end 
    end    
end    
