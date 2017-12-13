clear;
close all;

k = 200;
n = 400;

t = 0.2;
p = 30;
gamma = 0.55;
iters = 500;

%% test shrink
in = linspace(-1,1,1000);
out = shrink(in,0.5,0.6);

figure(1);
plot(in,out);
title(sprintf('Shrink Operation, t = %.1f, %s = %.1f',0.5,'\gamma',0.6));
xlabel('Input Value');
ylabel('Output Value');
axis([-1 1 -1 1]);

%% test algorithm

D = normc(gen_D(n,k));
P = normc(gen_D(p,n));

% Show original Projection Matrix
figure(2);
G = ((P*D)'*P*D);
histogram(abs(offdiag(G)));

%% run
[ P_opt, Pk ] = min_P(D,P,t,p,gamma,iters);

%% show optimial Projection Matrix
figure(3);
G_opt = (P_opt*D)'*P_opt*D;
histogram(abs(offdiag(G_opt)));

%% get mutual coherence values
mu = zeros(length(Pk),1);
for kk = 1:length(Pk)
    mu(kk) = tmutco(Pk{kk}*D,t);
end

figure(4);
plot(1:length(Pk),mu,'.-');
title(sprintf('Value of %s, t = %.1f, %s = %.1f','\mu_t\{P_kD\}',t,'\gamma',gamma));