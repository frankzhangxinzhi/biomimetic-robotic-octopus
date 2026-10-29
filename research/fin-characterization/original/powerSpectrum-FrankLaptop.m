% power spectrum function
function [omega, power] = powerSpectrum(t, x)
N = length(x);
if mod(N, 2) == 0
else
    x(end) = [];
    t(end) = [];
end

T = t(end) - t(1);
a = fft(x);
omega = 2*pi/T*(0:N/2);
power = a(1:N/2+1).*conj(a(1:N/2+1))/N^2;
end