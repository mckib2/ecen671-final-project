function [ u ] = mutualcoherence(D)
    D = D/(diag(sqrt(diag(D'*D))));
    u = abs(D'*D);
    u = u - diag(diag(u));
    u = max(max(u));
end