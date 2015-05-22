function mquad = quad()
    function f = quadrun(num, preal, xreal)
        function f1 = fun(x)
            m = x(1);
            n = x(2);
            sum = 0;
            for k = 1:num
                sum = sum + (2 * m * xreal(k) + n + preal(k) - x(k + 2))^2 + (-x(k + 2) * xreal(k))^2;
            end
            f1 = sum;
        end
        a_ineq = -eye(num + 2);
        a_ineq(1, 1) = 0;
        a_ineq(2, 2) = 0;
        b_ineq = zeros(num + 2, 1);
        f = fmincon(@fun, b_ineq, a_ineq, b_ineq);
    end
    a = 1;
    b = -10;
    num = 100;
    p_inf = 2;
    p_sup = 8;
    delta = (p_sup - p_inf) / num;
    preal = zeros(num, 1);
    xreal = preal;
    old_fun = @(x)a * x^2 + b * x;
    for k = 1:num
        preal(k) = p_inf + k * delta;
        xreal(k) = fmincon(@(x)preal(k) * x + old_fun(x), 0, [], [], [], [], 0, inf);
    end
    res = quadrun(num, preal, xreal);
    new_fun = @(x)res(1) * x^2 + res(2) * x;
    x = 1:10000;
    y = x;
    z = x;
    for i = 1:10000
        y(i) = old_fun(x(i));
        z(i) = new_fun(x(i));
    end
    hold on;
    plot(x,y,'b');
    plot(x,z,'g');
    mquad = 0;
end