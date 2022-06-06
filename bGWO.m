function [Alpha_score,Alpha_pos]=bGWO(Nagents,NIter,dim,fobj)
%Nagents: Is the number of wolves to be used
%NIter: is the total number of iterations to run the algorithm
%dim: is a scalar representing the problem dimension
%fobj: is a string representing the fitness function

%this code is based on the paper

% E. Emary, Hossam M.Zawbaa, AboulElla Hassanien, Binary
% grey wolf optimization approaches for feature selection, Neurocomputing172(2016)371–381.

Alpha_score=inf;
Beta_score=inf;
Delta_score=inf;

Alpha_pos=zeros(1,dim);
Delta_pos=zeros(1,dim);
Beta_pos=zeros(1,dim);

Positions=initialization(Nagents,dim,1,0)>0.5;
Convergence_curve=zeros(1,NIter);


l=0;
while l<NIter
    for i=1:size(Positions,1)             
        fitness=feval(fobj,Positions(i,:));
        
        if fitness<Alpha_score 
            Alpha_score=fitness;
            Alpha_pos=Positions(i,:);
        end
        
        if fitness>Alpha_score && fitness<Beta_score 
            Beta_score=fitness;
            Beta_pos=Positions(i,:);
        end
        
        if fitness>Alpha_score && fitness>Beta_score && fitness<Delta_score 
            Delta_score=fitness; 
            Delta_pos=Positions(i,:);
        end
    end
    
    
    a=2-l*((2)/NIter);
    
    for i=1:size(Positions,1)
        for j=1:size(Positions,2)     
                       
            r1=rand(); 
            r2=rand();
                
            A1=2*a*r1-a;
            C1=2*r2; 
            
            D_alpha=abs(C1*Alpha_pos(j)-Positions(i,j));
           
            v1=sigmf(-A1*D_alpha,[10, 0.5]);
            if v1<rand
                v1=0;
            else
                v1=1;
            end
            X1=(Alpha_pos(j)+v1)>=1;
                       
            r1=rand();
            r2=rand();
            
            A2=2*a*r1-a;
            C2=2*r2; 
            
            D_beta=abs(C2*Beta_pos(j)-Positions(i,j)); 
            v1=sigmf(-A2*D_beta,[10 0.5]);
            if v1<rand
                v1=0;
            else
                v1=1;
            end
            
            X2=(Beta_pos(j)+v1)>=1 ;
            
            r1=rand();
            r2=rand(); 
            
            A3=2*a*r1-a;
            C3=2*r2;
            
            D_delta=abs(C3*Delta_pos(j)-Positions(i,j));
             v1=sigmf(-A3*D_delta,[10 0.5]);%eq. 25
            if v1<rand
                v1=0;
            else
                v1=1;
            end
            X3=(Delta_pos(j)+v1)>=1;         
            
            Positions(i,j)=CrossOver(X1,X2,X3); %equation 23 in paper
            
        end
        fprintf('%f:\t',Alpha_score);
        fprintf('%d',Alpha_pos(:));
        fprintf('\n');
    end
    l=l+1;    
    Convergence_curve(l)=Alpha_score;
end



