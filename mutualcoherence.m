function [ u ] = mutualcoherence(D)
    nD = normc(D);
    u = max(max(triu(abs((nD')*nD),1)));
end