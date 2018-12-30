v_e=var(ee3(2000,:))
k=1
for xbin2 = -sqrt(v_e)*4 : 0.001 : sqrt(v_e)*4
    normal2(k)= exp(-xbin2^2/(2*v_e))/sqrt(2*pi*v_e);
    k = k+1;
end
xbin2 = -sqrt(var(ee3(2000,:)))*4 : 0.001 : sqrt(var(ee3(2000,:)))*4
[n2, x2] = hist(ee3(2000,:), xbin2)
z=trapz(x2,n2);
figure
bar(x2,n2/z, 'hist')
hold on 
plot(xbin2,normal2,'r')
