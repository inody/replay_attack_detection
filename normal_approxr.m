v_r=var(rr(1000,:))
k=1
for xbin3 = -sqrt(v_r)*4 : 0.001 : sqrt(v_r)*4
    normal3(k)= exp(-xbin3^2/(2*v_r))/sqrt(2*pi*v_r);
    k = k+1;
end
xbin3 = -sqrt(var(rr(1000,:)))*4 : 0.001 : sqrt(var(rr(1000,:)))*4
[n3, x3] = hist(rr(1000,:), xbin3)
z=trapz(x3,n3);
figure
bar(x3,n3/z, 'hist')
hold on 
plot(xbin3,normal3,'r')
hold off