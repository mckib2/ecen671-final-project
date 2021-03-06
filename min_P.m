%% Optimized Projections for Compressed Sensing
% http://ieeexplore.ieee.org/document/4359525/
% Objective: Minize mu_t{PD} with respect to P.

function [ P, histo ] = min_P(D,P,t,p,gamma,iters)
    %% Initialization
    % Set P0 \in R^{pxn} to be an arbitrary random matrix.
    %k = size(D,2);
    n = size(D,1);
    %P = gen_D(p,n);

    %% Loop
    histo = cell(iters,1);
    q = 1;
    while (q <= iters)
        %fprintf('q: %d\n',q);
        %% (1) Normalize
        % Normalize the columns in the matrix P_qD and obtain the effective
        % dictionary D_hat_q
        D_hat = normc(P*D);
        
        %% (2) Compute Gram Matrix
        % G_q = D_hat_q^T D_hat_q
        G = D_hat'*D_hat;
        
        %% (3) Set Threshold
        % If mode of operation is fixed, use t as threshold.  Otherwise,
        % choose t such that t% of the off-diagonal entries in G_q are
        % above it
        % t is fixed
        
        %% (4) Shrink
        % Update the Gram matrix and obtain G_hat_q
        G_hat = shrink(G,t,gamma);
        
        %% (5) Reduce Rank
        % Apply SVD and force the rank of G_hat_q to be equal to p
        G_hat = rank_reduce(G_hat,p);
        
        %% (6) Squared-Root
        % Build the squared-root of G_hat_q, S_q^T S_q = G_hat_q, where
        % S_q is of size pxk
        success = 1;
        [ S, success ] = rasqrtm(G_hat);
        if success == 0
            fprintf('Finding another P and starting over again...\n');
            P = gen_D(p,n);
            q = 1;
            continue;
        end
        
        %% (7) Update P
        % Find P_{q+1} that minimizes the error ||S_q - PD||^2_F
        %[P] = fminsearch(@(Pq) norm(S - Pq*D,'fro')^2,P,options);
        P = min_fro2(S,D);
        histo{q} = P;
        
        q = q + 1;
    end
end