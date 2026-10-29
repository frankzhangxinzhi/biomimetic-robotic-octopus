% power spectrum function
function [omega, power] = powerSpectrum(t, x)
N = length(x);
T = t(end) - t(1);
a = fft(x);
omega = 2*pi/T*(0:N/2);
power = a(1:N/2+1).*conj(a(1:N/2+1))/N^2;
end