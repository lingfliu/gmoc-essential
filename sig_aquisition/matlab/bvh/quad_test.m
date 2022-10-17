close all;
clear all;
clc;

%% Initial parameters

% Initial quaternion
Q(1,:)=[1 0 0 0];

% Step time
dt=0.5;

% Initial coordinates of the point
P(1,:)=[1,2,3];
PX(1,:)=[2,2,3];
PY(1,:)=[1,3,3];
PZ(1,:)=[1,2,4];

%% Main loop
for i=2:100

    %% Simulate gyroscope value 
    % pi/8 rad/s  along X axis for the 50 first steps
    % pi/16 rad/s along Y axis for the 50 last steps 
    if (i<50) Sw=[0 pi/8 0 0]; else Sw=[0 0 pi/16 0]; end;

    %% Update orientation
    % Compute the quaternion derivative
    Qdot=quaternProd(0.5*Q(i-1,:),Sw);

    % Update the estimated position
    Q(i,:)=Q(i-1,:)+Qdot*dt;

    % Normalize quaternion
    Q(i,:)=Q(i,:)/norm(Q(i,:));

    %% Update point coordinates
    % Compute the associated transformation marix
    M=quatern2rotMat(Q(i,:));

    % Calculate the coordinate of the new point
    P(i,:)=(M*P(1,:)')';
    PX(i,:)=(M*PX(1,:)')';
    PY(i,:)=(M*PY(1,:)')';
    PZ(i,:)=(M*PZ(1,:)')';

    % Display the new point
    plot3 (P(i,1),P(i,2),P(i,3),'k.');
    plot3 (PX(i,1),PX(i,2),PX(i,3),'r.');
    plot3 (PY(i,1),PY(i,2),PY(i,3),'g.');
    plot3 (PZ(i,1),PZ(i,2),PZ(i,3),'b.');
    line ( [ P(i,1) , PX(i,1) ] , [ P(i,2) , PX(i,2) ],  [ P(i,3) , PX(i,3) ] ,'Color','r');
    line ( [ P(i,1) , PY(i,1) ] , [ P(i,2) , PY(i,2) ],  [ P(i,3) , PY(i,3) ] ,'Color','g');
    line ( [ P(i,1) , PZ(i,1) ] , [ P(i,2) , PZ(i,2) ],  [ P(i,3) , PZ(i,3) ] ,'Color','b');
    hold on;
    axis square equal;
    grid on;
    drawnow;

end

%% Display point trajectory
plot3 (P(:,1),P(:,2),P(:,3),'r.');
axis square equal;
grid on;
xlabel ('x');
ylabel ('y');
zlabel ('z');