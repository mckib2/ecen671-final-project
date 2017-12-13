%% t-averaged mutual coherence
% Reflects average behavior.  Defined as the average of all absolute and
% normalized inner products between different columns in D (denoted as
% g_{ij}) that are above t.

function [ u ] = tmutco (D,t)
    % normalize columns of G
    G = normc(D'*D);

    upper = 0;
    lower = 0;
    for ii = 1:size(G,1)
        for jj = 1:size(G,2)
            if (ii ~= jj)
                upper = upper + double(abs(G(ii,jj)) >= t)*abs(G(ii,jj));
                lower = lower + double(abs(G(ii,jj)) >= t);
            end
        end
    end
    
    u = upper/lower;
end