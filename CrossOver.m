function y=CrossOver(X1,X2,X3)
r=rand(1);
if r<0.333
    y=X1;
elseif r<0.6666
    y=X2;
else
    y=X3;
end