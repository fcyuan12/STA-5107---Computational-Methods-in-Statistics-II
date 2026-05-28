classdef MarkovChain
    properties
        P     % P or PI: transition matrix
        cumPi 
        X
        T     % number of steps / time periods
        npath % number of sample paths
        freq
        V     % dominant eigenvector of trnaisition matrix
        tab_freq_V
    end
    methods
        function [dt] = fit(dt)
            dt.cumPi = cumsum(dt.P, 2);

            dt.X = zeros(dt.npath, dt.T);
            for r = 1:dt.npath
                % initial state
                dt.X(r, 1) = ceil(rand(1) * size(dt.P, 1));

                % update the state
                for t = 2:dt.T
                    u = rand(1); 
                    dt.X(r, t) = find(u < dt.cumPi(dt.X(r, t-1), :), 1);
                end

            end    
        end
        function [] = plot_path(dt, filename)
            fig = figure;
            hold on;
            color = 'rgbcm';
            % marker = 'o+*.x';
            for r = 1:dt.npath
                stairs(1:dt.T, dt.X(r, :), 'Color', color(r), 'LineWidth', dt.npath-r+1);
            end
            axis([0 dt.T 1 size(dt.P, 1)]);
            legends = arrayfun(@(x) sprintf('Path %d', x), 1:dt.npath, 'UniformOutput', false);
            legend(legends, 'Location', 'best');
            xlabel('Time');
            ylabel('State');

            saveas(fig, filename, 'epsc');
            close(fig);
        end     
        function [dt] = find_freq(dt)
            for r = 1:dt.npath
                for t = 1:dt.T
                    for i = 1:size(dt.P, 1)
                        dt.freq{r}(i, t) = length(find(dt.X(r, 1:t) == i)) / t;
                    end
                end
            end
        end
        function [] = plot_freq(dt, filename)
            for r = 1:dt.npath
                fig = figure; 
                hold on;

                for i = 1:size(dt.P, 1)
                    plot(1:dt.T, dt.freq{r}(i, :), 'LineWidth', 2);                 
                end    
                legends = arrayfun(@(x) sprintf('State %d', x), 1:dt.npath, 'UniformOutput', false);
                legend(legends, 'Location', 'best');
                xlabel('Time');
                ylabel('Relative frequency');

                savename = sprintf('%s_%d', filename, r);
                saveas(fig, savename, 'epsc');
                close(fig);                   
            end
        end   
        function [dt] = compare_freq_V(dt, filename)
            dt.tab_freq_V = zeros(size(dt.P, 1), dt.npath);
            for r = 1:dt.npath+1
                if r <= dt.npath
                    dt.tab_freq_V(:, r) = dt.freq{r}(:, end);
                else
                    [U, ~] = eig(dt.P');
                    dt.V = U(:, 1) / sum(U(:, 1));
                    dt.tab_freq_V(:, r) = dt.V;
                end    
            end  
            res = dt.tab_freq_V;
            save(filename, "res");
        end    
    end
end    



        


