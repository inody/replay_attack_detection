clear;
close all;

Ts = 0.01;                   %�?
d = 2;                       %ʎq

A1 = [0 4;
     -3 2];
B1 = [0;
      1];
C1 = -[0.3 4];
sys1 = ss(A1,B1,C1,0); %VXeƂ�?
sd1 = c2d(sys1,Ts);     %U
Ad1 = sd1.a;
Bd1 = sd1.b;
L1 = [2.9;
      -0.7];    %IuU[õQC݌v
K1 = [0.5, 5];

At1 = [Ad1 -Bd1*K1;
       L1*C1 Ad1-Bd1*K1-L1*C1];
Bt1 = [Bd1;
       Bd1];
Kt1 = [zeros(size(K1)) -K1];
syseta1r = ss(At1,Bt1,Kt1,0,Ts);
normeta1r = norm(syseta1r);
vr = solver_of_v(normeta1r, d, 0.00005)
veta1 = func(vr, d, 0.00005)


At2 = [Ad1 -Bd1*K1 zeros(size(Ad1));
       L1*C1 Ad1-Bd1*K1-L1*C1 zeros(size(Ad1));
       L1*C1 zeros(size(Ad1)) Ad1-Bd1*K1-L1*C1];
Bt2_1 = [zeros(size(Bd1));
       zeros(size(Bd1));
       Bd1];
Bt2_2 = [Bd1;
       Bd1;
       zeros(size(Bd1))];
Kt2 = [zeros(size(K1)) zeros(size(K1)) -K1];
Ct2 = [C1 zeros(size(C1)) -C1];
syseta1r2 = ss(At2, Bt2_2, Kt2, 0, Ts);
normeta1r2 = norm(syseta1r2);
syseta2r2 = ss(At2, Bt2_1, Kt2, 0, Ts);
normeta2r2 = norm(syseta2r2);
vr2 = solver_of_v2(normeta2r2, d, 0.0001, veta1, normeta1r2)
veta2 = func(vr2, d, 0.0001)

syseta1e2 = ss(At2, Bt2_2, Ct2, 0, Ts);
normeta1e2 = norm(syseta1e2);
syseta2e2 = ss(At2, Bt2_1, Ct2, 0, Ts);
normeta2e2 = norm(syseta2e2);
ve = normeta1e2^2*veta1 + normeta2e2^2*veta2
