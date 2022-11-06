close all;
clear;
clc;

N=50; % Number of Squirrels

Function_name='F1'; % Name of the test function that can be from F1 to F23 (Table 1,2,3 in the paper)

Max_iter=200; % Maximum number of iterations

% Load details of the selected benchmark function
[lb,ub,dim,fobj]=Get_Functions_details(Function_name);
[bestfit,BestPositions,fmax,SSA_Cg_curve]=SSA(N,Max_iter,lb,ub,dim,fobj);
figure('position',[500 500 660 290])

%Draw search space
subplot(1,2,1);
func_plot(Function_name);
title('Parameter space')
xlabel('x_1');
ylabel('x_2');
zlabel([Function_name,'( x_1 , x_2 )'])

%Draw objective space
subplot(1,2,2);
semilogy(SSA_Cg_curve,'Color','r')
title('Objective space')
xlabel('iteration');
ylabel('Best fitness obtained so far');
axis tight
grid on
box on
legend('SSA')

display(['The best solution obtained by Squirrels is : ', num2str(BestPositions)]);
display(['The best optimal value of the objective funciton found by SSA is : ', num2str(bestfit)]);
