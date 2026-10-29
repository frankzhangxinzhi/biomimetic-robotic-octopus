%% special data process for 85mm test1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function for post-lab data processing 

function [ratio,d_ratio]=specialDataProces_DAR_85mm_test1(rawData)

sampleRate = 3000; % Sampling rate

time_1 = 1*sampleRate; % time stamp at 1 sec
time_4 = 4*sampleRate; % time stamp at 4 sec

zero_reading = mean(rawData(time_1:time_4,4)); % get zero_reading of the force at t = 1:4 sec

f_t_plot = rawData(:,[1,4]); % force vs. time plot from raw data
zeroed_plot = f_t_plot; 
zeroed_plot(:,2) = f_t_plot(:,2) - zero_reading; % include the zero reading

% eliminiate the starting 0 part
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% AND ALSO ELIMINATE ANYTHING BETWEEN t = 14 sec and t = 17 sec
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pureWavePlot = zeroed_plot(8*sampleRate:30*sampleRate,:);

% get data of power spectrum 
N = length(pureWavePlot(:,2));
T = pureWavePlot(end,1)-pureWavePlot(1,1);
a = fft(pureWavePlot(:,2));
omega = 2*pi/T*(0:N/2);
frequency = omega/2/pi();
power = a(1:N/2+1).*conj(a(1:N/2+1))/N^2;
[maxPower,index_maxPower] = max(power);
max_f = frequency(index_maxPower);
period = 1/max_f; % calculate the period length 

for i = 1:99999 
    T_start = floor((i-1)*period*sampleRate+1);
    T_end = floor(i*period*sampleRate+1);
    if T_end > length(pureWavePlot)
        break
    end
    thrusts(i) = max(pureWavePlot(T_start:T_end,2));
    drags(i) = min(pureWavePlot(T_start:T_end,2)); % negative values
end

t_est = 1.990; % for 95% confidence level with 80 ouputs
avg_thrust = mean(thrusts);
avg_drag = mean(drags); % negative values
d_thrust = std(thrusts)*t_est;
d_drag = std(drags)*t_est; 
ratio = avg_thrust/abs(avg_drag);
d_ratio = sqrt((d_thrust/avg_drag)^2+(avg_thrust*d_drag/(avg_drag)^2)^2);