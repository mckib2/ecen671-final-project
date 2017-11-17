%% Compressed Sensing Example
% Taken from https://www.mathworks.com/company/newsletters/articles/magic-reconstruction-compressed-sensing.html
% Nicholas McKibben
% ECEn 671, Project
% 2017-11-13

clear;
close all;

%% Generate 2 tone and randomly sample

N = 5e3;
t = linspace(0,1/8,N).';
w1 = 1394*pi;
w2 = 3266*pi;
f = sin(w1*t) + sin(w2*t);

% m is the percentage of the original samples sampled
m = .1*N;
idx = randsample(N,m);

fprintf('Sampling ratio: %f%%\n',m/N*100);

% Plot the fully sampled signal showing m random samples
figure(1);
h = plot(t,f,'-s');
h.MarkerSize = 2;
h.MarkerIndices = idx;
zoom('xon'); zoom(10);

%% IDCT of f
% Plot the actual sparse coefficients
figure(2);
c = idct(f);
plot(c);

%% Construct A
D = dct(eye(N,N));
A = D(idx,:);

%% Reconstruct
% min_{x \in R^n} ||x||_1 subject to Ax = f(idx)
% This is SPGL1's basis pursuit
[xp,r,g,info] = spg_bp(A,f(idx));

%% Look at some plots
% Plot the reconstructed signal overtop the fully sampled f
figure(1);
hold on;
plot(t,dct(xp));
title('Two tone Signal');
xlabel('Time (s)');
legend('Fully sampled', ...
    sprintf('CS Reconstructed, %d%% sampling ratio',m/N*100));

% Plot the approximated coefficents overtop the idct(f)
figure(2);
hold on;
plot(xp);
title('DCT Sparse representation');
legend('Fully sampled','CS Reconstructed');

% Plot the error
figure(3);
semilogy(abs(dct(xp)-f));
title('log(Error)');