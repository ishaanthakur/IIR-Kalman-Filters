% test_kalman
%
% Test script for analyzing Kalman filter performance.
% Generates X[n] and Z[n] using supplied parameters and supplies X[n] to
% the Kalman filter. The Kalman filter is given the exact parameters that
% generated X[n] and Z[n]. In some sense, this will test the best
% performance of the filter for a given model. Remember, in general, Z[n]
% is hidden so these plots are just a way to visualize the accuracy of the
% filter.
%
% Do not use this script if you do not need to generate data. Write a
% separate script if you want to filter data that you did not generate.
%
% ECE 2200 Spring 2014
% By Ricky Concepcion
%

clc
close all
%clear all

%% Signal and observation model parameters %%
L = 150;                % the number of observations
mean_z0 = 0;            % mu_Z, the average value of Z[0]
var_z0 = 0;             % sigma^2_Z, the variance of Z[0]
var_W = 0.36;           % sigma^2_W, the variance of W[n]
var_N = 1.00;           % sigma^2_N, the variance of N[n]
a = 0.8;                % a = the signal model parameter

%% Generate a realization of Z at time 0 based on a N(mean_z0, var_z0) distribution %%
z0 = mean_z0 + sqrt(var_z0)*randn(1)

%% Generate the signal of observations x and signal of realizations z
[x, z] = kalman_maybe(z0, L, var_W, var_N, a);

%% Test your Kalman filter on the observations
% mean_z0 : your initial guess Y_0
% var_z0  : your initial guess sigma^2_{e_0}
[y, err, k] = my_kalman(x, mean_z0, var_z0, var_W, var_N, a);

%% Plots n etc
figure()
hold on
plot(0:L-1, z, '--b', 'LineWidth', 1.1)
plot(0:L-1, x, 'g', 'LineWidth', 1.1)
plot(0:L, zeros(L+1, 1), 'k', 'LineWidth', 1.5)
xlabel('n', 'FontSize', 18)
title('Realizations of Z(n) and Observations X(n)', 'FontSize', 18)
legend('Z(n)', 'X(n)', 'Location', 'Southeast') 
grid
hold off

figure()
hold on
plot(0:L-1, z, '--b', 'LineWidth', 1.1)
plot(0:L-1, x, '--g', 'LineWidth', 1.1)
plot(0:L, y, '.-r', 'LineWidth', 1.1)
plot(0:L, zeros(L+1, 1), 'k', 'LineWidth', 1.5)
xlabel('n', 'FontSize', 18)
title('Kalman Filter Output', 'FontSize', 18)
legend('Z(n)', 'X(n)', 'Y(n)', 'Location', 'Southeast')
grid
hold off

figure()
subplot(2,1,1),
hold on
plot(0:L, err, 'b', 'LineWidth', 1.4)
xlabel('n', 'FontSize', 18)
title('Mean Square Error Process', 'FontSize', 18)
grid
hold off

subplot(2,1,2),
hold on
plot(0:L-1, k, 'r', 'LineWidth', 1.4)
xlabel('n', 'FontSize', 18)
title('Kalman Gain', 'FontSize', 18)
grid
hold off