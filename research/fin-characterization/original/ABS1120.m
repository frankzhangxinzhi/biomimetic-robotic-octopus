% main codes for ABS material post-lab data processing
clc
clear
close all

% data: |      1      |    2    |       3       |     4     |      5      |
%       |  fin length |  ratio  |  delta_ratio  | p-A ratio | d_p-A ratio |
% p-A stands for phase average 
finLength = [75,75,80,80,85,85,90,90,95,95,100,100,120,120];
result = zeros(length(finLength),5);
result(:,1) = finLength;

% extract data
for i = 1:length(finLength)
    rawdata = [];
    if i == 99 % for special case, leave this value 99 if no special case for this fin

    elseif mod(i,2) == 0
        rawdata = csvread('C:\\Users\\frank\\OneDrive\\桌面\\USC\\4_1\\441\\formalTest\\ABS_1120\\ABS_' + string(finLength(i)) + 'mm\\test2.csv');
    else 
        rawdata = csvread('C:\\Users\\frank\\OneDrive\\桌面\\USC\\4_1\\441\\formalTest\\ABS_1120\\ABS_' + string(finLength(i)) + 'mm\\test1.csv');
    end
    [result(i,2),result(i,3),result(i,4),result(i,5)] = getProcessedData(rawdata);
end

% Set default font to Times New Roman for all plots
set(0, 'DefaultAxesFontName', 'Times New Roman');
set(0, 'DefaultTextFontName', 'Times New Roman');
set(0, 'DefaultLegendFontName', 'Times New Roman');

% Finally, we can plot
% asymmetric buckling length range
l1 = 82.5;
l2 = 92.5;
x_patch = [l1 l1 l2 l2];
y_patch = [0 5 5 0];

% plot fin length vs. T/D ratio
figure 
scatter(result(:,1), result(:,2), 20, 'MarkerFaceColor', [0, 0.5, 0], 'MarkerEdgeColor', 'black', 'LineWidth', 0.8);
hold on
errorbar(result(:,1), result(:,2), result(:,3),'LineWidth', 0.5, 'Color', 'black','LineStyle','none');
% formatting the plot
xlabel('Fin length (mm)')
ylabel('Thrust to drag ratio')
ylim([0.9 2.3])
xlim([min(finLength)-5 max(finLength)+5])
title('Thrust to Drag Ratio for ABS')
patch(x_patch, y_patch, 'yellow', 'FaceAlpha', 0.5,'EdgeColor', 'none');

% plot x axis as length percentage 
percentLength = result(:,1)/150*100; % with unit of "%"
figure 
scatter(percentLength, result(:,2), 20, 'MarkerFaceColor', [0, 0.5, 0], 'MarkerEdgeColor', 'black', 'LineWidth', 0.8);
hold on
errorbar(percentLength, result(:,2), result(:,3),'LineWidth', 0.5, 'Color', 'black','LineStyle','none');
% formatting the plot
xlabel('Length Percentage (%)')
ylabel('Thrust to drag ratio')
title('Thrust drag ratio extracted as peak values')
xlim([min(finLength)/150*100-5 max(finLength)/150*100+5])

% plot from the phase-averaged data
figure
scatter(result(:,1), result(:,4), 20, 'MarkerFaceColor', [0, 0.5, 0], 'MarkerEdgeColor', 'black', 'LineWidth', 0.8);
hold on
errorbar(result(:,1), result(:,4), result(:,5),'LineWidth', 0.5, 'Color', 'black','LineStyle','none');
% formatting the plot
xlabel('Fin length (mm)')
ylabel('Thrust to drag ratio')
title('Thrust drag ratio extracted as phase-average')
xlim([min(finLength)-5 max(finLength)+5])

% plot from the phase-averaged data
figure
scatter(percentLength, result(:,4), 20, 'MarkerFaceColor', [0, 0.5, 0], 'MarkerEdgeColor', 'black', 'LineWidth', 0.8);
hold on
errorbar(percentLength, result(:,4), result(:,5),'LineWidth', 0.5, 'Color', 'black','LineStyle','none');
% formatting the plot
xlabel('Length Percentage (%)')
ylabel('Thrust to drag ratio')
title('Thrust drag ratio extracted as phase-average')
xlim([min(finLength)/150*100-5 max(finLength)/150*100+5])