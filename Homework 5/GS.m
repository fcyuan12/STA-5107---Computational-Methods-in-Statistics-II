classdef GS
    properties 
        niter
        X
        n 
        % Q1
        H
        J   
        % Q2
        sigma
        I
        d1
        d2
        % Q3
        a
        b
        tau2
        theta0
        Xbar

        theta
        sigma2
    end
    methods
        function [dt] = init_Q1(dt)
            tmp = round(rand(dt.n, dt.n));
            tmp(tmp == 0) = -1;

            dt.X = zeros(dt.n+2, dt.n+2);
            dt.X(2:dt.n+1, 2:dt.n+1) = tmp;
        end    
        function [dt] = fit_Q1(dt, savename)
            % generate the image
            dt = dt.init_Q1;

            fig = figure;
            plot_Q1(dt, 1);

            for r = 2:dt.niter+1
                for i = 2:dt.n+1
                    for j = 2:dt.n+1
                        Sn = dt.X(i, j-1) + dt.X(i, j+1) + dt.X(i+1, j) + dt.X(i-1, j);
                        T  = exp(-2 * (dt.H + dt.J * Sn));            
                        P1 = T / (1 + T);

                        % update the value
                        u  = rand(1);
                        if u < P1
                            dt.X(i, j) = 1;
                        else
                            dt.X(i, j) = -1;
                        end
                    end
                end 

                plot_Q1(dt, r);
            end
            saveas(fig, savename, 'epsc');
            close(fig);   
        end
        function [] = plot_Q1(dt, r) 
            subplot(dt.niter+1, 1, r);
            image(128*(1+dt.X(2:dt.n+1, 2:dt.n+1)));
            axis image;
            colormap("gray");
            axis off;
            title(sprintf('State %d', r));
        end  
        function [dt] = init_Q2(dt)
            [dt.d1, dt.d2] = size(dt.I);

            dt.X                       = zeros(dt.d1+2, dt.d2+2);
            dt.X(2:dt.d1+1, 2:dt.d2+1) = dt.I;
            dt.X(1,         2:dt.d2+1) = dt.I(dt.d1, :);
            dt.X(dt.d1+2,   2:dt.d2+1) = dt.I(1, :);
            dt.X(2:dt.d1+1, 1)         = dt.I(:, dt.d2);
            dt.X(2:dt.d1+1, dt.d2+2)   = dt.I(:, 1);
        end
        function [dt] = fit_Q2(dt, savename)
            dt = dt.init_Q2;

            fig = figure;
            plot_Q2(dt, 0);

            for r = 1:dt.niter
                for i = 2:dt.d1+1
                    for j = 2:dt.d2+1
                        mu = (dt.X(i-1, j) + dt.X(i+1, j) + dt.X(i, j-1) + dt.X(i, j+1)) / 4;
                        dt.X(i, j) = mu + dt.sigma * randn(1);
                    end                    
                end  
                plot_Q2(dt, r);
            end    

            saveas(fig, savename, 'epsc');
            close(fig); 
        end  
        function [] = plot_Q2(dt, r) 
            subplot(dt.niter+1, 1, r+1);
            imagesc(dt.X);  
            axis image;
            colormap("gray");
            axis off;
            title(sprintf('Sweep %d', r));
        end   
        function [dt] = fit_Q3(dt)
            dt.Xbar = mean(dt.X);
            dt.n = length(dt.X);

            % initialization
            dt.theta(1)  = mean(dt.X);
            dt.sigma2(1) = var(dt.X);

            shape = dt.n / 2 + dt.a;
            for t = 2:dt.niter+1                          
                % update: theta
                theta_mu = (dt.sigma2(t-1) * dt.theta0 + dt.n * dt.tau2 * dt.Xbar) / (dt.sigma2(t-1) + dt.n * dt.tau2);
                theta_s2 = (dt.sigma2(t-1) * dt.tau2) / (dt.sigma2(t-1) + dt.n * dt.tau2);
                dt.theta(t) = theta_mu + sqrt(theta_s2) * randn(1); 
                
                % update: sigma2 
                scale = 0.5 * sum((dt.X - dt.theta(t)).^2) + dt.b;
                dt.sigma2(t) = 1 / gamrnd(shape, 1 / scale); 
            end            
        end  
        function [] = plot_Q3(dt, savename)
            fig = figure;

            histogram(dt.theta, 'Normalization', 'pdf', 'FaceAlpha', 0.5);
            xlabel('\theta');
            ylabel('Density');        
            saveas(fig, sprintf('%s_theta', savename), 'epsc');

            histogram(dt.sigma2, 'Normalization', 'pdf', 'FaceAlpha', 0.5);
            xlabel('\sigma^2');
            ylabel('Density');        
            saveas(fig, sprintf('%s_sigma2', savename), 'epsc');

            close(fig); 
        end    

    end
end
