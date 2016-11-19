function M=SymTensor(d,k)


if k==3
    nvalue=0;
M=zeros(d*ones([1,k]));
for i1=1:d
for i2=1:i1
    for i3=1:i2
                     A=perms([i1,i2,i3]);
                     s=size(A);
                     nvalue=nvalue+1;
                for n=1:s(1)
                      M(A(n,1),A(n,2),A(n,3))=nvalue;
                end
            end
        end
end


elseif k==4
    nvalue=0;
M=zeros(d*ones([1,k]));
for i1=1:d
for i2=1:i1
    for i3=1:i2
        for i4=1:i3
                     A=perms([i1,i2,i3,i4]);
                     s=size(A); 
                     nvalue=nvalue+1;
                for n=1:s(1)
                      M(A(n,1),A(n,2),A(n,3),A(n,4))=nvalue;
                end
            end
        end
        end
end

   


elseif k==5
    nvalue=0;
M=zeros(d*ones([1,k]));
for i1=1:d
for i2=1:i1
    for i3=1:i2
        for i4=1:i3
            for i5=1:i4
                     A=perms([i1,i2,i3,i4,i5]);
                     s=size(A);
                     nvalue=nvalue+1;
                for n=1:s(1)
                      M(A(n,1),A(n,2),A(n,3),A(n,4),A(n,5))=nvalue;
                end
            end
        end
        end
   end
end
   


elseif k==6
    nvalue=0;
M=zeros(d*ones([1,k]));
for i1=1:d
for i2=1:i1
    for i3=1:i2
        for i4=1:i3
            for i5=1:i4
                for i6=1:i5
                     A=perms([i1,i2,i3,i4,i5,i6]);
                     s=size(A);
                     nvalue=nvalue+1;
                for n=1:s(1)
                      M(A(n,1),A(n,2),A(n,3),A(n,4),A(n,5),A(n,6))=nvalue;
                end
            end
        end
        end
   end
end
end


elseif k==7
    nvalue=0;
M=zeros(d*ones([1,k]));
for i1=1:d
for i2=1:i1
    for i3=1:i2
        for i4=1:i3
            for i5=1:i4
                for i6=1:i5
                    for i7=1:i6
                     A=perms([i1,i2,i3,i4,i5,i6,i7]);
                     s=size(A);
                     nvalue=nvalue+1;
                for n=1:s(1)
                      M(A(n,1),A(n,2),A(n,3),A(n,4),A(n,5),A(n,6),A(n,7))=nvalue;
                end
            end
        end
        end
   end
end
end
end


elseif k==8
    nvalue=0;
M=zeros(d*ones([1,k]));
for i1=1:d
for i2=1:i1
    for i3=1:i2
        for i4=1:i3
            for i5=1:i4
                for i6=1:i5
                    for i7=1:i6
                        for i8=1:i7
                     A=perms([i1,i2,i3,i4,i5,i6,i7,i8]);
                     s=size(A);
                     nvalue=nvalue+1;
                for n=1:s(1)
                      M(A(n,1),A(n,2),A(n,3),A(n,4),A(n,5),A(n,6),A(n,7),A(n,8))=nvalue;
                end
            end
        end
        end
   end
end
end
end
end
end

end


















                