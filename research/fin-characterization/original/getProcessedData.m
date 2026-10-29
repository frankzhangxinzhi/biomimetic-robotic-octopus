% function for post-lab data processing 

function [cT,d_cT,cD,d_cD,ctotal,d_ctotal,ratio,d_ratio]=getProcessedData(rawData,Lfin)

%% define variables 
sampleRate = 3000; 
density = 1000;
f = 1.9;
L = Lfin;
A = L; % change this 3/2 to 1 according to new understanding
C = 0.035;
Vmax = 2*pi*f*A;
denominator = 1/2*density*(Vmax^2)*L*C;

%%  eliminate zero reading 
time_1 = 1*sampleRate; % time stamp at 1 sec
time_4 = 4*sampleRate; % time stamp at 4 sec

zero_reading = mean(rawData(time_1:time_4,4)); % get zero_reading of the force at t = 1:4 sec

f_t_plot = rawData(:,[1,4]); % force vs. time plot from raw data
zeroed_plot = f_t_plot; 
zeroed_plot(:,2) = f_t_plot(:,2) - zero_reading; % eliminate zero reading

%% get data of power spectrum 
N = length(zeroed_plot(8*sampleRate:end,2));
T = zeroed_plot(end,1)-zeroed_plot(8*sampleRate,1);
a = fft(zeroed_plot(8*sampleRate:end,2));
omega = 2*pi/T*(0:N/2);
frequency = omega/2/pi();
power = a(1:N/2+1).*conj(a(1:N/2+1))/N^2;
power(1) = [];
frequency(1) = [];
[maxPower,index_maxPower] = max(power);
max_f = frequency(index_maxPower);
period = 1/max_f; % calculate the period length 

%% eliminiate the starting 0 reading part 
pureWavePlot = zeroed_plot(8*sampleRate:end,:); % eliminate everything before t = 8 sec
for i = 1:99999 
    T_start = floor((i-1)*period*sampleRate+1); % starting timestamp for the period of focus now 
    T_end = floor(i*period*sampleRate+1); % ending timestamp for the period of focus now 
    if T_end > length(pureWavePlot) % terminate if the ending timestamp exceeds the total time of the raw data 
        break
    end
    P_positive = 0; % intergal: (F_Thurst) over the period
    P_negative = 0; % intergal: (F_Drag) over the period
    for j = T_start:T_end % loop within the period of focus
        if pureWavePlot(j,2) >= 0 % if the reading is thrust
            P_positive = P_positive + pureWavePlot(j,2); % intergal!
        else % if the reading is drag
            P_negative = P_negative + pureWavePlot(j,2); % intergal!
        end
    end
    % calculating and recording data
    cTVal(i) = P_positive/(period*sampleRate)/denominator; % coefficient of thrust
    cDVal(i) = abs(P_negative/(period*sampleRate)/denominator); % coefficient of drag
    ctotalVal(i) = cTVal(i)-cDVal(i); % coefficient of net force
    ratioVal(i) = cTVal(i)/cDVal(i);
end

%% final data processing
% t-estimator for 95 % condidence range with 80 samples
t_est = 1.990;

cT = mean(cTVal);
cD = mean(cDVal);
ctotal = mean(ctotalVal);
ratio = mean(ratioVal);
d_cT = std(cTVal)*t_est;
d_cD = std(cDVal)*t_est;
d_ctotal = std(ctotalVal)*t_est;
d_ratio = std(ratioVal)*t_est;