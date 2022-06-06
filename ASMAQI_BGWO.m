%proposed quantum inspired gray wolf optimization **ASMAA EL_ASHRY
function [fitness , weights]=ASMAQI_BGWO(max_iteration,dim,agents)

alpha_qubit=[1/sqrt(2);(1/sqrt(2))];
beta_qubit=[1/sqrt(2);(1/sqrt(2))];
delta_qubit=[1/sqrt(2);(1/sqrt(2))];

alpha_pos=zeros(1,dim);
beta_pos=zeros(1,dim);
delta_pos=zeros(1,dim);

best_pos=rand(agents,dim);

alpha_fittness=inf;
beta_fittness=inf;
delta_fittness=inf;

gamma_alpha=0;
gamma_beta=0;
gamma_delta=0;

%Convergence_curve=zeros(max_iteration,1);
  t=1;
  while t<=max_iteration  
                      
               for L=1:size(best_pos,1)
                best_solution_fittness=AccSz(best_pos(L,:)); 
                %step 7- rearrange the wolves to get the best solution and
                %get new values for gammas
                          if  best_solution_fittness < alpha_fittness                           
                            alpha_fittness=best_solution_fittness;
                            alpha_pos= best_pos(L,:);
                            %gamma_alpha update value 
                            gamma_alpha=1;
                            gamma_beta=sum(beta_pos)/size(beta_pos,2);
                            gamma_delta=sum(delta_pos)/size(delta_pos,2);
                             
                           elseif best_solution_fittness>alpha_fittness && best_solution_fittness<beta_fittness
                              beta_fittness=best_solution_fittness;
                              beta_pos=best_pos(L,:);
                              gamma_beta=1;
                              gamma_delta=sum(delta_pos)/size(delta_pos,2);
                              gamma_alpha=sum(alpha_pos)/size(alpha_pos,2);
                       
                            elseif best_solution_fittness>alpha_fittness&&best_solution_fittness>beta_fittness&& best_solution_fittness<delta_fittness
                             delta_fittness=best_solution_fittness ;
                             delta_pos=best_pos(L,:);
                             gamma_delta=1;
                             gamma_alpha=sum(alpha_pos)/size(alpha_pos,2);
                             gamma_beta=sum(beta_pos)/size(beta_pos,2);
                          end
               end
                for k=1:size(best_pos,1)  
                    
                   % theta_magnitude=theta_max*(theta_max-theta_min)*(t/max_iteration);  
                    
                    for d=1:size(best_pos,2)
                        
                          %update alpha wolf position using qubit
                          theta_magnitude=rand()*pi;
                          theta_angle=theta_magnitude*sum(((gamma_alpha.*alpha_pos)- best_pos(k,d)))*2*pi;   
                          alpha_qubit=Q_Rotation(theta_angle,alpha_qubit(1),alpha_qubit(2));
                          alpha_pos(1,d)=alpha_pos(1,d)*alpha_qubit(2)^2;
                          %make alpha wolf position take binary value
                          if alpha_pos(1,d)>=alpha_qubit(2)^2
                          alpha_pos(1,d)=1;
                          else 
                          alpha_pos(1,d)=0;
                          end
                          %update beta wolf position using qubit
                          theta_magnitude=rand()*pi;
                          theta_angle=theta_magnitude*sum(((gamma_beta.*beta_pos)- best_pos(k,d)))*2*pi;   
                          beta_qubit=Q_Rotation(theta_angle,beta_qubit(1),beta_qubit(2));
                          beta_pos(1,d)= beta_pos(1,d)*beta_qubit(2)^2;
                          
                          %make beta wolf position take binary value
                           if beta_pos(1,d)>=beta_qubit(2)^2
                           beta_pos(1,d)=1;
                           else
                           beta_pos(1,d)=0;
                           end
                          %update delta wolf position using qubit
                           theta_magnitude=rand*pi; 
                          theta_angle=theta_magnitude*sum(((gamma_delta.*delta_pos)- best_pos(k,d)))*2*pi;   
                          delta_qubit=Q_Rotation(theta_angle,delta_qubit(1),delta_qubit(2));
                          delta_pos(1,d)= delta_pos(1,d)*delta_qubit(2)^2;
                          
                          %make delta wolf position take binary value
                         if delta_pos(1,d)>=delta_qubit(2)^2
                          delta_pos(1,d)=1;
                          else 
                          delta_pos(1,d)=0;
                         end 
                         sigm_result=sigmoid((alpha_pos(d)+beta_pos(d)+delta_pos(d)));
                         if sigm_result>rand
                          best_pos(k,d)=1;
                         else
                             best_pos(k,d)=0;
                         end
                    end
                       
                end
                     fitness=alpha_fittness;
                     weights=alpha_pos;
                     disp(['Iteration ' num2str(t) ' Best Cost = ' num2str(alpha_fittness)]);
                     t=t+1;
                     Convergence_curve(t)=fitness;
                     plot(Convergence_curve);
                    
                   
  end  
    
    
    
end
             
