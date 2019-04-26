% voltage level

clear all
close all
clc

load voltage.mat

% Signal and observation model parameters:
% Z[n] = 1*Z[n-1] + 0 (no perturbing noise, the voltage level is constant)
% X[n] = Z[n] + N[n]  (measurement noise with variance 1.96)
var_W = 0;
var_N = 1.96;
a = 1;
L = 50;

% Initial guess z0 shouldn't be that high. [2, 4] seems to work well.
% Initial guess var_z0 can have a considerable effect on convergence
% speed. [0.8, 1.2] seems to work well.
z0 = 3;
var_z0 = 0.8;

[y, var_err, k] = my_kalman(x, z0, var_z0, var_W, var_N, a);

% Actual value: 2.7 V

figure()
hold on
plot(0:L-1, x, '--b', 'LineWidth', 1.1)
plot(0:L, y, '.-r', 'LineWidth', 1.1)
plot(0:L, zeros(L+1, 1), 'k', 'LineWidth', 1.5)
ylabel('V', 'FontSize', 18)
xlabel('n', 'FontSize', 18)
title('Estimating voltage level', 'FontSize', 18)
legend('X(n): Measurements', 'Y(n): Estimates', 'Location', 'Best')
grid
hold off