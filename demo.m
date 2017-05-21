order=3;
p=50;
M = SymTensor(p,order);
sigma=1

% generate random symmetric tensor
R = normrnd(0,sigma,[max(reshape(M,[1,p^order])),1]);
Tensor=R(M);    
Tensor=tensor(Tensor);

% tensor decomposition
[output_vector,output_value]=HOSVD_extend(Tensor,k,p,order)

