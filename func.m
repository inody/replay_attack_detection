%solver of valiance balance equation
%vy:valinace
%d:quantization interval
%hl2:l2-norm of impulse response
%tau:mesh of solver
function f = func(variance, d, vs)
    
    imax = 2;
    w = vs:vs:d;
    for i = 1: size(w,2)
       xi(i) = - w(i)^2 + w(i)*d;
    end
    for i = 1:imax
        xi = horzcat(xi, xi);
        i = i+1;
    end
    w = - (d)*2^(imax-1)+vs : vs : (d)*2^(imax-1);

    for i = 1: size(w,2)
        fun(i) = xi(i)*exp(-w(i)^2/(2*variance))/sqrt(2*pi*variance);
    end
        f_v = trapz(w,fun);
f = f_v;

