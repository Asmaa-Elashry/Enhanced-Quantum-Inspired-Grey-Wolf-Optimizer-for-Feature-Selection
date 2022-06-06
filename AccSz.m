
function y=AccSz(x)
global A trn vald
SzW=0.01;
x=x>0.5;
x=cat(2,x,zeros(size(x,1),1));
x=logical(x);

if sum(x)==0
    y=inf;
    return;
end
c = knnclassify(A(vald,x),A(trn,x),A(trn,end),5);
cp = classperf(A(vald,end),c);
y=(1-SzW)*(1-cp.CorrectRate)+SzW*sum(x)/(length(x)-1);

