% Two-Mode HOSVD 
% Input:
% T: a symmetric order-k tensor with dimension dim
% Ncomp: number of components to extract 
% Output:
% output_vector: a matrix with Ncomp column, each column representing the e  stimated eigenvector. 
% output_value: a lenght-Ncomp vector, each value representing the estimated eigenvalue. 
function[output_vector,output_value]=HOSVD_extend(T,dim,Ncomp, order)


  %vector=size(T);
  %dim=vector(1);
  %order=length(vector);;
  %order=3;

  output_vector=zeros(dim,Ncomp);
  output_value=zeros(1,Ncomp);

  % Two-Mode HOSVD
   M=reshape(double(T),[dim^2,dim^(order-2)]);
   %M=reshape(double(T),[dim^2,dim]);
 

 if order <= 4
   [Rspace,~,~]=svds(M,Ncomp);
 else 
    [Rspace,~,~]=svds(M*transpose(M),Ncomp);
 end

  
for index=1:Ncomp
   
    Matrix.Basis=reshape(Rspace,[dim,dim,Ncomp]);
    [Rvector,norm_opt,~]=svds(Matrix.Basis(:,:,index),1);
    
    delta=0.05;
    norm_delta=delta+0.1;


     while norm_delta>delta
         % projection
         Rmatrix=reshape(Rspace*transpose(Rspace)*kron(Rvector,Rvector),[dim,dim]);
         % dominant eigenvectors
         [Rvector,S,~]=svds(Rmatrix,1);
         % objective value
         norm_Basis=S/norm(Rmatrix,'fro');
         norm_delta=norm_Basis-norm_opt;
         norm_opt=norm_Basis;
     end
   

     % post-processing
     Rmatrix=reshape(M*mouter(Rvector,order-2),[dim,dim]);
    %Rmatrix=reshape(M*Rvector,[dim,dim]);
     [Rvector,~,~]=svds(Rmatrix,1);
    
    
     %output
     output_vector(:,index)=Rvector;

    output_value(index)=(mouter(Rvector,2)')*reshape(double(T),[dim^2,dim^(order-2)])*mouter(Rvector,order-2);
 
    
     %deflation
     Rspace=Rspace-kron(Rvector,Rvector)*transpose(kron(Rvector,Rvector))*Rspace;
     Rspace=normc(Rspace);
end

end
