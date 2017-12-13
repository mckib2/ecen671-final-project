function [ G_offdiag ] = offdiag(G)
    G_offdiag = zeros(numel(G) - length(diag(diag(G))),1);
    idx = 1;
    for ii = 1:size(G,1)
        for jj = 1:size(G,2)
            if (ii ~= jj)
                G_offdiag(idx) = G(ii,jj);
                idx = idx + 1;
            end
        end
    end
end