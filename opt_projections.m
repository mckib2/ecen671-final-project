clear;
close all;

k = 200;
n = 400;

t = 0.1;
p = 30;
gamma = 0.9;
iters = 400;

%% test shrink
in = linspace(-1,1,1000);
out = shrink(in,0.5,0.6);

figure(1);
plot(in,out,'k');
title(sprintf('Shrink Operation, t = %.1f, %s = %.1f',0.5,'\gamma',0.6));
xlabel('Input Value');
ylabel('Output Value');
axis([-1 1 -1 1]);

%% test algorithm

D = normc(gen_D(n,k));
P = normc(gen_D(p,n));

% Show original Projection Matrix
figure(2);
subplot(2,1,1);
G = ((P*D)'*P*D);
histogram(abs(offdiag(G)),'FaceColor','k');
xlim([0 0.8]);
title('Original Projection Matrix');
ylim([0 2500]);

%% run
[ P_opt, Pk ] = min_P(D,P,t,p,gamma,iters);

%% show optimial Projection Matrix
subplot(2,1,2);
G_opt = (P_opt*D)'*P_opt*D;
histogram(abs(offdiag(G_opt)),'FaceColor','k');
xlim([0 .8]);
ylim([0 2500]);
title('After 50 iterations');

%% get mutual coherence values
mu = zeros(length(Pk),1);
for kk = 1:length(Pk)
    mu(kk) = tmutco(Pk{kk}*D,t);
end

figure(4);
plot(1:length(Pk),mu,'k.-');
title(sprintf('Value of %s, t = %.1f, %s = %.1f','\mu_t\{P_kD\}',t,'\gamma',gamma));
xlabel('Iteration, k');
ylabel('Value of \mu_t');