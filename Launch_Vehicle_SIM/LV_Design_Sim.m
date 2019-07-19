%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Simulation of a launch vehicle design activity
%       The activity consists of nine design teams developing three subsystems of a launch vehicle.
%       Each team controls 1 system design variable they are trying to set
%       and each time has an interface to the other teams. Below are the 9
%       variables and the teams associated with them
%
%       Stage 1 team:	
%   Stage 1 thrust – determined by the Stage 1 rocket engine team (team 11)
%	Stage 1 Propellant mass – determined by the Stage 1 tank team (team 12)
%	Stage 1 Structure mass – determined by the Stage 1 structural team
%	(team 13)   
%	Stage 1 diameter – determined by the Stage 1 mechanical team (team 14)
%       Stage 2 team:	
%   Stage 2 thrust – determined by the Stage 2 rocket engine team (team 21)
%	Stage 2 Propellant mass – determined by the Stage 2 tank team (team 22)
%	Stage 2 Structure mass – determined by the Stage 2 structural team
%	(team 23)
%	Stage 2 diameter – determined by the Stage 2 mechanical team (team 24)
%	Vehicle team:
%   Payload mass – determined by the systems analysis team (team 31)
%
%
%
%       The simulation runs both a simulation of the team performing waterfall
%       and agile methods.
%       
%       
%
%       Each cycle represents 1 hour of work 
%
%   
%   Mitch Bott 9-13-18
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% clear simulation variables and MATLAB workspace
clear all;
close all;
clc;

% Load in results from previously run simulation that show which design
% variables result in feasible designs
% File is Successes out of data set.xlsx
    % Column 1 is Stgae 1 thrust 
    % Column 2 is Stage 1 propellant mass
    % Column 3 is Stage 1 structure mass
    % Column 4 is Stage 1 diameter
    % Column 5 is Stgae 2 thrust 
    % Column 6 is Stage 2 propellant mass
    % Column 7 is Stage 2 structure mass
    % Column 8 is Stage 2 diameter
    % Column 9 is payload mass
designdata=xlsread ('Successes out of data set.xlsx','Saver');

% Set random variable stream
rand_seed=23;
stream = RandStream('mlfg6331_64','seed',rand_seed);

% initialize mean design transition matrix for engineers
FBS_mat = [ .608 .392 0 0 0 
0 .3896 .6104 0 0 
0 0 .7342 .2658 0
0 .2759 .3571 .1853 .1816
0 0 0 0 1];


% initialize 3 sigma of transition matrix for engineers
FBS_var = [ .3826 .3826 0 0 0 
0 .5890 .5890 0 0 
0 0 .2602 .2602 0
0 .3647 .0274 .1667 .1706
0 0 0 0 0];




% initialize simulation metrics
iterations=10000;
% t= time, e= effort
% no trailing letter - requirements development
% trailing f - function development
% trailing p - preliminary design
% trailing d - detailed design
% single digit  = team integrators. Integrators lead teams (managers), they are scrum masters in scrum
% Double digit = teams under a team integrator
% pint = program integrator (program manager), scrum of scrum master in
% scrum
% Trailing A - agile
t_pint(iterations)=0;
e_pint(iterations)=0;
t1(iterations)=0;
e1(iterations)=0;
t11(iterations,10)=0;
e11(iterations,10)=0;
t12(iterations,10)=0;
e12(iterations,10)=0;
t13(iterations,10)=0;
e13(iterations,10)=0;
t14(iterations,10)=0;
e14(iterations,10)=0;
t2(iterations)=0;
e2(iterations)=0;
t21(iterations,10)=0;
e21(iterations,10)=0;
t22(iterations,10)=0;
e22(iterations,10)=0;
t23(iterations,10)=0;
e23(iterations,10)=0;
t24(iterations,10)=0;
e24(iterations,10)=0;
t3(iterations)=0;
e3(iterations)=0;
t31(iterations,10)=0;
e31(iterations,10)=0;


t_pintf(iterations)=0;
e_pintf(iterations)=0;
t1f(iterations)=0;
e1f(iterations)=0;
t11f(iterations,10)=0;
e11f(iterations,10)=0;
t12f(iterations,10)=0;
e12f(iterations,10)=0;
t13f(iterations,10)=0;
e13f(iterations,10)=0;
t14f(iterations,10)=0;
e14f(iterations,10)=0;
t2f(iterations)=0;
e2f(iterations)=0;
t21f(iterations,10)=0;
e21f(iterations,10)=0;
t22f(iterations,10)=0;
e22f(iterations,10)=0;
t23f(iterations,10)=0;
e23f(iterations,10)=0;
t24f(iterations,10)=0;
e24f(iterations,10)=0;
t3f(iterations)=0;
e3f(iterations)=0;
t31f(iterations,10)=0;
e31f(iterations,10)=0;


t11p(iterations,10)=0;
e11p(iterations,10)=0;
t12p(iterations,10)=0;
e12p(iterations,10)=0;
t13p(iterations,10)=0;
e13p(iterations,10)=0;
t14p(iterations,10)=0;
e14p(iterations,10)=0;
t21p(iterations,10)=0;
e21p(iterations,10)=0;
t22p(iterations,10)=0;
e22p(iterations,10)=0;
t23p(iterations,10)=0;
e23p(iterations,10)=0;
t24p(iterations,10)=0;
e24p(iterations,10)=0;
t31p(iterations,10)=0;
e31p(iterations,10)=0;

