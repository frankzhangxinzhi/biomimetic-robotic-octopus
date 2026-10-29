% main codes for ABS material post-lab data processing
clc
clear
close all

starting = 150;
ending = 105;
finLength = [];
for val = ending:5:starting
    finLength = [finLength, val, val];  % Add each value twice to the array
end
% data: |      1      |    2    |       3       |     4     |      5      |
%       |  fin length |  ratio  |  delta_ratio  | p-A ratio | d_p-A ratio |
% p-A stands for phase average 
result.L = finLength;

% extract data
for i = 1:length(finLength)
    rawdata = [];
    if i == 99 % for special case, leave this value 99 if no special case for this fin

    elseif mod(i,2) == 0
        rawdata = csvread('C:\\Users\\frank\\OneDrive\\桌面\\USC\\4_1\\441\\formalTest\\DAR_1204\\DAR_' + string(finLength(i)) + 'mm\\test2.csv');
    else 
        rawdata = csvread('C:\\Users\\frank\\OneDrive\\桌面\\USC\\4_1\\441\\formalTest\\DAR_1204\\DAR_' + string(finLength(i)) + 'mm\\test1.csv');
    end
    [result.cT(i),result.d_cT(i),result.cD(i),result.d_cD(i),result.ctotal(i),result.d_ctotal(i),result.ratio(i),result.d_ratio(i)] = getProcessedData(rawdata,result.L(i)/1000);
end

% for the same fin length, select the one with the less uncertainty. 
% Will be useful later in OverallPlots
varNames = fieldnames(result);
k = 1;
for i = 1:length(finLength)
    if mod(i,2) == 0
        if result.d_ratio(i) <= result.d_ratio(i-1)
            j = i;
        else
            j = i-1;
        end
        for ii = 1:length(varNames)
            monoResult.(varNames{ii})(k) = result.(varNames{ii})(j);
        end
        k = k+1;
    end
end

% save the data so that they could be used in another file where I wanna
% plot four materials into one
DAR1204Result = monoResult;
save('DAR1204Result.mat','DAR1204Result');

% Set default font to Times New Roman for all plots
set(0, 'DefaultAxesFontName', 'Times New Roman');
set(0, 'DefaultTextFontName', 'Times New Roman');
set(0, 'DefaultLegendFontName', 'Times New Roman');

% Finally, we can plot
% asymmetric buckling length range
l1 = 77.5;
l2 = 102.5;
x_patch = [l1 l1 l2 l2];
y_patch = [0 5 5 0];

% plot cT
figure(1)
scatter(result.L, result.cT, 20, 'MarkerFaceColor', [0, 0.5, 0], 'MarkerEdgeColor', 'black', 'LineWidth', 0.8);
hold on
errorbar(result.L, result.cT, result.d_cT,'LineWidth', 0.5, 'Color', 'black','LineStyle','none');
ylabel('c_T')
ylim([0 3])
title('c_T vs. Fin Length for DAR')

% plot cD
figure(2)
scatter(result.L, result.cD, 20, 'MarkerFaceColor', [0, 0.5, 0], 'MarkerEdgeColor', 'black', 'LineWidth', 0.8);
hold on
errorbar(result.L, result.cD, result.d_cD,'LineWidth', 0.5, 'Color', 'black','LineStyle','none');
ylabel('c_D')
ylim([0 2.2])
title('c_D vs. Fin Length for DAR')

% plot c_net
figure(3)
scatter(result.L, result.ctotal, 20, 'MarkerFaceColor', [0, 0.5, 0], 'MarkerEdgeColor', 'black', 'LineWidth', 0.8);
hold on
errorbar(result.L, result.ctotal, result.d_ctotal,'LineWidth', 0.5, 'Color', 'black','LineStyle','none');
ylabel('c_{net}')
ylim([0 1.1])
title('c_{net} vs. Fin Length for DAR')

% plot ratio
figure(4)
scatter(result.L, result.ratio, 20, 'MarkerFaceColor', [0, 0.5, 0], 'MarkerEdgeColor', 'black', 'LineWidth', 0.8);
hold on
errorbar(result.L, result.ratio, result.d_ratio,'LineWidth', 0.5, 'Color', 'black','LineStyle','none');
ylabel('c_T/c_D')
ylim([1.2 2.8])
title('c_T/c_D vs. Fin Length for DAR')

for i = 1:4
    figure(i)
    hold on
    xlabel('Fin length (mm)')
    patch(x_patch, y_patch, 'yellow', 'FaceAlpha', 0.2,'EdgeColor', 'none');
    xlim([min(finLength)-5 max(finLength)+5])
end