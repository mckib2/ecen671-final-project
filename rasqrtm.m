%% Rank-adjusted Matrix Square root
function [ S ] = rasqrtm(G_hat)

    % In general, a square root matrix is only defined for an nxn matrix.  The
    % goal of this script is to generate of a square root matrix S of size pxn,
    % where p is the rank of G = S'*S.  We assume G is the Gram matrix.

    % So there's a weird thing where sometimes we get a negative eigenvalue
    % after rank reduction, so we'll throw an error when that happens
    p = rank(G_hat);
    if any(eigs(G_hat,p) < 0)
        fprintf('We got a negative semi-definite matrix people!\n');
    end

    % Now we need to find the square root matrix
    [x,lambdas] = eigs(G_hat,p);

    [lambdas_sort,idx] = sort(diag(lambdas),'descend');
    x = x(:,idx);
    S = zeros(size(x'));
    for ii = 1:p
        S(ii,:) = sqrt(lambdas_sort(ii))*x(:,ii);
    end

%     % SANITY CHECK:
%     test = S'*S - G_hat;
%     test(test < 1e-13) = 0;
%     fprintf('S''*S and G_hat are equal? %d\n',isequal(test,zeros(size(test))));
end