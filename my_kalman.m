function [y, var_err, k] = my_kalman(x, z0, var_z0, var_W, var_N, a)
% Returns the output of the Kalman filter based on the following signal
% and observation model:
%
% Signal model:
% Z[n] = a*Z[n-1] + W[n]
%
% Observation model:
% X[n] = Z[n] + N[n]
%
% Input:
% x         : (N x 1) vector of observations
% z0        : mean of a realization of z[0]
% var_z0    : variance of a realization of z[0]
% var_W     : variance of W[n]
% var_N     : variance of N[n]
% a         : signal model coefficient
%
% Output:
% y         : (N+1 x 1) vector of predictions/estimates of Z[n]
% var_err   : (N+1 x 1) vector of variance of the error process
% k         : (N x 1) vector of the Kalman gain
%

N = length(x);

k = zeros(N, 1);
y = zeros(N + 1, 1);
var_err = zeros(N + 1, 1);

%% Initialize: predict before any observations
y(1) = z0;
var_err(1) = var_z0;

%% Repeat: correct and predict with observations
for n = 1:N
    % Kalman gain
    k(n) = a*var_err(n)/(var_err(n) + var_N);
    
    % Correction & prediction
    y(n+1) = a*y(n) + k(n)*(x(n) - y(n));
    var_err(n+1) = a*(a - k(n))*var_err(n) + var_W;
end
