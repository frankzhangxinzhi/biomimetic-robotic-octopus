clc
clear

%% locate data here
data = csvread('C:\Users\frank\OneDrive\桌面\USC\4_1\441\formalTest\N_1122\N_125mm\test2.csv');

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

figure
plot(time, rawV);
xlabel('Time (s)');
ylabel('Voltage (V)');
title(['Unfilted voltage vs. time plot for ', test_name]);

figure
plot(time, filtV)
xlabel('Time (s)');
ylabel('Voltage (V)');
title(['Filted Voltage vs. time plot for ', test_name]);

figure
plot(time, mass)
xlabel('Time (s)');
ylabel('Mass (g)');
title(['Mass vs. time plot for ', test_name]);

figure
plot(time, force)
xlabel('Time (s)');
ylabel('Force (N)');
title(['Force vs. time plot for ', test_name]);

figure
plot(time, force,'LineWidth',2)
xlim([15 17])
hold on
plot([0 100],[0 0],'LineWidth',2)
xlabel('Time (s)');
ylabel('Force (N)');


% power spectrum
% 8*sampleRate because I want to start at t = 8 sec
% so the zero reading part in the beginning is ignored 
sampleRate = 3000; % Sample rate in Hz
N = length(force(8*sampleRate:end));
T = time(end)-time(8*sampleRate,1);
a = fft(force(8*sampleRate:end));
omega = 2*pi/T*(0:N/2);
frequency = omega/2/pi();
power = a(1:N/2+1).*conj(a(1:N/2+1))/N^2;
power(1) = [];
frequency(1) = [];
figure
loglog(frequency, power, 'LineWidth', 1.5, 'DisplayName', 'Power Spectrum');
hold on
[maxPower,index_maxPower] = max(power);
text(frequency(index_maxPower)-0.8, maxPower-0.5, ['f_{peak} =', num2str(frequency(index_maxPower)),' Hz'], ...
    'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'FontSize', 12, 'FontWeight', 'bold', 'Color', 'k');
plot(frequency(index_maxPower), maxPower, 'ro', 'MarkerFaceColor', 'red', 'MarkerSize', 4);
ylim([10^(-10) 10])
xlabel('Frequency (Hz)')
ylabel('Power spectral density')
title(['Power Spectrum plot for ', test_name]);

