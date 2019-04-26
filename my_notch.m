function [a, b, y] = my_notch(r, w, x)
% Returns the notch filter coefficients with poles located
% at r*exp(jw) and r*exp(-jw) and returns the filtered signal y
% given an input signal x.
%
% input:
% r - radius of poles
% w - angle of poles (in radians)
% x - input signal
%
% output:
% a - feedback coefficients
% b - feedforward coefficients
% y - filtered signal

a = [1, -2*r*cos(w), r^2];
b = [1, -2*cos(w), 1];

y = filter(b, a, x);