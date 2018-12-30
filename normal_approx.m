v_y=var(yy3(2000,:))
k=1
for xbin = -sqrt(v_y)*4 : 0.001 : sqrt(v_y)*4
    normal(k)= exp(-xbin^2/(2*v_y))/sqrt(2*pi*v_y);
    k = k+1;
end
xbin = -sqrt(var(yy3(2000,:)))*4 : 0.001 : sqrt(var(yy3(2000,:)))*4
[n1, x1] = hist(yy3(2000,:), xbin)
z=trapz(x1,n1);
figure
bar(x1,n1/z, 'hist')
hold on 
plot(xbin,normal,'r')

