function[x1]=mouter(x1, k)
r = x1;
    if k>1
    for vi = 1:(k-1) 
        r = kron(r, x1);
    end
    x1=r;
    else
        x1=x1;
    end
    