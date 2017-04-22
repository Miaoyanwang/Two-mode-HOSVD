# Two-mode-HOSVD
Two-mode Higher-Order Tensor Singular Value Decomposition 

The main function is HOSVD_extend.m. It implements the two-mode HOSVD algorithm described in https://arxiv.org/abs/1612.03839. 
The algorithm efficiently approximates the robust eigenvalue/vector pairs for a nearly orthogonal and symmetric tensor of order p. Compared to existing decomposition algorithms based on power iteration or joint diagonalization, our algorithm recovers the components more accurately from a noisy input tensor. For graphical model applications, order-3 tensors are of main interest, for which we improve the perturbation tolerance from 1/d to 1/sqrt(d).

tenfact_extend.m implements the joint diagonalization algorithm (Kuleshov et al AISTATS 2015). We optimized the original algorithm and extended it to allow order-p tensors. 

tmp_extend.m implements the power iteration algorithm (Anandkumar et al JMLR 2014) . We optimized the original algorithm and extended it to allow order-p tensors. 

See the comments in each file for input/output format. 

