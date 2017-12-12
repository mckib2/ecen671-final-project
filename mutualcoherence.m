% TODO:
% I know what happened.  This is regular old mutual coherence.  We need to
% implement t-averaged mutual coherence as in equation (10) in the paper.

function [ u ] = mutualcoherence(D)
    D = D/(diag(sqrt(diag(D'*D))));
    u = abs(D'*D);
    u = u - diag(diag(u));
    u = max(max(u));
end