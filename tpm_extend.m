function [V, D, iters] = tpm_extend(T, L, N, n,o)

% TPM  Computes the orthogonal CP decomposition of a tensor
%   [V, D, iters] = tpmj(T, L, N, n) computes
%   the orthogonal CP decomposition of a rank-n tensor via the
%   tensor power method.
%
%   INPUTS:
%       T:      o-order tensor object (Currently, 3<=o<=7)
%       L:      Number of sweeps per tensor component
%       N:      Maximum number of iterations per sweep
%       n:      Rank of T
%       o:      Order of T (Currently, 3<=o<=7)
%
%   OUTPUTS:
%       V:      (d x n) matrix of orthogonal tensor components of T
%       D:      (n x 1) vector of component weights
%       iters:  Total number of T(I,v,v) operations performed
%
%   The algorithm computes components of T one at a time by repeatedly
%   multiplying the current iterate by the tensor: v1 = T(I,v0,v0,v0).
%   After converging to a component, we deflate the tensor and repeat.
%
%   Our implementation requires the MATLAB Tensor Toolbox v. 2.5 or greater.
%   The input tensor object must be constructed using the Tensor Toolbox.
%
%   For more information on the method see the following paper:
%
%   V. Kuleshov, A. Chaganty, P. Liang, Tensor Factorization via Matrix
%   Factorization, AISTATS 2015.
%

thr = 1e-4;
k = size(T,1);
V = zeros(k, n);
D = zeros(k,1);
%T = full(T);
iters = 0;

thetas = zeros(k,L);
theta_maxes = zeros(1,L);


for i=1:n
    for tau=1:L
        theta = randn(k,1);
        theta = theta ./ norm(theta);
        err = 1;
        t = 0;
 
        while (err > thr) && (t < N)
  
            old_theta = theta;
            theta=reshape(double(T),[k,k^(o-1)])*mouter(theta,o-1);
           % theta = double(ttm(T,{eye(k), theta', theta',theta',theta',theta',theta'}));
            theta = theta ./ norm(theta);
            err = min(norm(theta - old_theta), norm(theta + old_theta));
            t = t + 1;
            iters = iters + 1;
         
        end
        
        thetas(:,tau) = theta;
             %theta_maxes(:,tau) = dot(reshape(double(T),[k^o,1]),mouter(theta,o));
             theta_maxes(:,tau) = (mouter(theta,2))'*reshape(double(T),[k^2,k^(o-2)])*mouter(theta,o-2);
    end
    [lambda, tau_max] = max(theta_maxes);
    theta_max = thetas(:, tau_max);
    V(:,i) = theta_max;
    D(i) = lambda;

 deflator=reshape(lambda*mouter(theta_max,o),k*ones([1,o]));
 

    T = T - deflator;
 
  
end

end
