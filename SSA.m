function  [bestfit,BestPositions,fmin,Convergence_curve]=SSA(N,Max_iter,lb,ub,dim,fobj)
%%
Max_iter=2000;          % maximum generations
N=50;                   %numbers of Squirrels
%dim=100;                 
lb=-2*zeros(1,dim);
ub=2*ones(1,dim);
nfs=4;                  %number of food resources
hnt=1;                  %hickory nut tree
ant=3;                  %acorn nut tree
noft=46;                %no food trees


Fmax=1.11;                 %maximum gliding distance
Fmin=0.5;                 %minimum gliding distance
A=rand(N,1);           
r=rand(N,1);            %pulse flying rate for each SSA

% Initializing arrays
F=zeros(N,1);           % Frequency
v=zeros(N,dim);           % Velocities
% Initialize the population
x=initializationb(N,Max_iter,dim,ub,lb);
Convergence_curve=zeros(1,Max_iter);
%calculate the initial solution for initial positions

for ii=1:N
    fitness(ii)=fobj(x(ii,:));
end

%%randomly allotted acorn(1), normal(2), and hickory nut(3) trees 
for inum=1:length(fitness)
    update_ssa(inum)=randi(3);
end
%%
%F is Gliding Distance
Gc=1.9; %Gliding constant
[fmin,index]=min(fitness);          %find the initial best fitness value,
bestsol=x(index,:);                 %find the initial best solution for best fitness value
%%
iter=1;             % start the loop counter
while iter<=Max_iter                               %start the loop for iterations
    for ii=1:size(x)
        if update_ssa(ii) == 1
        F(ii)=Fmin+(Fmax-Fmin)*rand;              %randomly chose the gliding distance
        v(ii,:)=v(ii,:)+F(ii)*Gc*(x(ii,:)-bestsol)*1;  %update the velocity for acorn tree squrrels
        
        x(ii,:)=x(ii,:)+v(ii,:);                  %update the SSA position
        
        elseif update_ssa(ii) == 2
             F(ii)=Fmin+(Fmax-Fmin)*rand;              %randomly chose the gliding distance
        v(ii,:)=v(ii,:)+F(ii)*Gc*(x(ii,:)-bestsol)*2;  %update the for normal tree squrrels
        
        x(ii,:)=x(ii,:)+v(ii,:);                  %update the SSA position
        
            
        else
            
        F(ii)=Fmin+(Fmax-Fmin)*rand;              %randomly chose the gliding distance
        v(ii,:)=v(ii,:)+F(ii)*Gc*(x(ii,:)-bestsol)*3;  %update the velocity for hickory tree squrrels
        
        x(ii,:)=x(ii,:)+v(ii,:);                  %update the SSA position
            
        end
        Flag4up=x(ii,:)>ub;
        Flag4low=x(ii,:)<lb;
        x(ii,:)=(x(ii,:).*(~(Flag4up+Flag4low)))+ub.*Flag4up+lb.*Flag4low;
        %check the condition with r random numbers
        if rand>r(ii)
            % The factor 0.001 limits the step sizes of random flyes
            eps=-1+(1-(-1))*rand;
            x(ii,:)=bestsol+eps*mean(A);
        end
        fitnessnew=fobj(x(ii,:));  % calculate the objective function
%       
        if fitnessnew<=fmin,
            bestsol=x(ii,:);
            fmin=fitnessnew;
        end
        
    end
    Convergence_curve(iter)=  fmin;
    
    iter=iter+1;                                  % update the while loop counter
end
%
[bestfit]=(fmin);
BestPositions=bestsol;

end
