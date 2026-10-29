clear 
clc
close all

data = csvread('raw.csv');
[omega, power] = powerSpectrum(data(:,1),data(:,2));
figure
loglog(omega/2/pi(), power, 'LineWidth', 1.5, 'DisplayName', 'Power Spectrum');
xlabel('Frequency (Hz)')
ylabel('Power spectral density')

figure 
plot(data(:,1),data(:,2))