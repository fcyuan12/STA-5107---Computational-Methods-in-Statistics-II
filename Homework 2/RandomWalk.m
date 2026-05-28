classdef RandomWalk
    properties
        X
        T
        alpha 
        s
        n
    end
    methods
        function [dt] = fit(dt)
            dt.X(1) = 0;
            for i = 1:dt.n
                u = rand(1);
                if u < 0.5
                    dt.X(i+1) = dt.X(i) + dt.s;
                else
                    dt.X(i+1) = dt.X(i) - dt.s;
                end
            end 
        end    
        function [] = plot_path(dt, filename)
            fig = figure;

            stairs((0:dt.n) * dt.T, dt.X, 'LineWidth', 2);
            xlabel('$t$', 'Interpreter', 'latex');
            ylabel('$X_t$', 'Interpreter', 'latex');
            
            saveas(fig, filename, 'epsc');
            close(fig);
        end    
    end
end
