function dydt = systdyn_5modes(t, y, res, g, z, s)
%SYSTDYN_5MODES Fonction de mise a jour des p et dp pour un systeme a 5
%modes
% g : gamma
% z : zeta
% s : sigma, pour pas diviser par 0

w1 = res(1,1); F1 = res(1,2); Q1 = res(1,3);
w2 = res(2,1); F2 = res(2,2); Q2 = res(2,3);
w3 = res(3,1); F3 = res(3,2); Q3 = res(3,3);
w4 = res(4,1); F4 = res(4,2); Q4 = res(4,3);
w5 = res(5,1); F5 = res(5,2); Q5 = res(5,3);

dudt = ((y(2) + y(4) + y(6) + y(8) + y(10))*z*(g - y(1) - y(3) - y(5) - y(7) - y(9)))/(s + (g - y(1) - y(3) - y(5) - y(7) - y(9))^2)^(1/4) + ((-y(2) - y(4) - y(6) - y(8) - y(10))*z*(1 - g + y(1) + y(3) + y(5) + y(7) + y(9)))/(s + (g - y(1) - y(3) - y(5) - y(7) - y(9))^2)^(1/4) - ((-y(2) - y(4) - y(6) - y(8) - y(10))*z*(g - y(1) - y(3) - y(5) - y(7) - y(9))^2*(1 - g + y(1) + y(3) + y(5) + y(7) + y(9)))/(2*(s + (g - y(1) - y(3) - y(5) - y(7) - y(9))^2)^(5/4));

dydt1 = [y(2); -(w1/Q1)*y(2) - w1^2*y(1) + F1*dudt];
dydt2 = [y(4); -(w2/Q2)*y(4) - w2^2*y(3) + F2*dudt];
dydt3 = [y(6); -(w3/Q3)*y(6) - w3^2*y(5) + F3*dudt];
dydt4 = [y(8); -(w4/Q4)*y(8) - w4^2*y(7) + F4*dudt];
dydt5 = [y(10); -(w5/Q5)*y(10) - w5^2*y(9) + F5*dudt];

dydt = [dydt1;dydt2;dydt3;dydt4;dydt5;g;z];
end