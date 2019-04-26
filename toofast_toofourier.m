function [X, f] = toofast_toofourier(x, Fs)
% Returns the complex spectrum of the signal x sampled at
% sampling frequency Fs [Hz] with fundamental frequency f_0 [Hz] for
% frequencies -Fs/2 to Fs/2 [Hz]
%
% X(k) is the Fourier transform of x(t) for frequency f(k)
%
% ECE 2200 Spring 2014
% By Ricky Concepcion
%

N = length(x);
X = fftshift(fft(x))/N;
f = -Fs/2:Fs/(N-1):Fs/2;

figure()
subplot(2, 1, 1),
plot(f/1000, abs(X), 'LineWidth', 1.5)
title('Magnitude Spectrum of x(t)', 'FontSize', 16)
xlabel('f (kHz)', 'FontSize', 14)
ylabel('|X(\Omega)|', 'FontSize', 14)
grid

subplot(2, 1, 2),
plot(f/1000, angle(X), 'LineWidth', 1.5)
title('Phase Spectrum of x(t)', 'FontSize', 16)
xlabel('f (kHz)', 'FontSize', 14)
ylabel('\angle X(\Omega)', 'FontSize', 14)
grid