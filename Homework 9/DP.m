classdef DP
    properties
        n % number of states
        N % number of steps
        D % state / city distance (dim = n x n)
        X % city location (dim = n x 2)
        M % penalty
        i0 % (DP) optimial initial point; (SDP) inital point / city
        j0 % terminal point / city
        % ----- result ----- %
        C % cost function (dim = n x N)
        I
        p
        alpha % shortest path
    end
    methods
        function [dt] = fit_DP(dt)
            % Step 1: Initialization
            dt.C = zeros(dt.n, dt.N);
            dt.p = zeros(dt.n, dt.N - 1);

            % Step 2: Backward DP
            for k = dt.N-1:-1:1
                for i = 1:dt.n
                    [dt.C(i, k), dt.p(i, k)] = min(dt.D(i, :) + dt.C(:, k+1)');
                end
            end     

            % Step 3: Find the optimal initial state
            [~, dt.i0] = min(dt.C(:, 1));

            % % Step 4: Reconstruct optimal path
            % dt.alpha = zeros(1, dt.N);
            % dt.alpha(1) = i_star;
            % for k = 1:dt.N-1
            %     dt.alpha(k+1) = dt.p(dt.alpha(k), k);
            % end
        end
        function [dt] = fit_SDP(dt)
            % Step 1: Initialization
            dt.C = zeros(dt.n, dt.N);
            dt.I = zeros(dt.n, dt.N);
            dt.p = zeros(dt.n, dt.N); 
            dt.I(dt.j0, dt.N) = 1;

            % Step 2~3: Backward DP
            k = dt.N - 1;

            while k >= 1
                for i = 1:dt.n
                    min_cost = Inf;
                    j_star   = -1;
        
                    for j = 1:dt.n
                        if isfinite(dt.D(i, j))
                            cost = dt.D(i, j) + dt.C(j, k+1) + dt.M * (1 - dt.I(j, k+1));
                            if cost < min_cost
                                min_cost = cost;
                                j_star   = j;
                            end
                        end
                    end
        
                    dt.C(i,k) = min_cost;
                    dt.p(i,k) = j_star;
        
                    if dt.C(i, k) < dt.M
                        dt.I(i, k) = 1;
                    end
                end
        
                if dt.I(dt.i0, k) == 1
                    break;
                else
                    k = k - 1;
                end    
            end        

            % Step 4: Trace the path
            dt.alpha(1) = dt.i0; 

            i_now = dt.i0;
            for kk = k:dt.N-1
                i_next = dt.p(i_now, kk);
                dt.alpha(kk-k+2) = i_next;
                i_now = i_next;
            end
        end
        function [] = plot_DP(dt, savename)
            fig = figure; hold on;

            dt.alpha = zeros(1, dt.N);
            for i = 1:dt.n
                dt.alpha(1) = i;
                for k = 1:dt.N-1
                    dt.alpha(k+1) = dt.p(dt.alpha(k), k);
                end
                plot(1:dt.N, dt.alpha, '-', 'LineWidth', 1);
            end    

            dt.alpha(1) = dt.i0;
            for k = 1:dt.N-1
                dt.alpha(k+1) = dt.p(dt.alpha(k), k);
            end
            plot(1:dt.N, dt.alpha, 'r-o', 'LineWidth', 2);

            for i = 1:size(dt.C,1)
                for j = 1:size(dt.C,2)-1
                    text(j, i, num2str(dt.C(i, j)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center');
                end    
            end             

            xlabel('Time step');
            ylabel('State');
            xticks(1:dt.N); 
            yticks(1:dt.n); 
            xlim([0 dt.N]); 
            ylim([0 dt.n]);
            grid on;

            saveas(fig, savename, 'epsc');
            close(fig);
        end    
        function [] = plot_SDP(dt, savename)
            fig = figure; hold on;

            gplot(dt.D < Inf, dt.X, '-o');
            plot(dt.X(dt.alpha, 1), dt.X(dt.alpha, 2), 'r-', 'LineWidth', 2); 
            grid on;

            for i = 1:size(dt.X,1)
                text(dt.X(i,1), dt.X(i,2), ['p' num2str(i)], 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
            end            

            saveas(fig, savename, 'epsc');
            close(fig);
        end    
    end
end    