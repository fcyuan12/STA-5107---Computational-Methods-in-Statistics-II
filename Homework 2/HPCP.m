classdef HPCP % Homogeneous Poisson Counting Process
    properties
        lambda % rate
        T      % T
        npath  % number of paths
        X      
        t      % arrival time
        tau    % inter-arrival time
        N 
    end
    methods
        function [dt] = fit(dt)           
            for j = 1:dt.npath
                % set up
                dt.X{j}(1) = 0; 
                dt.t{j}(1) = 0; 
                i = 1;

                while dt.t{j}(end) < dt.T
                    % tau_i ~ Exp(lambda)
                    u = rand(1);
                    dt.tau{j}(i) = -(1 / dt.lambda) * log(u);

                    % t_{i+1} = t_i + tau_i
                    dt.t{j}(i+1) = dt.t{j}(i) + dt.tau{j}(i);
                    dt.X{j}(i+1) = dt.X{j}(i) + 1;

                    i = i + 1;
                end
            end
        end
        function [] = plot_path(dt, filename)
            fig = figure;
            hold on;
            for i = 1:dt.npath
                stairs(dt.t{i}, dt.X{i}, 'LineWidth', 2);
            end  
            xlabel('$t$', 'Interpreter', 'latex');
            ylabel('$N(t)$', 'Interpreter', 'latex');
            xlim([0, dt.T]);

            saveas(fig, filename, 'epsc');
            close(fig);
        end    
        function [dt] = get_count(dt, lb, ub)
            for i = 1:dt.npath
                dt.N(i, 1) = sum(dt.t{i} >= lb & dt.t{i} <= ub);
            end    
        end    
        function [] = plot_hist_count(dt, filename)
            fig = figure;
            
            histogram(dt.N, 0:1:max(dt.N));
            xlabel('Number of events');
            ylabel('Frequency');

            saveas(fig, filename, 'epsc');
            close(fig);
        end    
    end
end
