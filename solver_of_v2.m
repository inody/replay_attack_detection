%solver of valiance balance equation
%vy:valinace
%d:quantization interval
%hl2:l2-norm of impulse response
%tau:mesh of solver
function solf = solver_of_v2(heta, d, vs, vd, hd)
    vmax = vs*100;
    
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

    j=0;
    for v = 0: vs: vmax;
        j=j+1
        for i = 1: size(w,2)
            fun(i) = xi(i)*exp(-w(i)^2/(2*v))/sqrt(2*pi*v);
        end
        i_v(j) = v;
        f_v(j) = trapz(w,fun);
    end
    [y,sgmu] = min(abs(heta^2*f_v + hd^2*vd - i_v));
    figure
    plot(abs(heta^2*f_v + hd^2*vd - i_v))
solf = sgmu*vs;
