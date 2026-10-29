clc
clear

%% locate data here
data = csvread('C:\Users\frank\OneDrive\桌面\USC\4_1\441\formalTest\N_1122\N_140mm\test2.csv');

%% put test name here 
test_name = '125 mm Nylon';

%% plots
% Set default font to Times New Roman for all plots
set(0, 'DefaultAxesFontName', 'Times New Roman');
set(0, 'DefaultTextFontName', 'Times New Roman');
set(0, 'DefaultLegendFontName', 'Times New Roman');

time = data(:,1);
rawV = data(:,2);
filtV = data(:,3);
force_old = data(:,4);
force = force_old-mean(force_old(1000:12000));
mass = data(:,5);

plot(time, force,'LineWidth',2)
xlim([30 32])
hold on



