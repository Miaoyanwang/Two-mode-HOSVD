function [V, Lambda, misc] = tenfact_extend(T, L, k, o)

% TENFACT  computes the orthogonal CP decomposition of a tensor.
%   [V, Lambda, flops, V0] = tendecomp(T, L, k) computes
%   the orthogonal CP decomposition of a rank-k tensor via simultaneous
%   matrix diagonalization.
%
%   INPUTS:
%       T:      o-order tensor (currently, 3<=o<=7)
%       k:      Rank of T
%       L:      Number of random projections of T
%       o:      order of the tensor
%
%   OUTPUTS:
%       V:      (d x k) matrix of orthogonal tensor components of T
%       Lambda: (k x 1) vector of component weights
%       misc:   Structure with extra (diagnostic) output:
%         misc.flops:   Estimate of the number of flops performed
%         misc.V0:      matrix components obtained only form random projections
%
%   The algorithm first projects T onto L random vector pairs to obtain 
%   L projeted matrices, which are decomposed used the Jacobi algorithm 
%   for simultaneous matrix diagonalization to obtain initial component 
%   estimates W0. These vectors are then used as plug-in estimates for the 
%   true components in a second projection step along V0. The joint decomposition 
%   of this second set of matrices produces the final result V.
%
%   Our implementation requires the MATLAB Tensor Toolbox v. 2.5 or greater.
%   The input tensor object must be constructed using the Tensor Toolbox.
%
%   For the original implementtion of TENFACT (o=3), see the following papers:
%
%   V. Kuleshov, A. Chaganty, P. Liang, Tensor Factorization via Matrix
%   Factorization, AISTATS 2015.


p = size(T,1);
flops = [0 0];

% STAGE 1: Random projections

M = zeros(p, p*L);
for l=1:L
   % U=normrnd(0,1,[p,o-2]);
   % U=normc(U);
    u = randn(p,1);
    u = u ./ norm(u);
        
 % M(:,(l-1)*p+1:l*p)=reshape((reshape(double(T),[p^2,p^(o-2)])*mouter_extend(U,o-2)),[p,p]);
M(:,(l-1)*p+1:l*p)=reshape((reshape(double(T),[p^2,p^(o-2)])*mouter(u,o-2)),[p,p]);
end
[U, ~, sweeps] = jacobi(M, 1e-4, k);
V0=U(:,1:k);

%flops(1) = flops(1) + sweeps * 2 * p * L * ( p*k - (k+1)*k/2 );
%flops(2) = flops(1);

% STAGE 2: Plug-in projections

M = zeros(p, p*k);
for l=1:k
    w = V0(:,l);
    w = w ./ norm(w);
    
     M(:,(l-1)*p+1:l*p)=reshape((reshape(double(T),[p^2,p^(o-2)])*mouter(w,o-2)),[p,p]);
end

%flops(2) = flops(2) + sweeps * 2 * p * k * ( p*k - (k+1)*k/2 );

[U, D, sweeps] = jacobi(M, 1e-4, k);
V = U(:,1:k);

% Compute component weights

Lambda = zeros(k,1);
for l=1:k
    DM = diag(D(:,(l-1)*p+1:l*p));
    [~, idx] = max(abs(DM));
    Lambda(l) = DM(idx);
end

misc = struct;
misc.flops = flops;
misc.V0 = V0;
end
