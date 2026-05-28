classdef MH
    properties 
        T  % length of draws
        f  % target distribution
        
        % proposed distribution
        rq   % random draw from q(.)
        dq   % pdf
        para % parameters

        % acceptance
        n_accept % number of acceptance
        r_accept % acceptance rate

        % samples
        X 
    end
    methods
        function [res] = rexp(beta)
            res = -beta * log(rand(1));
        end
        function [res] = dexp(x, beta)
            res = 1 / beta * exp(-x / beta);
        end
        function [dt] = fit(dt)
            dt.X(1) = abs(5*randn(1));
            dt.n_accept = 0;

            for t = 1:dt.T
                % generate the candidate
                y = dt.rq(dt.para);
                x = dt.X(t);

                % update the parameter
                rho = min(dt.f(y) * dt.dq(x, dt.para) / (dt.f(x) * dt.dq(y, dt.para)), 1);

                u   = rand(1);
                if u < rho 
                    dt.X(t+1) = y;
                    dt.n_accept = dt.n_accept + 1;
                else
                    dt.X(t+1) = dt.X(t);
                end  
            end 

            dt.r_accept = dt.n_accept / dt.T;
        end  
        function [] = plot_density(dt, savename)
            fig = figure;
            hold on;

            [n, x] = hist(dt.X, 200);  
            
            % Normalize the histogram to approximate a pdf
            bin_width       = mean(diff(x));
            normalized_hist = n / sum(n * bin_width);
            
            % Evaluate the true pdf at bin centers
            for i = 1:length(x)
                fx(i) = dt.f(x(i));
            end    
            normalized_fx = fx / sum(fx * bin_width);
            
            plot(x, normalized_hist, 'b');
            plot(x, normalized_fx, 'r');
            xlabel('x');
            ylabel('Density');

            saveas(fig, savename, 'epsc');
            close(fig);     
        end    
        function [] = plot_hist(dt, savename)
            fig = figure;

            histogram(dt.X, 'Normalization', 'pdf', 'FaceAlpha', 0.5);
            xlabel('x');
            ylabel('Density');
            grid on;

            saveas(fig, savename, 'epsc');
            close(fig);     
        end    
        function [] = plot_evolution(dt, savename)
            fig = figure;

            plot(dt.X, 'b');
            xlabel('t');
            ylabel('X_t');

            saveas(fig, savename, 'epsc');
            close(fig);   
        end    
    end
end    
