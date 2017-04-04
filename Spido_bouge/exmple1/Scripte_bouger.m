%% Scripte de déplacelemnt du robot 


% %% Clean up the workspace and existing figures
% clear all;
% close all;
% clc;
% 
% %% Paramètres du robot
% %position du cdg
% a=1.2;
% b=1.2;
% 
% %masse et momet d'inertie
% masse=700;
% moment=400*(1.2^2+0.7^2)/12;

% stabilisation traj d'un point contraint

% clear all, clf;
% Tfin=6;
% dt=0.01;
% TSPAN=linspace(0,Tfin,Tfin/dt);

%coef graphique
coef=0.001;

% le robot
a=1200; b=1200; l=1500;  % longueur, largeur, position de C
% les roues
r=500; e=200; % rayon et epaisseur
%la roue folle 
d=700;

% Conditions Initiales

XPOS=0;
YPOS=0;
alpha=0;
psi=0; %angle roue folle

% cond initiales robot reference

XR=0;
YR=0;
psiR=0;

% ETATinit=[XPOS,YPOS,alpha,psi,0,XR,YR,psiR];

%integrer paramètres d'etat
%  [T,ETAT]=ode23('modelPC',TSPAN,ETATinit);
 
 
 %%% affichage 

%qques réglages graphiques
x=zeros(1,5);
y=zeros(1,5);
h2=plot(x,y,'-');
axis([-5 5 -5 5 ]);
axis square;
grid on;

set(h2,'EraseMode','xor','LineWidth',2);

for i=1:length(beta)
 
    XPOS=pos_cal(1,1,i);
    YPOS=pos_cal(1,2,i);
    psi=pos_cal(1,3,i);
    betaf=beta(i,1);
    betar=beta(i,2);
    %% Calcul des points graphiques du robot
    %la roue folle 
    
%     auxX=[0,d-r,d-r,d+r,d+r,d-r,d-r,0];
%     auxY=[0,0,-e/2,-e/2,e/2,e/2,0,0];
% auxX=[0,d-r,d-r,d+r,d+r,d-r,d-r,0]
%     auxY=[0,0,-e/2,-e/2,e/2,e/2,0,0];
%     mat=[cos(psi),-sin(psi);sin(psi),cos(psi)];
%     
%     auxi=mat*[auxX;auxY]; auxX0=auxi(1,:); auxY0=auxi(2,:);
%     
    %La roue (wheel rear right)
    RX11=[0,r,r,-r,-r,0];
    RY11=[0,0,-e,-e,0,0];
 
    mat_r=[cos( betar),-sin(betar);sin(betar),cos(betar)];


    auxi=mat_r*[RX11;RY11];RX1=auxi(1,:); RY1=auxi(2,:);
    
    %La roue (wheel rear left)
    RX22=[0,r,r,-r,-r,0];
    RY22=[0,0,e,e,0,0];
    


    auxi=mat_r*[RX22;RY22];RX2=auxi(1,:); RY2=auxi(2,:);
    
    %La roue (wheel front right)
    RX33=[0,r,r,-r,-r,0];
    RY33=[0,0,e,e,0,0];
    
    mat_f=[cos(betaf),-sin(betaf);sin(betaf),cos(betaf)];


    auxi=mat_f*[RX33;RY33];RX3=auxi(1,:); RY3=auxi(2,:);
    %La roue (wheel front left)
    RX44=[0,r,r,-r,-r,0];
    RY44=[0,0,-e,-e,0,0];
    


    auxi=mat_f*[RX44;RY44];RX4=auxi(1,:); RY4=auxi(2,:);
 
   % Graphe de robot
    auxX=[RX1-a,RX2-a,RX3+b,RX4+b,-a];
    auxY=[RY1-l/2+e/2,RY2+l/2-e/2,RY3+l/2-e/2,RY4-l/2+e/2,-l/2+e/2];
    
    ROT = [cos(psi),-sin(psi);sin(psi),cos(psi)];
    auxi=ROT*[auxX;auxY]+[XPOS*ones(1,size(auxX,2));YPOS*ones(1,size(auxX,2))]; 

    PRX=coef*auxi(1,:); 
    PRY=coef*auxi(2,:);
    
    set(h2,'XData',PRX,'YData',PRY);
%     hold on
%     plot(pos_cal(1,1,i),pos_cal(1,2,i))
    
    %if (i==1) pause(0.1); else pause(0.1*(T(i)-T(i-1))); end
    pause(1/20000);
    i
end

