clc
close all
clear

%% define parameters here 
rc = 0.058;
% ABS PP N DAR
EVal = [2.241e9,3.000e9,3.102e9,2.930e9];
d = 0.254e-03;
c = 0.035;
density = 1000;
f = 1.9;
Rc = 0.017;

LbVal = NaN(100,100);
tol = 1e-8;
for j = 1:length(EVal)
    i = 1;
    E = EVal(j);
    RHS = (E*(d^2)*(c^4))/(4*density*(pi^2)*(f^2)*(Rc^2));
    for Lb = 1e-03:1e-05:200e-3
        LHS = (Lb^4)*((rc^2)+2*Lb*rc+(Lb^2));
        diff = abs(LHS-RHS);
        if diff < tol
            LbVal(j,i) = Lb;
            i = i+1;
        end
    end
    fprintf("Lb = "+num2str((max(LbVal(j,:))+min(LbVal(j,:)))/2*1000)+" mm \n")
end