t11d(iterations,10)=0;
e11d(iterations,10)=0;
t12d(iterations,10)=0;
e12d(iterations,10)=0;
t13d(iterations,10)=0;
e13d(iterations,10)=0;
t14d(iterations,10)=0;
e14d(iterations,10)=0;
t21d(iterations,10)=0;
e21d(iterations,10)=0;
t22d(iterations,10)=0;
e22d(iterations,10)=0;
t23d(iterations,10)=0;
e23d(iterations,10)=0;
t24d(iterations,10)=0;
e24d(iterations,10)=0;
t31d(iterations,10)=0;
e31d(iterations,10)=0;


t_pintA(iterations)=0;
e_pintA(iterations)=0;
t1A(iterations)=0;
e1A(iterations)=0;
t2A(iterations)=0;
e2A(iterations)=0;
t3A(iterations)=0;
e3A(iterations)=0;


t11A(iterations,10)=0;
e11A(iterations,10)=0;
t12A(iterations,10)=0;
e12A(iterations,10)=0;
t13A(iterations,10)=0;
e13A(iterations,10)=0;
t14A(iterations,10)=0;
e14A(iterations,10)=0;
t21A(iterations,10)=0;
e21A(iterations,10)=0;
t22A(iterations,10)=0;
e22A(iterations,10)=0;
t23A(iterations,10)=0;
e23A(iterations,10)=0;
t24A(iterations,10)=0;
e24A(iterations,10)=0;
t31A(iterations,10)=0;
e31A(iterations,10)=0;

rf11(4,iterations,10)=0;
rf12(4,iterations,10)=0;
rf13(4,iterations,10)=0;
rf14(4,iterations,10)=0;
rf21(4,iterations,10)=0;
rf22(4,iterations,10)=0;
rf23(4,iterations,10)=0;
rf24(4,iterations,10)=0;
rf31(4,iterations,10)=0;

rf11e(4,iterations,10)=0;
rf12e(4,iterations,10)=0;
rf13e(4,iterations,10)=0;
rf14e(4,iterations,10)=0;
rf21e(4,iterations,10)=0;
rf22e(4,iterations,10)=0;
rf23e(4,iterations,10)=0;
rf24e(4,iterations,10)=0;
rf31e(4,iterations,10)=0;


%% Initialize simulations

% Develop FBS models for each designer - assume 8 designers per team and 4 integrators
[eng] = FBS_Designator(8*9+4, FBS_mat, FBS_var, stream);

% Assign designers to teams of 8
% teams are numbered teamxy - where x is the subsystem and y is the unit
team11 = [1:8];
team12= [(8+1):(8*2)];
team13=[(8*2+1):(8*3)];
team14 = [(8*3+1):(8*4)];

team21 = [(8*4+1):(8*5)];
team22 = [(8*5+1):(8*6)];
team23 = [(8*6+1):(8*7)];
team24 = [(8*7+1):(8*8)];

team31 = [(8*8+1): (8*9)];



% Assign team integrators
t1int = [(8*9+1)];
t2int = [(8*9+2)];
t3int = [(8*9+3)];

% Assign program integrator
pint = [(8*9+4)];
%% Waterfall simulation
for i=1:iterations %Perform 10,000 monte-carlo simulations

% Initialize FBS designer states to requirements
for j=1:(8*9+5)
	for k=1:10
        state_WF(j,:,k)='Rq';
    end
end

%% Perform requirements development

% Top-down requirements flow
%Program integrator requirements development 
[state_WF(pint,:,1), t_new, e_new, rf] = WF_scheduler(eng(:,:,(pint)), state_WF(pint,:,1),'Req',stream,0,0,0);
t_pint(i)=t_pint(i)+t_new;
e_pint(i)=e_pint(i)+e_new;
if sum(rf)~=0
disp('Error: reformulations occur during requirements development');
end

%Team 1 integrator requirements development 
[state_WF(t1int,:,1), t_new, e_new,rf] = WF_scheduler(eng(:,:,(t1int)), state_WF(t1int,:,1),'Req',stream,0,0,0);
t1(i)=t1(i)+t_new;
e1(i)=e1(i)+e_new;
if sum(rf)~=0
disp('Error: reformulations occur during requirements development');
end

%Each subfunction team develops requirements for 10 subfunctions
%team 11 requirements development 

