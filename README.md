# Two-mode-HOSVD
Two-mode Higher-Order Tensor Singular Value Decomposition 

The main function is HOSVD_extend.m. It implements the two-mode HOSVD algorithm described in https://arxiv.org/abs/1612.03839. 
The algorithm efficiently approximates the eigenvalue/vector pairs for a nearly orthogonal and symmetric tensor of order p. 

tenfact_extend.m extends the orthogonal joint diagonalization (Kuleshov et al AISTAT 2015) algorithm for decomposing order-3 tensors to decomposing order-p tensors. 

tmp_extend.m extends the tensor power iteration (Anandkumar et al JMLR 2014) algorithm for decomposing order-3 tensors to decomposing order-p tensors. 

See the comments in each file for input/output format. 

