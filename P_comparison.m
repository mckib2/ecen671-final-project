%% Compare Optimized and Unoptimized Projection Matrices
% x is the original signal
% y is the sampled signal

clear;
close all;

n = 150;
k = 250;
D = dctmtx1(n,k);

ps = 21:2:25;

% Create fully sampled test signals, xn
N = 15; %100000;
t = linspace(0,1/8,n).';
x = zeros(n,N);
for nn = 1:N
    w1 = nn*10000*pi;
    x(:,nn) = sin(w1*t); % + sin(w2*t);
end

% Params for P optimization
t = 0.2;
gamma = 0.5;
iters = 200;
opts = spgSetParms('iterations',inf,'verbosity',0);

err_vanilla = zeros(length(ps),1);
err_opt = err_vanilla;
idx = 1;
for p = ps
    % For each p, generate a new random projection matrix
    fprintf('%%%%%%%% p: %d\n',p);
    rng(0);
    
    % Apply the projection matrix P to the signals to get y
    for nn = 1:N
        P = gen_D(p,n);
        fprintf('n: %d\n',nn);
        y = P*x(:,nn);

        % Solve the Basis Pursuit problem
        alpha = spg_bp(P*D,y,opts);
        alpha(alpha > 1e-6) = 0;

        % Reconstructed x we call x_hat
        x_hat = D*alpha;
        
        % Grab the error
        err_vanilla(idx) = err_vanilla(idx) + norm(x(:,nn) - x_hat);
        
        %% Now optimize P
        [ P_opt,~ ] = min_P(D,P,t,p,gamma,iters);
        y = P_opt*x(:,nn);
        alpha = spg_bp(P_opt*D,y,opts);
        alpha(alpha > 1e-6) = 0;
        x_hat = D*alpha;
        err_opt(idx) = err_opt(idx) + norm(x(:,nn) - x_hat);
    end
    err_vanilla(idx) = err_vanilla(idx)/N;
    err_opt(idx) = err_opt(idx)/N;
    
    idx = idx + 1;
end

%% Show me da plots
figure(1);
plot(ps,err_vanilla,'k-',ps,err_opt,'k--');
title('BP: Random P vs Optimized P');
xlabel('p');
ylabel('||x - D\alpha||_2');
legend('Random','Optimized');

figure(2);
plot(x(:,end));
hold on;
plot(x_hat);
