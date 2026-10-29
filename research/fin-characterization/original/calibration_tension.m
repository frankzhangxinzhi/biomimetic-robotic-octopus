clc
clear
close all

M1 = csvread('C:\Users\frank\OneDrive\桌面\USC\4_1\441\calibration2\tensionLoading.csv');
M2 = csvread('C:\Users\frank\OneDrive\桌面\USC\4_1\441\calibration2\tensionUnloading.csv');

loading = calibrationProcess(M1,1);
unloading = calibrationProcess(M2,0);
%   1  |   2    |  3  
% mass |  volt  | delta 
totalResult = [loading;unloading];

figure
errorbar(loading(:, 1), loading(:, 2), loading(:, 3), 'o', 'Color', [1 0.5 0], 'LineWidth', 1);
hold on
errorbar(unloading(:, 1), unloading(:, 2), unloading(:, 3), 'o', 'Color', [0 0.5 0], 'LineWidth', 1);
xlim([0 1100])
xlabel('mass (g)')
ylabel('voltage (V)')

% Fit a linear model
p = polyfit(totalResult(:,1), totalResult(:,2), 1); % 1 indicates linear fit

% Generate y values for the best fit line
y_fit = polyval(p, totalResult(:,1), totalResult(:,2));

% Plot the best fit line
plot(totalResult(:,1), y_fit, '--k', 'LineWidth', 0.75);

slope = p(1);
intercept = p(2);
slopeMax = slope + 5.2e-7;
interceptMax = intercept - 2.8e-4;
slopeMin = slope - 5.2e-7;
interceptMin = intercept + 28e-5;
x = linspace(0, 1050, 100); % Adjust the range as needed
% Calculate the corresponding y values
slopeLineMax = slopeMax * x + interceptMax;
plot(x, slopeLineMax, '--', 'Color', [1 0.5 0.5], 'LineWidth', 0.75);
slopeLineMin = slopeMin * x + interceptMin;
plot(x, slopeLineMin, '--', 'Color', [0.5 0.7 1], 'LineWidth', 0.75);
% Convert slope and intercept to scientific notation
slope_str = sprintf('%.2e', slope);
intercept_str = sprintf('%.2e', intercept);
slopeMax_str = sprintf('%.2e', slopeMax);
interceptMax_str = sprintf('%.2e', interceptMax);
slopeMin_str = sprintf('%.2e', slopeMin);
interceptMin_str = sprintf('%.2e', interceptMin);

% Format the equation string
equationStr = sprintf('V = %s m + %s', slope_str, intercept_str);
equationStrMax = sprintf('V = %s m + %s', slopeMax_str, interceptMax_str);
equationStrMin = sprintf('V = %s m + %s', slopeMin_str, interceptMin_str);
text(500, 1.1*10^-3, equationStr, 'FontSize', 12, 'Color', 'black');
text(500, 1.3*10^-3, equationStrMax, 'FontSize', 12, 'Color', [1 0.5 0.5]);
text(500, 0.9*10^-3, equationStrMin, 'FontSize', 12, 'Color', [0.5 0.7 1]);
legend('loading', 'unloading', 'best fit line','max slope', 'min slope','Location','southwest')

% save data
folderPath = 'C:\Users\frank\OneDrive\桌面\USC\4_1\441\calibration2';
filename = 'totalResultTension.csv';
fullPath = fullfile(folderPath, filename);
csvwrite(fullPath, totalResult);