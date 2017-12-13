%% Tests

clear;
close all;

k = 200;
n = 400;
t = 0.2;
p = 30;
gamma = [ 0.95, 0.85, 0.75, 0.65, 0.55 ];
iters = 50;

rng(3);
D = gen_D(n,k);
P = gen_D(p,n);

figure(1);
for g = 1:length(gamma)
    [ ~, Pk ] = min_P(D,P,t,p,gamma(g),iters);

    mu = zeros(length(Pk),1);
    for kk = 1:length(Pk)
        mu(kk) = tmutco(Pk{kk}*D,t);
    end

    plot(1:length(Pk),mu,'.-');
    hold on;
    drawnow;
end