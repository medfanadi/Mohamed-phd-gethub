function [conf] = IK_RX90(p,R,q_k)

    % p : End-effector position
    % R : End-effector orientation
    % q_k : Current configuration

    % There are 8 solutions to the IK of an RX90
    % We will store them in 8x6 array (one solution per line)

    % Get RX90 data (length and DH params)
    [L2,L3,L6,dh] = RX90data;
    
    % Compute 04 position in R0
    p4 = p - R*[0;0;L6];
    
    %% Solve for theta1
    theta1 = atan2(p4(2),p4(1));
    
    q(1:4,1) = theta1;
    q(5:8,1) = theta1 + pi;
    %%
    
    %% Solve for theta2 and theta3
    A = 2*p4(3)*L2;
    C0 = L3*L3-p4(3)*p4(3)-L2*L2;
     
    for(i=1:8)
        lambda(i) = p4(1)*cos(q(i,1))+p4(2)*sin(q(i,1));
        B = -2*lambda(i)*L2;
        C = C0 - lambda(i)*lambda(i);
        
        eps = (-1)^i;
        
        inter = sqrt(A*A+B*B-C*C);
        q(i,2) = atan2(A*C-eps*B*inter,B*C+eps*A*inter);
        q(i,3) = atan2(-p4(3)*sin(q(i,2))+lambda(i)*cos(q(i,2))-L2,p4(3)*cos(q(i,2))+lambda(i)*sin(q(i,2)));
    end
    %%
    
    %% Solve for theta5, theta4 and theta6
    T06(1:3,1:3) = R;
    T06(1:3,4) = p;
    T06(4,:) = [0 0 0 1];
    
    % Solution 1,2,5,6
    i = 4;
    while(i<7)
        
        TH01 = TH(q(i,1),dh(1,:));
        TH12 = TH(q(i,2),dh(2,:));
        TH23 = TH(q(i,3),dh(3,:));
        T  = inv(TH01*TH12*TH23)*T06;

        % theta5 and theta4
        q(i,5) = atan2(sqrt(T(1,3)*T(1,3)+T(2,3)*T(2,3)),T(3,3));
    
        if(sin(q(i,5))==0)
            q(i,4) = q_k(4);
        else
            q(i,4) = atan2(T(2,4),T(1,4));
        end
        
        % theta6
        TH34 = TH(q(i,4),dh(4,:));
        TH45 = TH(q(i,5),dh(5,:));
        V  = inv(TH34*TH45)*T;
        
        q(i,6) = atan2(V(2,1),V(1,1));
               
        if(i==2)
            i = 5;
        else
            i = i+1;
        end 
    end
    
    % Solution 3,4,7,8
    i = 3;
    while(i<9)
        
        q(i,4) = q(i-2,4) + pi;
        q(i,5) = -q(i-2,5);
        q(i,6) = q(i-2,6) + pi;
        
        if(i==4)
            i = 7;
        else
            i = i+1;
        end 
    end    
    %%
    
    %% All angles in [-pi;pi]
    q = mod(q,2*pi);
    
    for(i=1:8)
        for(j=1:6)
            if(abs(q(i,j)) > pi)
                q(i,j) = q(i,j) - 2*sign(q(i,j))*pi;
            end
        end
    end
    
    q
    
    %% Choose configuration closest to the joint limits middle range
%     qmiddle = [0;-pi/2;pi/2;0;0;0];
%     
%     norme_min = inf;
%         
%     for(i=2:8)
%         
%         norme = norm(qmiddle-q(i,:)');
%         
%         if(norme < norme_min)
%             norme_min = norme;
%             k = i;
%         end
%     end
    %%
    
    k=4
    
    conf = q(k,:)';

end

% For p_E = [-0.45;0;0.55] and R_E = [0 0 1; 0 1 0; -1 0 0]
% q =
%   3.1416e+00  -1.3126e+00   2.6251e+00   3.1416e+00   2.8833e+00  -2.6645e-15
%   3.1416e+00  -2.5824e-01   5.1649e-01   3.1416e+00   1.8290e+00            0
%   3.1416e+00  -1.3126e+00   2.6251e+00  -2.6645e-15  -2.8833e+00   3.1416e+00
%   3.1416e+00  -2.5824e-01   5.1649e-01            0  -1.8290e+00   3.1416e+00
%            0  -2.8833e+00   2.6251e+00  -1.7764e-15   1.8290e+00            0
%            0  -1.8290e+00   5.1649e-01  -4.4409e-15   2.8833e+00  -3.5527e-15
%            0  -2.8833e+00   2.6251e+00   3.1416e+00  -1.8290e+00   3.1416e+00
%            0  -1.8290e+00   5.1649e-01   3.1416e+00  -2.8833e+00   3.1416e+00
