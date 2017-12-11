clear;
close all;

k = 200;
n = 400;

t = 0.2;
p = 30;
gamma = 0.5;
iters = 500;

%% test shrink
in = linspace(-1,1,1000);
out = shrink(in,0.5,0.6);

figure(1);
plot(in,out);
title(sprintf('Shrink Operation, t = %.1f, %s = %.1f',t,'\gamma',gamma));
xlabel('Input Value');
ylabel('Output Value');
axis([-1 1 -1 1]);

%% test algorithm

D = normc(gen_D(n,k));
P = normc(gen_D(p,n));

% Show original Projection Matrix
figure(2);
G = (D.')*(P.')*P*D;
histogram(abs(G - diag(diag(G))));

%% run
[ P_opt, histo ] = min_P(t,D,p,gamma,iters);

%% show optimial Projection Matrix
figure(3);
Go = (D.')*(P_opt.')*P_opt*D;
histogram(abs(Go - diag(diag(Go))));

%% get mutual coherence values
mu = zeros(length(histo),1);
for kk = 1:length(histo)
    mu(kk) = mutualcoherence(histo{kk}*D);
end

figure(4);
plot(mu);
title(sprintf('Value of %s, t = %.1f, %s = %.1f','\mu_t\{P_kD\}',t,'\gamma',gamma));