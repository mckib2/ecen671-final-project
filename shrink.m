function [ G_hat ] = shrink(G,t,gamma)
    G_hat = zeros(size(G));
    for ii = 1:size(G,1)
        for jj = 1:size(G,2)
            if (abs(G(ii,jj)) >= t)
                G_hat(ii,jj) = gamma*G(ii,jj);
            elseif (t > abs(G(ii,jj))) && (abs(G(ii,jj)) >= gamma*t)
                G_hat(ii,jj) = gamma*t*sign(G(ii,jj));
            elseif (gamma*t > abs(G(ii,jj)))
                G_hat(ii,jj) = G(ii,jj);
            else
                fprintf('I should never get here...\n');
                G_hat(ii,jj) = G(ii,jj);
            end
        end
    end
end