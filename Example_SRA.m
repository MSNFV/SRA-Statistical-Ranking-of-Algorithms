%Farzi-Veijouyeh, N., Feizi-Derakhshi, MR. A Comprehensive Comparative Study of Evolutionary, Swarm Intelligence,
% and Physics/Mathematics-Based Optimization Algorithms by the Novel SRA Algorithm. Arch Computat Methods Eng (2026).
% https://doi.org/10.1007/s11831-025-10472-9
clc;
clear;
close all;

%% ------------------- Load Data -------------------
% Load performance results and metadata
load('ResultsOA.mat', 'FbestMAT', 'NamesofAlgorithms', 'NamesofFunctions');

%% ------------------- Example 1 -------------------
% Example 1: All algorithms and all functions are analyzed.
% Ranking is based on all of them with alpha = 0.05.
% All functions belong to one category (Beta = 1).
% alpha = 0.05;  % Significance level
% Beta = 1;      % Single group (all functions together)
% FunctionGroup = ones(1, size(Data, 2));  % All functions in one group

Data = FbestMAT;

% Run SRA method
[P_value h FailureRate, Rank_ID] = SRA(Data);
  
% Create results table
ResultsTable = table(NamesofAlgorithms', FailureRate', Rank_ID', ...
    'VariableNames', {'Algorithm', 'FailureRate', 'Rank_ID'});
disp('=== Example 1 Results ===');
disp(strcat('P_value=',num2str(P_value(1))));
if h==0
     % Reject H0: at least one algorithm performs significantly differently
    disp('H0 is rejected: significant difference detected between algorithms.');
else
    % Fail to reject H0: no significant difference detected
    disp('H0 is not rejected: no statistically significant difference found.');
end

disp(ResultsTable);

%% ------------------- Example 2 -------------------
% Example 2: Define which algorithms and functions to include.
% Also define groups of functions and assign weights for each group.

alpha = 0.05;             % Significance level
Data = FbestMAT;          % Main performance matrix
Algorithms = 1:12;        % Select specific algorithms
Functions = 1:29;         % Select specific test functions

% --- Define group weights (must sum to 1) ---
Beta = [0.2, 0.3, 0.5];   %For Example [Unimodal, Multimodal, Composite]
if abs(sum(Beta) - 1) > 1e-6
    error('The sum of Beta weights must be equal to 1.');
end

% --- Define function groups ---
% For example: Unimodal (F1–F7), Multimodal (F8–F23), Composite (F24–F29)
FunctionGroup = [ones(1,7), 2*ones(1,16), 3*ones(1,6)];
if numel(FunctionGroup) ~= numel(Functions)
    error('The size of FunctionGroup must match the number of selected Functions.');
end

% Update algorithm names
NamesofAlgorithms = NamesofAlgorithms(Algorithms);

% Run SRA method
[P_value, h, FailureRate, Rank_ID] = SRA(Data, Algorithms, Functions, NamesofAlgorithms, alpha, Beta, FunctionGroup);

% Create results table
ResultsTable = table(NamesofAlgorithms', FailureRate', Rank_ID', ...
    'VariableNames', {'Algorithm', 'FailureRate', 'Rank_ID'});

disp('=== Example 2 Results ===');
disp(strcat('P_value=',num2str(P_value(1))));
if h==0
     % Reject H0: at least one algorithm performs significantly differently
    disp('H0 is rejected: significant difference detected between algorithms.');
else
    % Fail to reject H0: no significant difference detected
    disp('H0 is not rejected: no statistically significant difference found.');
end
disp(ResultsTable);

