clear;
close all;
set(0,'defaulttextinterpreter','latex')
set(0,'defaultAxesFontSize',15)
set(0,'defaultTextFontSize',15)
Ts = 0.01;                   %ﾝ?
T = 10;                      %V~[V
N = 1;                   %Jﾔ?
d = 2;                       %ﾊ子

A1 = [0 4;
     -3 2];
B1 = [0;
      1];
C1 = -[0.3 4];
sys1 = ss(A1,B1,C1,0); %VXeﾆて?
sd1 = c2d(sys1,Ts);     %U
Ad1 = sd1.a;
Bd1 = sd1.b;
L1 = [2.9;
      -0.7];
K1 = -[0.5, 5];

 %ﾊ子ﾈ?
 xi(:,1) = 0.1*[1;
            -1];
 qi(:,1) = 2*xi(:,1);    
 for k = 1:T/Ts
     ui(k) = K1*qi(:,k);
     xi(:,k+1) = Ad1*xi(:,k) + Bd1*ui(k);
     yi(k) = C1*xi(:,k);
     qi(:,k+1) = Ad1*qi(:,k) + Bd1*ui(k) + L1*(yi(k)-C1*qi(:,k));
     ei(:,k+1) = C1*(xi(:,k) - qi(:,k));
 end
 xi2(:,1) = xi(:,T/Ts);
 qi2(:,1) = qi(:,T/Ts);  
 for k = 1:T/Ts
     ui2(k) = K1*qi2(:,k);
     yi2(k) = yi(k);
     qi2(:,k+1) = Ad1*qi2(:,k) + Bd1*ui2(k) + L1*(yi2(k)-C1*qi2(:,k));
     ei2(:,k+1) = yi2(k) - C1*qi2(:,k);
 end
 ei3 = horzcat(ei, ei2);
 yi3 = horzcat(yi, yi2);


 %fBUﾈぬ子
 xq(:,1) = 0.1*[1;
            -1];
 qq(:,1) = 0*xq(:,1);    
 for k = 1:T/Ts
     rq(k) = K1*qq(:,k);
     uq(k) = d*round(rq(k)/d);
     xq(:,k+1) = Ad1*xq(:,k) + Bd1*uq(k);
     yq(k) = C1*xq(:,k);
     qq(:,k+1) = Ad1*qq(:,k) + Bd1*uq(k) + L1*(yq(k)-C1*qq(:,k));
     eq(:,k+1) = C1*(xq(:,k) - qq(:,k));
 end
 xq2(:,1) = xq(:,T/Ts);
 qq2(:,1) = qq(:,T/Ts);  
 for k = 1:T/Ts
     rq2(k) = K1*qq2(:,k);
     uq2(k) = d*round(rq2(k)/d);
     yq2(k) = yq(k);
     qq2(:,k+1) = Ad1*qq2(:,k) + Bd1*uq2(k) + L1*(yq2(k)-C1*qq2(:,k));
     eq2(:,k+1) = yq2(k) - C1*qq2(:,k);
 end
 yq3 = horzcat(yq, yq2);
 eq3 = horzcat(ei, ei2);


%fBUﾊ子
w1 = -d/2 + d*rand(N,T/Ts);  %
w2 = -d/2 + d*rand(N,T/Ts);  %

for n = 1:N
    countL = N-n    %JE^
    
    x(:,1) = 0.1*[1;
              -1];
    q(:,1) = 2*x(:,1);
    for k = 1:T/Ts
        y(k) = C1*x(:,k);
        r(k) = K1*q(:,k);
        u(k) =  d*round((r(k)+w1(n,k))/d);
        eta(k) = u(k) - r(k);
        x(:,k+1) = Ad1*x(:,k) + Bd1*u(k);
        q(:,k+1) = Ad1*q(:,k) + Bd1*u(k) + L1*(y(k)-C1*q(:,k));
        e(:,k+1) = y(k) - C1*q(:,k);
    end
    etaeta(:,n) = eta;
    yy(:,n) = y;
    ee(:,n) = e;
    rr(:,n) = r;
    q2(:,1) = q(:,T/Ts);
    x2(:,1) = x(:,T/Ts);
    for k = 1:T/Ts
        y2(k) = y(k);
        r2(k) = K1*q2(:,k);
        u2(k) = d*round((r2(k)+w2(n,k))/d);
        eta2(k) = u2(k) - r2(k);
        q2(:,k+1) = Ad1*q2(:,k) + Bd1*u2(k) + L1*(y2(k)-C1*q2(:,k));
        e2(:,k+1) = y2(k) - C1*q2(:,k);
    end
    etaeta2(:,n) = eta2;
    yy2(:,n) = y2;
    ee2(:,n) = e2;
    rr2(:,n) = r2;
end
 eta3 = vertcat(etaeta, etaeta2);
 yy3 = vertcat(yy, yy2);
 ee3 = vertcat(ee, ee2);
 rr3 = vertcat(rr, rr2);

 
figure
subplot(3,1,1)
plot(yi3, 'Color', [0,0,0], 'LineWidth', 1)
axis([0 2*T/Ts -1 1])
ylabel('(a)', 'interpreter', 'latex')
xlabel('$$k$$', 'interpreter', 'latex')
subplot(3,1,2)
plot(yq3, 'Color', [0,0,0], 'LineWidth', 1)
axis([0 2*T/Ts -1 1])
ylabel('(b)', 'interpreter', 'latex')
xlabel('$$k$$', 'interpreter', 'latex')
subplot(3,1,3)
plot(yy3(:,1),'Color', [0,0,0], 'LineWidth', 1)
axis([0 2*T/Ts -1 1])
ylabel('(c)', 'interpreter', 'latex')
xlabel('$$k$$', 'interpreter', 'latex')

figure
subplot(3,1,1)
plot(ei3, 'Color', [0,0,0], 'LineWidth', 1)
axis([0 2*T/Ts -max(ee3) max(ee3)])
ylabel('(a)', 'interpreter', 'latex')
xlabel('$$k$$', 'interpreter', 'latex')
subplot(3,1,2)
plot(eq3, 'Color', [0,0,0], 'LineWidth', 1)
axis([0 2*T/Ts -max(ee3) max(ee3)])
ylabel('(b)', 'interpreter', 'latex')
xlabel('$$k$$', 'interpreter', 'latex')
subplot(3,1,3)
plot(ee3, 'Color', [0,0,0], 'LineWidth', 1)
axis([0 2*T/Ts -max(ee3) max(ee3)])
ylabel('(c)', 'interpreter', 'latex')
xlabel('$$k$$', 'interpreter', 'latex')


figure
plot(eq3(1,1010:2000), 'r', 'LineWidth', 2)
axis([0,length([1010:2000]),-max(ee3(1010:2000,1)) max(ee3(1010:2000,1))])
figure
plot(ee3(1010:2000,1), 'b', 'LineWidth', 2)
axis([0,length([1010:2000]),-max(ee3(1010:2000,1)) max(ee3(1010:2000,1))])
%for k = 1:T/Ts
%    vareta(k) = var(etaeta(k,:));
%    vareta2(k) = var(etaeta2(k,:));
%    varr(k) = var(rr(k,:));
%    varr2(k) = var(rr2(k,:));
%    vare(k) = var(ee2(k,:));
%end
%k = 1:T/Ts;
%figure
%plot(k,vareta)
%figure
%plot(k,vareta2)
%figure
%plot(k,varr)
%figureq
%plot(k,varr2)
%figure
%plot(k,vare)


% figure
% hist(eta1(1000,:),100);
% figure
% hist(eta2(1000,:),100);
% figure
% hist(rr(1000,:),100);
% figure
% hist(rr2(1000,:),100);
% figure
% hist(ee2(1000,:),100);