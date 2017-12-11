function [Aprime] = rank_reduce(A,p)
    [U,Si,V] = svds(A,p);
    Aprime = U*Si*V';
end