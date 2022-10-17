clear; clc;close;

p0 = [0,0,0];

r0 = [45,0,0];
r0 = r0/180*pi;
rmat0 = calc_rmat(r0(1), r0(2), r0(3));


p1 = [0,10,0];
r1 = [0, 45, 0];
r1 = r1/180*pi;
rmat1 = calc_rmat(r1(1), r1(2), r1(3));

p2 = [0, 10, 0];
r2 = [0, 0, 45];
r2 = r2/180*pi;
rmat2 = calc_rmat(r2(1), r2(2), r2(3));

p3 = [0, 10, 0];
r3 = [0, 0, 90];
r3 = r3/180*pi;
rmat3 = calc_rmat(r3(1), r3(2), r3(3));

p1_0 = p0' + rmat0*p1';
p2_0 = p1_0 + rmat0*rmat1*p2';
p3_0 = p2_0 + rmat0*rmat1*rmat2*p3';

figure(222)
hold on

line1 = [p0', p1_0];
plot3(line1(1,:), line1(2,:), line1(3,:), 'k')
line2 = [p1_0, p2_0];
plot3(line2(1,:), line2(2,:), line2(3,:), 'r')

line3 = [p2_0, p3_0];
plot3(line3(1,:), line3(2,:), line3(3,:), 'g')

xlabel('x')
ylabel('y')
zlabel('z')