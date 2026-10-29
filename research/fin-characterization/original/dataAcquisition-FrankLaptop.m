clear 
clc
close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define parameters
global sampleRate 
sampleRate = 3000; % Sample rate in Hz
duration = 45; % Duration in seconds
fc = 20; % cut-off frequency
intercept = 1.48e-03; % unit: V
slope = 3.3e-06; % unit: V/g
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data saving setting
folderPath = 'C:\Users\frank\OneDrive\桌面\USC\4_1\441\formalTest\DAR_1204\DAR_105mm';
filename = 'test2.csv';
fullPath = fullfile(folderPath, filename);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Create a data acquisition session
daqSession = daq.createSession('ni');

% Add an analog input channel (adjust 'Dev1' and 'ai2' as needed)
addAnalogInputChannel(daqSession, 'Dev1', 'ai2', 'Voltage');

% Set the sample rate
daqSession.Rate = sampleRate;

% Specify the duration for data acquisition
daqSession.DurationInSeconds = duration;

% Start data acquisition and store the data
disp('Starting data acquisition...');
[rawVoltage, timestamps] = daqSession.startForeground();
disp('Data acquisition completed.');

% filtering data 
fs = sampleRate; % Sampling Rate of DAQ

[b,a] = butter(6,fc/(fs/2)); % build butterworth filter

f_data = filtfilt(b,a,rawVoltage); % apply the filter

% convert into mass
mass_data = zeros(length(f_data),1);
force_data = zeros(length(f_data),1);
for j = 1:length(f_data)
    mass_data(j) = (f_data(j) - intercept)/(slope);
    force_data(j) = (f_data(j) - intercept)/(slope)/1000*9.807;
end

% Plot the data
figure;
plot(timestamps, rawVoltage);
xlabel('Time (s)');
ylabel('Voltage (V)');
title('Voltage Data from DAQ');

figure
plot(timestamps, f_data)
xlabel('Time (s)');
ylabel('Voltage (V)');
title('Filted Voltage Data from DAQ');

figure
plot(timestamps, mass_data)
xlabel('Time (s)');
ylabel('Mass (g)');
title('Mass measurement');

figure
plot(timestamps, force_data)
xlabel('Time (s)');
ylabel('Force (N)');
title('Force measurement');

% Save the data to a file
%   1  |      2     |      3      |   4   |  5
% time | rawVoltage | filtVoltage | force | mass
csvwrite(fullPath, [timestamps,rawVoltage,f_data,force_data,mass_data]);

disp('Data saved');