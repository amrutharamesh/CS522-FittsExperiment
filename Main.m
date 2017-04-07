clear all; close all; warning off; clc;
nTrials = 1;
numCircles = 9;
clickOrder = [1 5 9 4 8 3 7 2 6 1];
ang = 0:(360/numCircles):360-(360/numCircles);
bigCircleRadius = [300 200];
smallCircleRadius = [10 50 90];
data = [];
for trialNum = 1:nTrials
    for i = 1:length(bigCircleRadius)
        for j = 1:length(smallCircleRadius)
            fig = figure;
            axis([-450 450 -450 450]);
            hold on;

            for k=1:length(clickOrder)
                        for l=1:numCircles
                            pos = [ bigCircleRadius(i)*cosd(ang(l)),...  
                                    bigCircleRadius(i)*sind(ang(l))];

                            rectangle(  'Position', [pos smallCircleRadius(j) smallCircleRadius(j)],...
                                        'Curvature', [1 1], 'FaceColor', [0.8 0.8 0.8]);
                        end

                pos = [ bigCircleRadius(i)*cosd(ang(clickOrder(k))),...  
                        bigCircleRadius(i)*sind(ang(clickOrder(k)))];

                rectangle(  'Position', [pos smallCircleRadius(j) smallCircleRadius(j)],...
                            'Curvature', [1 1], 'FaceColor', [1 0 0]);
                tic;
                ginput(1);
                tt = toc;
                if k == 1
                    continue;
                else
                    pts = [bigCircleRadius(i)*cosd(ang(clickOrder(k))),...  
                        bigCircleRadius(i)*sind(ang(clickOrder(k)));
                        bigCircleRadius(i)*cosd(ang(clickOrder(k-1))),...  
                        bigCircleRadius(i)*sind(ang(clickOrder(k-1)))];
                    d =  sqrt((pts(2,1)-pts(1,1))^2 + (pts(2,2)-pts(1,2))^2);
                    id = log2((d/smallCircleRadius(j))+1);
                    tp = id/tt;
                    data = [data; bigCircleRadius(i) smallCircleRadius(j) d id tt*1000 tp];
                end          
            end
            save('-v7', 'clk_ammu.mat', 'data');
            close all;
        end
    end
end