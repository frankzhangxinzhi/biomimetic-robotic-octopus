% main codes for DAR material post-lab data processing
clc
clear
close all

% for DAR
% DAR: |      1      |    2    |       3       |
%      |  fin length |  ratio  |  delta_ratio  | 
DAR = zeros(16,3); % data holder for all the processed data for DAR
DAR(:,1) = [65,65,70,70,80,80,85,85,90,90,95,95,100,100,120,120];

% extract and process data
% these below are good data which needs no manual processing
[DAR(1,2),DAR(1,3)]=getProcessedData(csvread('C:\Users\frank\OneDrive\桌面\USC\4_1\441\formalTest\DAR_1120\DAR_65mm\test1.csv'));
[DAR(2,2),DAR(2,3)]=getProcessedData(csvread('C:\Users\frank\OneDrive\桌面\USC\4_1\441\formalTest\DAR_1120\DAR_65mm\test2.csv'));
[DAR(3,2),DAR(3,3)]=getProcessedData(csvread('C:\Users\frank\OneDrive\桌面\USC\4_1\441\formalTest\DAR_1120\DAR_70mm\test1.csv'));
[DAR(4,2),DAR(4,3)]=getProcessedData(csvread('C:\Users\frank\OneDrive\桌面\USC\4_1\441\formalTest\DAR_1120\DAR_70mm\test2.csv'));
[DAR(5,2),DAR(5,3)]=getProcessedData(csvread('C:\Users\frank\OneDrive\桌面\USC\4_1\441\formalTest\DAR_1120\DAR_80mm\test2.csv'));
[DAR(9,2),DAR(9,3)]=getProcessedData(csvread('C:\Users\frank\OneDrive\桌面\USC\4_1\441\formalTest\DAR_1120\DAR_90mm\test1.csv'));
[DAR(10,2),DAR(10,3)]=getProcessedData(csvread('C:\Users\frank\OneDrive\桌面\USC\4_1\441\formalTest\DAR_1120\DAR_90mm\test2.csv'));
[DAR(11,2),DAR(11,3)]=getProcessedData(csvread('C:\Users\frank\OneDrive\桌面\USC\4_1\441\formalTest\DAR_1120\DAR_95mm\test1.csv'));
[DAR(12,2),DAR(12,3)]=getProcessedData(csvread('C:\Users\frank\OneDrive\桌面\USC\4_1\441\formalTest\DAR_1120\DAR_95mm\test2.csv'));
[DAR(13,2),DAR(13,3)]=getProcessedData(csvread('C:\Users\frank\OneDrive\桌面\USC\4_1\441\formalTest\DAR_1120\DAR_100mm\test1.csv'));
[DAR(14,2),DAR(14,3)]=getProcessedData(csvread('C:\Users\frank\OneDrive\桌面\USC\4_1\441\formalTest\DAR_1120\DAR_100mm\test3.csv'));
[DAR(15,2),DAR(15,3)]=getProcessedData(csvread('C:\Users\frank\OneDrive\桌面\USC\4_1\441\formalTest\DAR_1120\DAR_120mm\test1.csv'));
[DAR(16,2),DAR(16,3)]=getProcessedData(csvread('C:\Users\frank\OneDrive\桌面\USC\4_1\441\formalTest\DAR_1120\DAR_120mm\test2.csv'));

%% these data below needs manual adjustment 

%% 80mm, test 3
% load cell becomes crazy after t = 40 sec
% therefore, eliminate all the data after that 
[DAR(6,2),DAR(6,3)] = specialDataProces_DAR_80mm_test1(csvread('C:\Users\frank\OneDrive\桌面\USC\4_1\441\formalTest\DAR_1120\DAR_80mm\test1.csv'));

%% 85mm, test 2
% load cell becomes 0 reading between t = 14 sec and t = 17 sec
% therefore, eliminate all the data at that range
[DAR(8,2),DAR(8,3)] = specialDataProces_DAR_85mm_test2(csvread('C:\Users\frank\OneDrive\桌面\USC\4_1\441\formalTest\DAR_1120\DAR_85mm\test2.csv'));

%% 85mm, test 1
% load cell becomes crazy after t = 30 sec
% therefore, eliminate all the data after that 
[DAR(7,2),DAR(7,3)] = specialDataProces_DAR_85mm_test1(csvread('C:\Users\frank\OneDrive\桌面\USC\4_1\441\formalTest\DAR_1120\DAR_85mm\test1.csv'));

% Set default font to Times New Roman for all plots
set(0, 'DefaultAxesFontName', 'Times New Roman');
set(0, 'DefaultTextFontName', 'Times New Roman');
set(0, 'DefaultLegendFontName', 'Times New Roman');

% asymmetric buckling length range
l1 = 72.5;
l2 = 92.5;
x_patch = [l1 l1 l2 l2];
y_patch = [0 5 5 0];

% Finally, we can plot for DAR
figure 
scatter(DAR(:,1), DAR(:,2), 20, 'MarkerFaceColor', [0, 0.5, 0], 'MarkerEdgeColor', 'black', 'LineWidth', 0.8);
hold on
errorbar(DAR(:,1), DAR(:,2), DAR(:,3),'LineWidth', 0.5, 'Color', 'black','LineStyle','none');
% formatting the plot
xlabel('Fin length (mm)')
ylim([0.9 2.3])
ylabel('Thrust to drag ratio')
title('Thrust to Drag Ratio for Delrin Acetal Resin')
xlim([60 125])
patch(x_patch, y_patch, 'yellow', 'FaceAlpha', 0.5,'EdgeColor', 'none');

% plot x axis as length percentage 
percentLength = DAR(:,1)/150*100; % with unit of "%"
figure 
scatter(percentLength, DAR(:,2), 20, 'MarkerFaceColor', [0, 0.5, 0], 'MarkerEdgeColor', 'black', 'LineWidth', 0.8);
hold on
errorbar(percentLength, DAR(:,2), DAR(:,3),'LineWidth', 0.5, 'Color', 'black','LineStyle','none');
% formatting the plot
xlabel('Length Percentage (%)')
ylabel('Thrust to drag ratio')
xlim([45 85])