for k=1:10
    [state_WF(team11,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team11)), state_WF(team11,:,k),'Req',stream,0,0,0);
    t11(i,k)=t11(i,k)+t_new;
    e11(i,k)=e11(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during requirements development');
    end
end
%Team 12 requirements development
for k=1:10
    [state_WF(team12,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team12)), state_WF(team12,:,k),'Req',stream,0,0,0);
    t12(i,k)=t12(i,k)+t_new;
    e12(i,k)=e12(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during requirements development');
    end
end
%Team 13 requirements development
for k=1:10
    [state_WF(team13,:,k), t_new,e_new, rf] = WF_scheduler(eng(:,:,(team13)), state_WF(team13,:,k),'Req',stream,0,0,0);
    t13(i,k)=t13(i,k)+t_new;
    e13(i,k)=e13(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during requirements development');
    end
end

%Team 14 requirements development
for k=1:10
    [state_WF(team14,:,k), t_new,e_new, rf] = WF_scheduler(eng(:,:,(team14)), state_WF(team14,:,k),'Req',stream,0,0,0);
    t14(i,k)=t14(i,k)+t_new;
    e14(i,k)=e14(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during requirements development');
    end
end

%Team 2 integrator requirements development 
[state_WF(t2int,:,1), t_new,e_new, rf] = WF_scheduler(eng(:,:,(t2int)), state_WF(t2int,:,1),'Req',stream,0,0,0);
t2(i)=t2(i)+t_new;
e2(i)=e2(i)+e_new;
if sum(rf)~=0
disp('Error: reformulations occur during requirements development');
end


%team 21 requirements development 
for k=1:10
    [state_WF(team21,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team21)), state_WF(team21,:,k),'Req',stream,0,0,0);
    t21(i,k)=t21(i,k)+t_new;
    e21(i,k)=e21(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during requirements development');
    end
end
%Team 22 requirements development
for k=1:10
    [state_WF(team22,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team22)), state_WF(team22,:,k),'Req',stream,0,0,0);
    t22(i,k)=t22(i,k)+t_new;
    e22(i,k)=e22(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during requirements development');
    end
end
%Team 23 requirements development
for k=1:10
    [state_WF(team23,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team23)), state_WF(team23,:,k),'Req',stream,0,0,0);
    t23(i,k)=t23(i,k)+t_new;
    e23(i,k)=e23(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during requirements development');
    end
end

%Team 24 requirements development
for k=1:10
    [state_WF(team24,:,k), t_new,e_new, rf] = WF_scheduler(eng(:,:,(team24)), state_WF(team24,:,k),'Req',stream,0,0,0);
    t24(i,k)=t24(i,k)+t_new;
    e24(i,k)=e24(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during requirements development');
    end
end

%Team 3 integrator requirements development 
[state_WF(t3int,:,1), t_new,e_new, rf] = WF_scheduler(eng(:,:,(t3int)), state_WF(t3int,:,1),'Req',stream,0,0,0);
t3(i)=t3(i)+t_new;
e3(i)=e3(i)+e_new;
if sum(rf)~=0
disp('Error: reformulations occur during requirements development');
end


%team 31 requirements development 
for k=1:10
    [state_WF(team31,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team31)), state_WF(team31,:,k),'Req',stream,0,0,0);
    t31(i,k)=t31(i,k)+t_new;
    e31(i,k)=e31(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during requirements development');
    end
end

%determine total time doing requirements and total effort
% each level of the heirarchy goes in parallel to find total time

t_req_WF(i)=t_pint(i)+max([t1(i) t2(i) t3(i)])+max([sum(t11(i,:)) sum(t12(i,:)) sum(t13(i,:)) sum(t14(i,:)) sum(t21(i,:)) sum(t22(i,:)) sum(t23(i,:)) sum(t24(i,:)) sum(t31(i,:))]);
e_req_WF(i)=e_pint(i)+e1(i)+e2(i)+e3(i)+sum(e11(i,:))+ sum(e12(i,:))+ sum(e13(i,:))+ sum(e14(i,:))+ sum(e21(i,:))+ sum(e22(i,:))+ sum(e23(i,:))+ sum(e24(i,:))+ sum(e31(i,:));%effort is sum of all manhours

% Perform function development

%Program integrator function development 
[state_WF(pint,:,1), t_new, e_new, rf] = WF_scheduler(eng(:,:,(pint)), state_WF(pint,:,1),'Fun',stream,0,0,0);
t_pintf(i)=t_pintf(i)+t_new;
e_pintf(i)=e_pintf(i)+e_new;
if sum(rf)~=0
disp('Error: reformulations occur during function development');
end

%Team 1 integrator function development 
[state_WF(t1int,:,1), t_new, e_new,rf] = WF_scheduler(eng(:,:,(t1int)), state_WF(t1int,:,1),'Fun',stream,0,0,0);
t1f(i)=t1f(i)+t_new;
e1f(i)=e1f(i)+e_new;
if sum(rf)~=0
disp('Error: reformulations occur during function development');
end
%each team develops 10 functions

%team 11 function development 
for k=1:10
    [state_WF(team11,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team11)), state_WF(team11,:,k),'Fun',stream,0,0,0);
    t11f(i,k)=t11f(i,k)+t_new;
    e11f(i,k)=e11f(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during function development');
    end
end
%Team 12 function development
for k=1:10
    [state_WF(team12,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team12)), state_WF(team12,:,k),'Fun',stream,0,0,0);
    t12f(i,k)=t12f(i,k)+t_new;
    e12f(i,k)=e12f(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during function development');
    end
end
%Team 13 function development
for k=1:10
    [state_WF(team13,:,k), t_new,e_new, rf] = WF_scheduler(eng(:,:,(team13)), state_WF(team13,:,k),'Fun',stream,0,0,0);
    t13f(i,k)=t13f(i,k)+t_new;
    e13f(i,k)=e13f(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during function development');
    end
end

%Team 14 function development
for k=1:10
    [state_WF(team14,:,k), t_new,e_new, rf] = WF_scheduler(eng(:,:,(team14)), state_WF(team14,:,k),'Fun',stream,0,0,0);
    t14f(i,k)=t14f(i,k)+t_new;
    e14f(i,k)=e14f(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during function development');
    end
end

%Team 2 integrator function development 
[state_WF(t2int,:,1), t_new,e_new, rf] = WF_scheduler(eng(:,:,(t2int)), state_WF(t2int,:,1),'Fun',stream,0,0,0);
t2f(i)=t2f(i)+t_new;
e2f(i)=e2f(i)+e_new;
if sum(rf)~=0
disp('Error: reformulations occur during function development');
end


%team 21 function development 
for k=1:10
    [state_WF(team21,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team21)), state_WF(team21,:,k),'Fun',stream,0,0,0);
    t21f(i,k)=t21f(i,k)+t_new;
    e21f(i,k)=e21f(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during function development');
    end
end
%Team 22 function development
for k=1:10
    [state_WF(team22,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team22)), state_WF(team22,:,k),'Fun',stream,0,0,0);
    t22f(i,k)=t22f(i,k)+t_new;
    e22f(i,k)=e22f(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during function development');
    end
end
%Team 23 function development
for k=1:10
    [state_WF(team23,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team23)), state_WF(team23,:,k),'Fun',stream,0,0,0);
    t23f(i,k)=t23f(i,k)+t_new;
    e23f(i,k)=e23f(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during function development');
    end
end

%Team 24 function development
for k=1:10
    [state_WF(team24,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team24)), state_WF(team24,:,k),'Fun',stream,0,0,0);
    t24f(i,k)=t24f(i,k)+t_new;
    e24f(i,k)=e24f(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during function development');
    end
end

%Team 3 integrator function development 
[state_WF(t3int,:,1), t_new,e_new, rf] = WF_scheduler(eng(:,:,(t3int)), state_WF(t3int,:,1),'Fun',stream,0,0,0);
t3f(i)=t3f(i)+t_new;
e3f(i)=e3f(i)+e_new;
if sum(rf)~=0
disp('Error: reformulations occur during function development');
end

for k=1:10
    %team 31 requirements development 
    [state_WF(team31,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team31)), state_WF(team31,:,k),'Fun',stream,0,0,0);
    t31f(i,k)=t31f(i,k)+t_new;
    e31f(i,k)=e31f(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during function development');
    end
end

%determine total time doing functional work and total effort
% each level of the heirarchy goes in parallel to find total time

t_fun_WF(i)=t_pintf(i)+max([t1f(i) t2f(i) t3f(i) ])+max([ sum(t11f(i,:)) sum(t12f(i,:)) sum(t13f(i,:)) sum(t14f(i,:)) sum(t21f(i,:)) sum(t22f(i,:)) sum(t23f(i,:)) sum(t24f(i,:)) sum(t31f(i,:)) ]);
e_fun_WF(i)=e_pintf(i)+e1f(i)+e2f(i)+e3f(i)+sum(e11f(i,:)) +sum(e12f(i,:))+ sum(e13f(i,:))+ sum(e14f(i,:))+ sum(e21f(i,:))+ sum(e22f(i,:))+ sum(e23f(i,:))+ sum(e24f(i,:))+ sum(e31f(i,:));%effort is sum of all manhours


%% Perform preliminary design
% preliminary design performed by lower level teams. Integrators not
% involved.
%Set integrator states assuming positive outcome from preliminary design effort. 
state_WF(pint,:,1)='St';
state_WF(t1int,:,1)='St'; 
state_WF(t2int,:,1)='St';
state_WF(t3int,:,1)='St';

% each team designs 10 functions
%team 11 preliminary design 
for k=1:10
    [state_WF(team11,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team11)), state_WF(team11,:,k),'PDn',stream,0,0,0);
    t11p(i,k)=t11p(i,k)+t_new;
    e11p(i,k)=e11p(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during preliminary design');
    end
end
%Team 12 preliminary design
for k=1:10
    [state_WF(team12,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team12)), state_WF(team12,:,k),'PDn',stream,0,0,0);
    t12p(i,k)=t12p(i,k)+t_new;
    e12p(i,k)=e12p(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during preliminary design');
    end
end
%Team 13 preliminary design
for k=1:10
    [state_WF(team13,:,k), t_new,e_new, rf] = WF_scheduler(eng(:,:,(team13)), state_WF(team13,:,k),'PDn',stream,0,0,0);
    t13p(i,k)=t13p(i,k)+t_new;
    e13p(i,k)=e13p(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during preliminary design');
    end
end
%Team 14 preliminary design
for k=1:10
    [state_WF(team14,:,k), t_new,e_new, rf] = WF_scheduler(eng(:,:,(team14)), state_WF(team14,:,k),'PDn',stream,0,0,0);
    t14p(i,k)=t14p(i,k)+t_new;
    e14p(i,k)=e14p(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during preliminary design');
    end
end
for k=1:10
    %team 21 preliminary design
    [state_WF(team21,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team21)), state_WF(team21,:,k),'PDn',stream,0,0,0);
    t21p(i,k)=t21p(i,k)+t_new;
    e21p(i,k)=e21p(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during preliminary design');
    end
end
%Team 22 preliminary design
for k=1:10
    [state_WF(team22,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team22)), state_WF(team22,:,k),'PDn',stream,0,0,0);
    t22p(i,k)=t22p(i,k)+t_new;
    e22p(i,k)=e22p(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during preliminary design');
    end
end
%Team 23 preliminary design
    for k=1:10
    [state_WF(team23,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team23)), state_WF(team23,:,k),'PDn',stream,0,0,0);
    t23p(i,k)=t23p(i,k)+t_new;
    e23p(i,k)=e23p(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during preliminary design');
    end
end
%Team 24 preliminary design
    for k=1:10
    [state_WF(team24,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team24)), state_WF(team24,:,k),'PDn',stream,0,0,0);
    t24p(i,k)=t24p(i,k)+t_new;
    e24p(i,k)=e24p(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during preliminary design');
    end
end
%team 31 preliminary design
for k=1:10
    [state_WF(team31,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team31)), state_WF(team31,:,k),'PDn',stream,0,0,0);
    t31p(i,k)=t31p(i,k)+t_new;
    e31p(i,k)=e31p(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during preliminary design');
    end
end

%determine total time doing preliminary design work and total effort
% each level of the heirarchy goes in parallel to find total time

t_pdn_WF(i)=max([sum(t11p(i,:)) sum(t12p(i,:)) sum(t13p(i,:)) sum(t14p(i,:)) sum(t21p(i,:)) sum(t22p(i,:)) sum(t23p(i,:)) sum(t24p(i,:)) sum(t31p(i,:)) ]);
e_pdn_WF(i)=sum(e11p(i,:))+sum(e12p(i,:))+sum(e13p(i,:))+sum(e14p(i,:))+sum(e21p(i,:))+sum(e22p(i,:))+sum(e23p(i,:))+sum(e24p(i,:))+sum(e31p(i,:));%effort is sum of all manhours



%% Perform detailed design including rework during reformulations
% detailed design performed by lower level teams. Integrators not
% involved.
%Set integrator states assuming positive outcome from detailed design effort. 
state_WF(pint,:,1)='Dc';
state_WF(t1int,:,1)='Dc'; 
state_WF(t2int,:,1)='Dc';
state_WF(t3int,:,1)='Dc';

% each team performs detailed design for 10 functions
% Order is important in this step so that chaining reformulations can be
% delt with (design decisions by someone in the design process that affect
% someone else). The order is setup optimally (minimizes the amount of
% chaining reformulations). 
%Initialize design definition vector

design =zeros(9,1);
%team 31 detailed design
for k=1:10
    [state_WF(team31,:,k), t_new, e_new, rf,design] = WF_scheduler(eng(:,:,(team31)), state_WF(team31,:,k),'DDn',stream,designdata,9,design);
    t31d(i,k)=t31d(i,k)+t_new;
    e31d(i,k)=e31d(i,k)+e_new;
    rf31(:,i,k)=rf;
end
        
%team 24 detailed design
for k=1:10
    [state_WF(team24,:,k), t_new, e_new, rf,design] = WF_scheduler(eng(:,:,(team24)), state_WF(team24,:,k),'DDn',stream,designdata,8,design);
    t24d(i,k)=t24d(i,k)+t_new;
    e24d(i,k)=e24d(i,k)+e_new;
    rf24(:,i,k)=rf;
end
%team 23 detailed design
for k=1:10
    [state_WF(team23,:,k), t_new, e_new, rf,design] = WF_scheduler(eng(:,:,(team23)), state_WF(team23,:,k),'DDn',stream,designdata,7,design);
    t23d(i,k)=t23d(i,k)+t_new;
    e23d(i,k)=e23d(i,k)+e_new;
    rf23(:,i,k)=rf;
end
%team 22 detailed design
for k=1:10
    [state_WF(team22,:,k), t_new, e_new, rf,design] = WF_scheduler(eng(:,:,(team22)), state_WF(team22,:,k),'DDn',stream,designdata,6,design);
    t22d(i,k)=t22d(i,k)+t_new;
    e22d(i,k)=e22d(i,k)+e_new;
    rf22(:,i,k)=rf;
end
%team 21 detailed design
for k=1:10
    [state_WF(team21,:,k), t_new, e_new, rf,design] = WF_scheduler(eng(:,:,(team21)), state_WF(team21,:,k),'DDn',stream,designdata,5,design);
    t21d(i,k)=t21d(i,k)+t_new;
    e21d(i,k)=e21d(i,k)+e_new;
    rf21(:,i,k)=rf;
end
%team 14 detailed design
for k=1:10
    [state_WF(team14,:,k), t_new, e_new, rf,design] = WF_scheduler(eng(:,:,(team14)), state_WF(team14,:,k),'DDn',stream,designdata,4,design);
    t14d(i,k)=t14d(i,k)+t_new;
    e14d(i,k)=e14d(i,k)+e_new;
    rf14(:,i,k)=rf;
end
%team 13 detailed design
for k=1:10
    [state_WF(team13,:,k), t_new, e_new, rf,design] = WF_scheduler(eng(:,:,(team13)), state_WF(team13,:,k),'DDn',stream,designdata,3,design);
    t13d(i,k)=t13d(i,k)+t_new;
    e13d(i,k)=e13d(i,k)+e_new;
    rf13(:,i,k)=rf;
end
%team 12 detailed design
for k=1:10
    [state_WF(team12,:,k), t_new, e_new, rf,design] = WF_scheduler(eng(:,:,(team12)), state_WF(team12,:,k),'DDn',stream,designdata,2,design);
    t12d(i,k)=t12d(i,k)+t_new;
    e12d(i,k)=e12d(i,k)+e_new;
    rf12(:,i,k)=rf;
end
%team 11 detailed design
for k=1:10
    [state_WF(team11,:,k), t_new, e_new, rf,design] = WF_scheduler(eng(:,:,(team11)), state_WF(team11,:,k),'DDn',stream,designdata,1,design);
    t11d(i,k)=t11d(i,k)+t_new;
    e11d(i,k)=e11d(i,k)+e_new;
    rf11(:,i,k)=rf;
end

% %Team 14 detailed design
% refreq=1;ck=0;
%     while refreq ==1 %reformulation is required due to selection of design variable that doesn't work with the rest of the design
%         %Perform another detailed design effort to account for
%         %reformulation (type I reformulation)
%         for k=1:10
%             [state_WF(team14,:,k), t_new,e_new, rf] = WF_scheduler(eng(:,:,(team14)), state_WF(team14,:,k),'DDn',stream);
%             t14d(i,k)=t14d(i,k)+t_new;
%             e14d(i,k)=e14d(i,k)+e_new;
%             if ck==0 %First reformulation is to get initial design working - internal reformulation
%                rf14(:,i,k)=rf';ck=1;
%             else %Subsequent reformulations are due to design not functioning with the rest of the system - external reformulation
%                 rf14e(:,i,k)=rf14e(:,i,k)+rf';
%             end
%         end
%         [design(1),refreq]=find_design_var(designdata,1,design,stream); %Determine what design variable was selected
%     end



%determine total time doing detailed design work and total effort
% each level of the heirarchy goes in parallel to find total time

t_ddn_WF(i)=max([sum(t11d(i,:)) sum(t12d(i,:)) sum(t13d(i,:)) sum(t14d(i,:)) sum(t21d(i,:)) sum(t22d(i,:)) sum(t23d(i,:)) sum(t24d(i,:)) sum(t31d(i,:)) ]);
e_ddn_WF(i)=sum(e11d(i,:))+sum(e12d(i,:))+sum(e13d(i,:))+sum(e14d(i,:))+sum(e21d(i,:))+sum(e22d(i,:))+sum(e23d(i,:))+sum(e24d(i,:))+sum(e31d(i,:));%effort is sum of all manhours
e_rf1_WF(i)=sum(rf11(1,i,:))+sum(rf12(1,i,:))+sum(rf13(1,i,:))+sum(rf14(1,i,:))+sum(rf21(1,i,:))+sum(rf22(1,i,:))+sum(rf23(1,i,:))+sum(rf24(1,i,:))+sum(rf31(1,i,:)); %effort expended doing type 1 reformulations
e_rf2_WF(i)=sum(rf11(2,i,:))+sum(rf12(2,i,:))+sum(rf13(2,i,:))+sum(rf14(2,i,:))+sum(rf21(2,i,:))+sum(rf22(2,i,:))+sum(rf23(2,i,:))+sum(rf24(2,i,:))+sum(rf31(2,i,:)); %effort expended doing type 2 reformulations
e_rf3_WF(i)=sum(rf11(3,i,:))+sum(rf12(3,i,:))+sum(rf13(3,i,:))+sum(rf14(3,i,:))+sum(rf21(3,i,:))+sum(rf22(3,i,:))+sum(rf23(3,i,:))+sum(rf24(3,i,:))+sum(rf31(3,i,:)); %effort expended doing type 3 reformulations

% e_rf1e_WF(i)=sum(rf11e(1,i,:))+sum(rf12e(1,i,:))+sum(rf13e(1,i,:))+sum(rf14e(1,i,:))+sum(rf21e(1,i,:))+sum(rf22e(1,i,:))+sum(rf23e(1,i,:))+sum(rf24e(1,i,:))+sum(rf31e(1,i,:)); %effort expended doing type 1 external reformulations
% e_rf2e_WF(i)=sum(rf11e(2,i,:))+sum(rf12e(2,i,:))+sum(rf13e(2,i,:))+sum(rf14e(2,i,:))+sum(rf21e(2,i,:))+sum(rf22e(2,i,:))+sum(rf23e(2,i,:))+sum(rf24e(2,i,:))+sum(rf31e(2,i,:)); %effort expended doing type 2 external reformulations
% e_rf3e_WF(i)=sum(rf11e(3,i,:))+sum(rf12e(3,i,:))+sum(rf13e(3,i,:))+sum(rf14e(3,i,:))+sum(rf21e(3,i,:))+sum(rf22e(3,i,:))+sum(rf23e(3,i,:))+sum(rf24e(3,i,:))+sum(rf31e(3,i,:)); %effort expended doing type 3 external reformulations

t_rf_WF(i)=max([ sum(rf11(4,i,:)) sum(rf12(4,i,:)) sum(rf13(4,i,:)) sum(rf14(4,i,:)) sum(rf21(4,i,:)) sum(rf22(4,i,:)) sum(rf23(4,i,:)) sum(rf24(4,i,:)) sum(rf31(4,i,:)) ]); %Time spent doing internal reformulations

%t_rfe_WF(i)=max([ sum(rf11e(4,i,:)) sum(rf12e(4,i,:)) sum(rf13e(4,i,:)) sum(rf14e(4,i,:)) sum(rf21e(4,i,:)) sum(rf22e(4,i,:)) sum(rf23e(4,i,:)) sum(rf24e(4,i,:)) sum(rf31e(4,i,:)) ]); %Time spent doing external reformulations

%% Gather final set of simulation metrics

t_WF(i)=t_req_WF(i)+t_fun_WF(i)+t_pdn_WF(i)+t_ddn_WF(i);
e_WF(i)=e_req_WF(i)+e_fun_WF(i)+e_pdn_WF(i)+e_ddn_WF(i);
%Display simulation status
if i==(iterations/2)
    disp('Waterfall simulation 50% complete');
elseif i==(iterations/4)
    disp('Waterfall simulation 25% complete');
elseif i==(iterations*3/4)
    disp('Waterfall simulation 75% complete');
end

end
disp('Waterfall Simulation Complete');
% Plots of waterfall data

bin1=[800:100:2500];

figure (1)
histogram (t_WF,bin1);
hold on
xlabel ('Time to complete Launch Vehicle design (hrs)');
ylabel ('count');
%title ('Histogram of waterfall simulation design times');
xlim([800 3000]);
ylim ([0 20]);
hold off

disp('Average time to complete waterfall Launch Vehicle design');
avg_t_WF=mean(t_WF)

disp('Stdev time to complete waterfall Launch Vehicle design');
std_t_WF=std(t_WF)

figure (2)
histogram (e_WF);
hold on
xlabel ('Effort-hours to complete Launch Vehicle design (hrs)');
ylabel ('count');
%title ('Histogram of waterfall simulation design times');
%xlim([0 80]);
%ylim ([0 700]);
hold off

disp('Average effort to complete waterfall Launch Vehicle design (Manhours)');
avg_e_WF=mean(e_WF)

disp('Stdev effort to complete waterfall Launch Vehicle design (Manhours)');
std_e_WF=std(e_WF)

figure (3)
histogram (t_rf_WF);
hold on
xlabel ('Time spent doing rework (hrs)');
ylabel ('count');
%title ('Histogram of waterfall simulation design times');
%xlim([0 80]);
%ylim ([0 700]);
hold off

disp('Average time spent in rework for waterfall Launch Vehicle');
avg_rf_WF=mean(t_rf_WF)

disp('Stdev time spent in rework for waterfall Launch Vehicle');
std_rf_WF=std(t_rf_WF)

%disp('Average time spent in external rework (coupled design issue) for waterfall Launch Vehicle');
%avg_rfe_WF=mean(t_rfe_WF)


%% Agile simulation

for i=1:iterations
	
    % Initialize FBS designer states
for j=1:(8*12+5)
	for k=1:10
        state_A(j,:,k)='Rq';
    end
end
    
   %% Perform initial planning/requirements development

% Top-down requirements flow
%Program integrator requirements development 
[state_A(pint,:,1), t_new, e_new, rf] = WF_scheduler(eng(:,:,(pint)), state_A(pint,:,1),'Req',stream);
t_pintA(i)=t_pintA(i)+t_new;
e_pintA(i)=e_pintA(i)+e_new;
if sum(rf)~=0
disp('Error: reformulations occur during requirements development');
end

%Team 1 integrator requirements development 
[state_A(t1int,:,1), t_new, e_new,rf] = WF_scheduler(eng(:,:,(t1int)), state_A(t1int,:,1),'Req',stream);
t1A(i)=t1A(i)+t_new;
e1A(i)=e1A(i)+e_new;
if sum(rf)~=0
disp('Error: reformulations occur during requirements development');
end
   
%Team 2 integrator requirements development 
[state_A(t2int,:,1), t_new, e_new,rf] = WF_scheduler(eng(:,:,(t2int)), state_A(t2int,:,1),'Req',stream);
t2A(i)=t2A(i)+t_new;
e2A(i)=e2A(i)+e_new;
if sum(rf)~=0
disp('Error: reformulations occur during requirements development');
end    
    
%Team 3 integrator requirements development 
[state_A(t3int,:,1), t_new,e_new, rf] = WF_scheduler(eng(:,:,(t3int)), state_A(t3int,:,1),'Req',stream);
t3A(i)=t3A(i)+t_new;
e3A(i)=e3A(i)+e_new;
if sum(rf)~=0
disp('Error: reformulations occur during requirements development');
end


%Time and effort spent on initial planning
t_req_A(i)=t_pintA(i)+max([t1A(i) t2A(i) t3A(i) ]); %Time spent on initial planning
e_req_A(i)=e_pintA(i)+e1A(i)+e2A(i)+e3A(i);%effort is sum of all manhours

%% Perform agile sprints to develop work by lower level teams

%Initialize design definition vector
designA =zeros(9,1);

%Set integrator states assuming positive outcome from  design effort. 
state_A(pint,:,1)='Dc';
state_A(t1int,:,1)='Dc'; 
state_A(t2int,:,1)='Dc';
state_A(t3int,:,1)='Dc';

% each team performs design for 10 functions
% Teams are ordered to eliminate the need to do rework due to design
% integration (external) reformulations
%team 31 sprints
for k=1:10
    [state_A(team31,:,k), t_new, e_new, rf,designA] = A_scheduler(eng(:,:,(team31)), state_A(team31,:,k),'Req',stream,designdata,9,designA);
    t31A(i,k)=t31A(i,k)+t_new;
    e31A(i,k)=e31A(i,k)+e_new;
    rf31A(:,i,k)=rf;
end
%Team 24 sprints
for k=1:10
    [state_A(team24,:,k), t_new, e_new, rf,designA] = A_scheduler(eng(:,:,(team23)), state_A(team24,:,k),'Req',stream,designdata,8,designA);
    t24A(i,k)=t24A(i,k)+t_new;
    e24A(i,k)=e24A(i,k)+e_new;
    rf24A(:,i,k)=rf;
end
%Team 23 sprints
for k=1:10
    [state_A(team23,:,k), t_new, e_new, rf,designA] = A_scheduler(eng(:,:,(team23)), state_A(team23,:,k),'Req',stream,designdata,7,designA);
    t23A(i,k)=t23A(i,k)+t_new;
    e23A(i,k)=e23A(i,k)+e_new;
    rf23A(:,i,k)=rf;
end

%Team 22 sprints
for k=1:10
    [state_A(team22,:,k), t_new, e_new, rf,designA] = A_scheduler(eng(:,:,(team22)), state_A(team22,:,k),'Req',stream,designdata,6,designA);
    t22A(i,k)=t22A(i,k)+t_new;
    e22A(i,k)=e22A(i,k)+e_new;
    rf22A(:,i,k)=rf;
end
%team 21 sprints
for k=1:10
    [state_A(team21,:,k), t_new, e_new, rf,designA] = A_scheduler(eng(:,:,(team21)), state_A(team21,:,k),'Req',stream,designdata,5,designA);
    t21A(i,k)=t21A(i,k)+t_new;
    e21A(i,k)=e21A(i,k)+e_new;
    rf21A(:,i,k)=rf;
end

%Team 14 sprints
for k=1:10
    [state_A(team14,:,k), t_new,e_new, rf,designA] = A_scheduler(eng(:,:,(team14)), state_A(team14,:,k),'Req',stream,designdata,4,designA);
    t14A(i,k)=t14A(i,k)+t_new;
    e14A(i,k)=e14A(i,k)+e_new;
    rf14A(:,i,k)=rf;
end
%Team 13 sprints
for k=1:10
    [state_A(team13,:,k), t_new,e_new, rf,designA] = A_scheduler(eng(:,:,(team13)), state_A(team13,:,k),'Req',stream,designdata,3,designA);
    t13A(i,k)=t13A(i,k)+t_new;
    e13A(i,k)=e13A(i,k)+e_new;
    rf13A(:,i,k)=rf;
end
%Team 12 sprints
for k=1:10
    [state_A(team12,:,k), t_new, e_new, rf,designA] = A_scheduler(eng(:,:,(team12)), state_A(team12,:,k),'Req',stream,designdata,2,designA);
    t12A(i,k)=t12A(i,k)+t_new;
    e12A(i,k)=e12A(i,k)+e_new;
    rf12A(:,i,k)=rf;
end
%team 11 sprints 
for k=1:10
    [state_A(team11,:,k), t_new, e_new, rf,designA] = A_scheduler(eng(:,:,(team11)), state_A(team11,:,k),'Req',stream,designdata,1,designA);
    t11A(i,k)=t11A(i,k)+t_new;
    e11A(i,k)=e11A(i,k)+e_new;
    rf11A(:,i,k)=rf;
end
% Collect metrics from sprints
t_DA(i)=max([sum(t11A(i,:)) sum(t12A(i,:)) sum(t13A(i,:)) sum(t14A(i,:)) sum(t21A(i,:)) sum(t22A(i,:)) sum(t23A(i,:)) sum(t24A(i,:)) sum(t31A(i,:))]);
e_DA(i)=sum(e11A(i,:))+sum(e12A(i,:))+sum(e13A(i,:))+sum(e14A(i,:))+sum(e21A(i,:))+sum(e22A(i,:))+sum(e23A(i,:))+sum(e24A(i,:))+sum(e31A(i,:));%effort is sum of all manhours
e_rf1_A(i)=sum(rf11A(1,i,:))+sum(rf12A(1,i,:))+sum(rf13A(1,i,:))+sum(rf14A(1,i,:))+sum(rf21A(1,i,:))+sum(rf22A(1,i,:))+sum(rf23A(1,i,:))+sum(rf24A(1,i,:))+sum(rf31A(1,i,:)); %effort expended doing type 1 reformulations
e_rf2_A(i)=sum(rf11A(2,i,:))+sum(rf12A(2,i,:))+sum(rf13A(2,i,:))+sum(rf14A(2,i,:))+sum(rf21A(2,i,:))+sum(rf22A(2,i,:))+sum(rf23A(2,i,:))+sum(rf24A(2,i,:))+sum(rf31A(2,i,:)); %effort expended doing type 2 reformulations
e_rf3_A(i)=sum(rf11A(3,i,:))+sum(rf12A(3,i,:))+sum(rf13A(3,i,:))+sum(rf14A(3,i,:))+sum(rf21A(3,i,:))+sum(rf22A(3,i,:))+sum(rf23A(3,i,:))+sum(rf24A(3,i,:))+sum(rf31A(3,i,:)); %effort expended doing type 2 reformulations
t_rf_A(i)=max([ sum(rf11A(4,i,:)) sum(rf12A(4,i,:)) sum(rf13A(4,i,:)) sum(rf14A(4,i,:)) sum(rf21A(4,i,:)) sum(rf22A(4,i,:)) sum(rf23A(4,i,:)) sum(rf24A(4,i,:)) sum(rf31A(4,i,:)) ]);

%% Gather final set of simulation metrics

t_A(i)=t_req_A(i)+t_DA(i);
e_A(i)=e_req_A(i)+e_DA(i);

if i==(iterations/2)
    disp('Agile simulation 50% complete');
elseif i==(iterations/4)
    disp('Agile simulation 25% complete');
elseif i==(iterations*3/4)
    disp('Agile simulation 75% complete');
end

end
disp('Agile simulation complete');
figure (4)
histogram (t_A,bin1);
hold on
xlabel ('Time to complete Launch Vehicle design (hrs)');
ylabel ('count');
%title ('Histogram of agile simulation design times');
xlim([800 3000]);
ylim ([0 20]);
hold off

disp('Average time to complete agile Launch Vehicle design');
avg_t_A=mean(t_A)
disp('Stdev time to complete agile Launch Vehicle design');
std_t_A=std(t_A)

figure (5)
histogram (e_A);
hold on
xlabel ('Effort-hours to complete Launch Vehicle design (hrs)');
ylabel ('count');
%title ('Histogram of agile simulation design times');
%xlim([0 80]);
%ylim ([0 700]);
hold off

disp('Average effort to complete agile Launch Vehicle design (Manhours)');
avg_e_A=mean(e_A)
disp('Stdev effort to complete agile Launch Vehicle design (Manhours)');
std_e_A=std(e_A)

figure (6)
histogram (t_rf_A);
hold on
xlabel ('Time spent in rework (hrs)');
ylabel ('count');
%title ('Histogram of agile simulation design times');
%xlim([0 80]);
%ylim ([0 700]);
hold off

disp('Average time spent in rework for agile Launch Vehicle');
avg_rf_A=mean(t_rf_A)

disp('Stdev time spent in rework for agile Launch Vehicle');
std_rf_A=std(t_rf_A)

disp('')
disp('Ratio of average time to complete Launch Vehicle design')
ratio_t=avg_t_A/avg_t_WF
disp('Ratio of average effort to complete Launch Vehicle design')
ratio_e=avg_e_A/avg_e_WF
disp('Ratio of time spent in rework')
ratio_rf=avg_rf_A/avg_rf_WF
