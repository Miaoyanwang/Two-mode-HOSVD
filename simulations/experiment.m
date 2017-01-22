randn('seed',0);
%rgn('seed');

ordervector=[5];
sigmavector=[0.0015,0.0025,0.0035,0.0045,0.0055]; %% order 5
ordervector=[4];
sigmavector=[0.008,0.010,0.012,0.014,0.016];%% order 4

ordervector=[3,4,5];
sigmavector=[0,0.01,0.02,0.03,0.04,0.05;0,0.011,0.012,0.013,0.014,0.015;0,0.001,0.002,0.003,0.004,0.005]; %% order 5
  
ordervector=[3];
sigmavector=[0.01,0.015,0.02,0.025,0.03];

p=50;
type='Gaussian';
tries=50;
rankvector=[2,10,25];


outfile=sprintf('PowerErrorDistributionD%dsigma.txt',p);
out = fopen(outfile, 'a');
outfile_time=sprintf('PowertimeDistributionD%dsigma.txt',p);
out_time = fopen(outfile_time, 'a');

outfile2=sprintf('HOSVDErrorDistributionD%dsigma.txt',p);
out2 = fopen(outfile2, 'a');
outfile_time2=sprintf('HOSVDtimeDistributionD%dsigma.txt',p);
out_time2 = fopen(outfile_time2, 'a');

outfile3=sprintf('OJDErrorDistributionD%dsigma.txt',p);
out3 = fopen(outfile3, 'a');
outfile_time3=sprintf('OJDtimeDistributionD%dsigma.txt',p);
out_time3 = fopen(outfile_time3, 'a');





for order=ordervector;
M = SymTensor(p,order);
%filename=sprintf('D%dK%d.mat',p,order);
%load(filename,'M');
Vsvd=eye(p);
for k=rankvector
    for sigma=sigmavector(order-2,:)
fprintf('dim \t rank \t sigma\t meanerror \t sderror\n order %d\t rank%d %.4f',order,k,sigma);

TCell = cell(tries,1);
VCell = cell(tries,1);
V_true = Vsvd(:,1:k);
T_true=zeros([p^order,1]);
for ncol=1:k
T_true=T_true+mouter(V_true(:,ncol),order);
end
T_true=reshape(T_true,p*ones([1,order]));



fprintf(out,'%f\t%f\t%f\t%.4f\t',p,order,k,sigma);
fprintf(out_time,'%f\t%f\t%f\t%.4f\t',p,order,k,sigma);

fprintf(out2,'%f\t%f\t%f\t%.4f\t',p,order,k,sigma);
fprintf(out_time2,'%f\t%f\t%f\t%.4f\t',p,order,k,sigma);

fprintf(out3,'%f\t%f\t%f\t%.4f\t',p,order,k,sigma);
fprintf(out_time3,'%f\t%f\t%f\t%.4f\t',p,order,k,sigma);


for t=1:tries

R = normrnd(0,sigma,[max(reshape(M,[1,p^order])),1]);
T_noise=R(M);    
T_noise=tensor(T_noise);
lambda=rand(1,k)*0.4+0.8;
%tic;
T=tensor(T_true)+T_noise;
%A=T_true+double(T_noise);
%toc;

TCell{t, 1} = T;
VCell{t, 1} = V_true;

tic;
    [V_tpm, ~, N] = tpm_extend(TCell{t,1}, 1, p, k,order);
toc;
    fprintf(out_time,'%f\t',toc);

    V_true = VCell{t,1};
    sum_err = 0.0;
    for x=1:size(V_true,2)
        V_1 = repmat(V_true(:,x), 1, size(V_tpm,2));
        sum_err = sum_err + min(min([sqrt(sum((V_tpm - V_1).^2,1)); sqrt(sum((V_tpm + V_1).^2,1))]));
    end
    fprintf(out,'%f\t',sum_err/size(V_true,2));




%%HOSVD
tic;
    [V_HOSVD]=HOSVD_extend(TCell{t,1},k,p,order);
toc;
fprintf(out_time2,'%f\t',toc);
sum_err = 0.0;
    for x=1:size(V_true,2)
        V_1 = repmat(V_true(:,x), 1, size(V_HOSVD,2));
        sum_err = sum_err + min(min([sqrt(sum((V_HOSVD - V_1).^2,1)); sqrt(sum((V_HOSVD  + V_1).^2,1))]));
    end
    fprintf(out2,'%f\t',sum_err/size(V_true,2));



%Joint Diagonalization 
    if p >= 200
        L = 20;
    elseif p >= 100 && p < 200
        L = 10;
    else
        L = 5;
    end
    
    tic;
[V_tjd, ~, misc] = tenfact_extend(TCell{t,1}, L, k,order);
toc;
 fprintf(out_time3,'%f\t',toc);
 
    sum_err = 0.0;
    for x=1:size(V_true,2)
        V_1 = repmat(V_true(:,x), 1, size(V_tjd,2));
        sum_err = sum_err + min(min([sqrt(sum((V_tjd - V_1).^2,1)); sqrt(sum((V_tjd + V_1).^2,1))]));
    end
 fprintf(out3,'%f\t',sum_err/size(V_true,2));
end


fprintf(out,'\n');
fprintf(out_time,'\n');

fprintf(out2,'\n');
fprintf(out_time2,'\n');

fprintf(out3,'\n');
fprintf(out_time3,'\n');
end
end
end



