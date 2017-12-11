function [Mprime] = normc(M)
    n = sqrt(sum(M.^2,1));
    Mprime = bsxfun(@rdivide,M,n);
end