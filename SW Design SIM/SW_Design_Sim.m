%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Simulation of a software design activity
%       The activity consists of twelve design teams developing four subsystems that work 
%       together in a to develop a complex computer program.
%       The simulation runs both a simulation of the team performing waterfall
%       and agile methods.
%       
%       
%
%       Each cycle represents 1 hour of work 
%
%   
%   Mitch Bott 8-14-17
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% clear simulation variables and MATLAB workspace
clear all;
close all;
clc;


% Set random variable stream
rand_seed=23;
stream = RandStream('mlfg6331_64','seed',rand_seed);

% initialize mean design transition matrix for software engineers
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
t2(iterations)=0;
e2(iterations)=0;
t21(iterations,10)=0;
e21(iterations,10)=0;
t22(iterations,10)=0;
e22(iterations,10)=0;
t23(iterations,10)=0;
e23(iterations,10)=0;
t3(iterations)=0;
e3(iterations)=0;
t31(iterations,10)=0;
e31(iterations,10)=0;
t32(iterations,10)=0;
e32(iterations,10)=0;
t4(iterations)=0;
e4(iterations)=0;
t41(iterations,10)=0;
e41(iterations,10)=0;
t42(iterations,10)=0;
e42(iterations,10)=0;
t43(iterations,10)=0;
e43(iterations,10)=0;
t44(iterations,10)=0;
e44(iterations,10)=0;

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
t2f(iterations)=0;
e2f(iterations)=0;
t21f(iterations,10)=0;
e21f(iterations,10)=0;
t22f(iterations,10)=0;
e22f(iterations,10)=0;
t23f(iterations,10)=0;
e23f(iterations,10)=0;
t3f(iterations)=0;
e3f(iterations)=0;
t31f(iterations,10)=0;
e31f(iterations,10)=0;
t32f(iterations,10)=0;
e32f(iterations,10)=0;
t4f(iterations)=0;
e4f(iterations)=0;
t41f(iterations,10)=0;
e41f(iterations,10)=0;
t42f(iterations,10)=0;
e42f(iterations,10)=0;
t43f(iterations,10)=0;
e43f(iterations,10)=0;
t44f(iterations,10)=0;
e44f(iterations,10)=0;

t11p(iterations,10)=0;
e11p(iterations,10)=0;
t12p(iterations,10)=0;
e12p(iterations,10)=0;
t13p(iterations,10)=0;
e13p(iterations,10)=0;
t21p(iterations,10)=0;
e21p(iterations,10)=0;
t22p(iterations,10)=0;
e22p(iterations,10)=0;
t23p(iterations,10)=0;
e23p(iterations,10)=0;
t31p(iterations,10)=0;
e31p(iterations,10)=0;
t32p(iterations,10)=0;
e32p(iterations,10)=0;
t41p(iterations,10)=0;
e41p(iterations,10)=0;
t42p(iterations,10)=0;
e42p(iterations,10)=0;
t43p(iterations,10)=0;
e43p(iterations,10)=0;
t44p(iterations,10)=0;
e44p(iterations,10)=0;

t11d(iterations,10)=0;
e11d(iterations,10)=0;
t12d(iterations,10)=0;
e12d(iterations,10)=0;
t13d(iterations,10)=0;
e13d(iterations,10)=0;
t21d(iterations,10)=0;
e21d(iterations,10)=0;
t22d(iterations,10)=0;
e22d(iterations,10)=0;
t23d(iterations,10)=0;
e23d(iterations,10)=0;
t31d(iterations,10)=0;
e31d(iterations,10)=0;
t32d(iterations,10)=0;
e32d(iterations,10)=0;
t41d(iterations,10)=0;
e41d(iterations,10)=0;
t42d(iterations,10)=0;
e42d(iterations,10)=0;
t43d(iterations,10)=0;
e43d(iterations,10)=0;
t44d(iterations,10)=0;
e44d(iterations,10)=0;

t_pintA(iterations)=0;
e_pintA(iterations)=0;
t1A(iterations)=0;
e1A(iterations)=0;
t2A(iterations)=0;
e2A(iterations)=0;
t3A(iterations)=0;
e3A(iterations)=0;
t4A(iterations)=0;
e4A(iterations)=0;

t11A(iterations,10)=0;
e11A(iterations,10)=0;
t12A(iterations,10)=0;
e12A(iterations,10)=0;
t13A(iterations,10)=0;
e13A(iterations,10)=0;
t21A(iterations,10)=0;
e21A(iterations,10)=0;
t22A(iterations,10)=0;
e22A(iterations,10)=0;
t23A(iterations,10)=0;
e23A(iterations,10)=0;
t31A(iterations,10)=0;
e31A(iterations,10)=0;
t32A(iterations,10)=0;
e32A(iterations,10)=0;
t41A(iterations,10)=0;
e41A(iterations,10)=0;
t42A(iterations,10)=0;
e42A(iterations,10)=0;
t43A(iterations,10)=0;
e43A(iterations,10)=0;
t44A(iterations,10)=0;
e44A(iterations,10)=0;

%% Initialize simulations

% Develop FBS models for each designer - assume 8 designers per team and 5 integrators
[eng] = FBS_Designator(8*12+5, FBS_mat, FBS_var, stream);

% Assign designers to teams of 8
% teams are numbered teamxy - where x is the major function and y is the subfunction
team11 = [1:8];
team12= [(8+1):(8*2)];
team13=[(8*2+1):(8*3)];

team21 = [(8*3+1):(8*4)];
team22 = [(8*4+1):(8*5)];
team23 = [(8*5+1):(8*6)];

team31 = [(8*6+1):(8*7)];
team32 = [(8*7+1):(8*8)];

team41 = [(8*8+1): (8*9)];
team42 = [(8*9+1): (8*10)];
team43 = [(8*10+1): (8*11)];
team44 = [(8*11+1): (8*12)];


% Assign team integrators
t1int = [(8*12+1)];
t2int = [(8*12+2)];
t3int = [(8*12+3)];
t4int = [(8*12+4)];
% Assign program integrator
pint = [(8*12+5)];
%% Waterfall simulation
for i=1:iterations %Perform 10,000 monte-carlo simulations

% Initialize FBS designer states to requirements
for j=1:(8*12+5)
	for k=1:10
        state_WF(j,:,k)='Rq';
    end
end


%% Perform requirements development

% Top-down requirements flow
%Program integrator requirements development 
[state_WF(pint,:,1), t_new, e_new, rf] = WF_scheduler(eng(:,:,(pint)), state_WF(pint,:,1),'Req',stream);
t_pint(i)=t_pint(i)+t_new;
e_pint(i)=e_pint(i)+e_new;
if sum(rf)~=0
disp('Error: reformulations occur during requirements development');
end

%Team 1 integrator requirements development 
[state_WF(t1int,:,1), t_new, e_new,rf] = WF_scheduler(eng(:,:,(t1int)), state_WF(t1int,:,1),'Req',stream);
t1(i)=t1(i)+t_new;
e1(i)=e1(i)+e_new;
if sum(rf)~=0
disp('Error: reformulations occur during requirements development');
end

%Each subfunction team develops requirements for 10 subfunctions
%team 11 requirements development 

for k=1:10
    [state_WF(team11,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team11)), state_WF(team11,:,k),'Req',stream);
    t11(i,k)=t11(i,k)+t_new;
    e11(i,k)=e11(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during requirements development');
    end
end
%Team 12 requirements development
for k=1:10
    [state_WF(team12,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team12)), state_WF(team12,:,k),'Req',stream);
    t12(i,k)=t12(i,k)+t_new;
    e12(i,k)=e12(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during requirements development');
    end
end
%Team 13 requirements development
for k=1:10
    [state_WF(team13,:,k), t_new,e_new, rf] = WF_scheduler(eng(:,:,(team13)), state_WF(team13,:,k),'Req',stream);
    t13(i,k)=t13(i,k)+t_new;
    e13(i,k)=e13(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during requirements development');
    end
end

%Team 2 integrator requirements development 
[state_WF(t2int,:,1), t_new,e_new, rf] = WF_scheduler(eng(:,:,(t2int)), state_WF(t2int,:,1),'Req',stream);
t2(i)=t2(i)+t_new;
e2(i)=e2(i)+e_new;
if sum(rf)~=0
disp('Error: reformulations occur during requirements development');
end


%team 21 requirements development 
for k=1:10
    [state_WF(team21,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team21)), state_WF(team21,:,k),'Req',stream);
    t21(i,k)=t21(i,k)+t_new;
    e21(i,k)=e21(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during requirements development');
    end
end
%Team 22 requirements development
for k=1:10
    [state_WF(team22,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team22)), state_WF(team22,:,k),'Req',stream);
    t22(i,k)=t22(i,k)+t_new;
    e22(i,k)=e22(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during requirements development');
    end
end
%Team 23 requirements development
for k=1:10
    [state_WF(team23,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team23)), state_WF(team23,:,k),'Req',stream);
    t23(i,k)=t23(i,k)+t_new;
    e23(i,k)=e23(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during requirements development');
    end
end
%Team 3 integrator requirements development 
[state_WF(t3int,:,1), t_new,e_new, rf] = WF_scheduler(eng(:,:,(t3int)), state_WF(t3int,:,1),'Req',stream);
t3(i)=t3(i)+t_new;
e3(i)=e3(i)+e_new;
if sum(rf)~=0
disp('Error: reformulations occur during requirements development');
end


%team 31 requirements development 
for k=1:10
    [state_WF(team31,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team31)), state_WF(team31,:,k),'Req',stream);
    t31(i,k)=t31(i,k)+t_new;
    e31(i,k)=e31(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during requirements development');
    end
end
%Team 32 requirements development
for k=1:10
    [state_WF(team32,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team32)), state_WF(team32,:,k),'Req',stream);
    t32(i,k)=t32(i,k)+t_new;
    e32(i,k)=e32(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during requirements development');
    end
end
%Team 4 integrator requirements development 
[state_WF(t4int,:,1), t_new, e_new, rf] = WF_scheduler(eng(:,:,(t4int)), state_WF(t4int,:,1),'Req',stream);
t4(i)=t4(i)+t_new;
e4(i)=e4(i)+e_new;
if sum(rf)~=0
disp('Error: reformulations occur during requirements development');
end


%team 41 requirements development
for k=1:10
    [state_WF(team41,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team41)), state_WF(team41,:,k),'Req',stream);
    t41(i,k)=t41(i,k)+t_new;
    e41(i,k)=e41(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during requirements development');
    end
end
%Team 42 requirements development
for k=1:10
    [state_WF(team42,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team42)), state_WF(team42,:,k),'Req',stream);
    t42(i,k)=t42(i,k)+t_new;
    e42(i,k)=e42(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during requirements development');
    end
end
%Team 43 requirements development
for k=1:10
    [state_WF(team43,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team43)), state_WF(team43,:,k),'Req',stream);
    t43(i,k)=t43(i,k)+t_new;
    e43(i,k)=e43(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during requirements development');
    end
end
%Team 44 requirements development
for k=1:10
    [state_WF(team44,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team44)), state_WF(team44,:,k),'Req',stream);
    t44(i,k)=t44(i,k)+t_new;
    e44(i,k)=e44(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during requirements development');
    end
end
%determine total time doing requirements and total effort
% each level of the heirarchy goes in parallel to find total time

t_req_WF(i)=t_pint(i)+max([t1(i) t2(i) t3(i) t4(i)])+max([sum(t11(i,:)) sum(t12(i,:)) sum(t13(i,:)) sum(t21(i,:)) sum(t22(i,:)) sum(t23(i,:)) sum(t31(i,:)) sum(t32(i,:)) sum(t41(i,:)) sum(t42(i,:)) sum(t43(i,:)) sum(t44(i,:))]);
e_req_WF(i)=e_pint(i)+e1(i)+e2(i)+e3(i)+e4(i)+sum(e11(i,:))+ sum(e12(i,:))+ sum(e13(i,:))+ sum(e21(i,:))+ sum(e22(i,:))+ sum(e23(i,:))+ sum(e31(i,:))+ sum(e32(i,:))+ sum(e41(i,:))+ sum(e42(i,:))+ sum(e43(i,:))+ sum(e44(i,:));%effort is sum of all manhours

% Perform function development

%Program integrator function development 
[state_WF(pint,:,1), t_new, e_new, rf] = WF_scheduler(eng(:,:,(pint)), state_WF(pint,:,1),'Fun',stream);
t_pintf(i)=t_pintf(i)+t_new;
e_pintf(i)=e_pintf(i)+e_new;
if sum(rf)~=0
disp('Error: reformulations occur during function development');
end

%Team 1 integrator function development 
[state_WF(t1int,:,1), t_new, e_new,rf] = WF_scheduler(eng(:,:,(t1int)), state_WF(t1int,:,1),'Fun',stream);
t1f(i)=t1f(i)+t_new;
e1f(i)=e1f(i)+e_new;
if sum(rf)~=0
disp('Error: reformulations occur during function development');
end
%each team develops 10 functions

%team 11 function development 
for k=1:10
    [state_WF(team11,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team11)), state_WF(team11,:,k),'Fun',stream);
    t11f(i,k)=t11f(i,k)+t_new;
    e11f(i,k)=e11f(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during function development');
    end
end
%Team 12 function development
for k=1:10
    [state_WF(team12,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team12)), state_WF(team12,:,k),'Fun',stream);
    t12f(i,k)=t12f(i,k)+t_new;
    e12f(i,k)=e12f(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during function development');
    end
end
%Team 13 function development
for k=1:10
    [state_WF(team13,:,k), t_new,e_new, rf] = WF_scheduler(eng(:,:,(team13)), state_WF(team13,:,k),'Fun',stream);
    t13f(i,k)=t13f(i,k)+t_new;
    e13f(i,k)=e13f(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during function development');
    end
end

%Team 2 integrator function development 
[state_WF(t2int,:,1), t_new,e_new, rf] = WF_scheduler(eng(:,:,(t2int)), state_WF(t2int,:,1),'Fun',stream);
t2f(i)=t2f(i)+t_new;
e2f(i)=e2f(i)+e_new;
if sum(rf)~=0
disp('Error: reformulations occur during function development');
end


%team 21 function development 
for k=1:10
    [state_WF(team21,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team21)), state_WF(team21,:,k),'Fun',stream);
    t21f(i,k)=t21f(i,k)+t_new;
    e21f(i,k)=e21f(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during function development');
    end
end
%Team 22 function development
for k=1:10
    [state_WF(team22,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team22)), state_WF(team22,:,k),'Fun',stream);
    t22f(i,k)=t22f(i,k)+t_new;
    e22f(i,k)=e22f(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during function development');
    end
end
%Team 23 function development
for k=1:10
    [state_WF(team23,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team23)), state_WF(team23,:,k),'Fun',stream);
    t23f(i,k)=t23f(i,k)+t_new;
    e23f(i,k)=e23f(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during function development');
    end
end
%Team 3 integrator function development 
[state_WF(t3int,:,1), t_new,e_new, rf] = WF_scheduler(eng(:,:,(t3int)), state_WF(t3int,:,1),'Fun',stream);
t3f(i)=t3f(i)+t_new;
e3f(i)=e3f(i)+e_new;
if sum(rf)~=0
disp('Error: reformulations occur during function development');
end

for k=1:10
    %team 31 requirements development 
    [state_WF(team31,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team31)), state_WF(team31,:,k),'Fun',stream);
    t31f(i,k)=t31f(i,k)+t_new;
    e31f(i,k)=e31f(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during function development');
    end
end
%Team 32 function development
for k=1:10
    [state_WF(team32,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team32)), state_WF(team32,:,k),'Fun',stream);
    t32f(i,k)=t32f(i,k)+t_new;
    e32f(i,k)=e32f(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during function development');
    end
end
%Team 4 integrator function development 
[state_WF(t4int,:,1), t_new, e_new, rf] = WF_scheduler(eng(:,:,(t4int)), state_WF(t4int,:,1),'Fun',stream);
t4f(i)=t4f(i)+t_new;
e4f(i)=e4f(i)+e_new;
if sum(rf)~=0
disp('Error: reformulations occur during function development');
end


%team 41 function development 
for k=1:10
    [state_WF(team41,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team41)), state_WF(team41,:,k),'Fun',stream);
    t41f(i,k)=t41f(i,k)+t_new;
    e41f(i,k)=e41f(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during function development');
    end
end
%Team 42 function development
for k=1:10
    [state_WF(team42,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team42)), state_WF(team42,:,k),'Fun',stream);
    t42f(i,k)=t42f(i,k)+t_new;
    e42f(i,k)=e42f(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during function development');
    end
end
%Team 43 function development
for k=1:10
    [state_WF(team43,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team43)), state_WF(team43,:,k),'Fun',stream);
    t43f(i,k)=t43f(i,k)+t_new;
    e43f(i,k)=e43f(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during function development');
    end
end
%Team 44 function development
for k=1:10
    [state_WF(team44,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team44)), state_WF(team44,:,k),'Fun',stream);
    t44f(i,k)=t44f(i,k)+t_new;
    e44f(i,k)=e44f(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during requirements development');
    end
end
%determine total time doing functional work and total effort
% each level of the heirarchy goes in parallel to find total time

t_fun_WF(i)=t_pintf(i)+max([t1f(i) t2f(i) t3f(i) t4f(i)])+max([ sum(t11f(i,:)) sum(t12f(i,:)) sum(t13f(i,:)) sum(t21f(i,:)) sum(t22f(i,:)) sum(t23f(i,:)) sum(t31f(i,:)) sum(t32f(i,:)) sum(t41f(i,:)) sum(t42f(i,:)) sum(t43f(i,:)) sum(t44f(i,:))]);
e_fun_WF(i)=e_pintf(i)+e1f(i)+e2f(i)+e3f(i)+e4f(i)+sum(e11f(i,:)) +sum(e12f(i,:))+ sum(e13f(i,:))+ sum(e21f(i,:))+ sum(e22f(i,:))+ sum(e23f(i,:))+ sum(e31f(i,:))+ sum(e32f(i,:))+ sum(e41f(i,:))+ sum(e42f(i,:))+ sum(e43f(i,:))+ sum(e44f(i,:));%effort is sum of all manhours


%% Perform preliminary design
% preliminary design performed by lower level teams. Integrators not
% involved.
%Set integrator states assuming positive outcome from preliminary design effort. 
state_WF(pint,:,1)='St';
state_WF(t1int,:,1)='St'; 
state_WF(t2int,:,1)='St';
state_WF(t3int,:,1)='St';
state_WF(t4int,:,1)='St';
% each team designs 10 functions
%team 11 preliminary design 
for k=1:10
    [state_WF(team11,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team11)), state_WF(team11,:,k),'PDn',stream);
    t11p(i,k)=t11p(i,k)+t_new;
    e11p(i,k)=e11p(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during preliminary design');
    end
end
%Team 12 preliminary design
for k=1:10
    [state_WF(team12,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team12)), state_WF(team12,:,k),'PDn',stream);
    t12p(i,k)=t12p(i,k)+t_new;
    e12p(i,k)=e12p(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during preliminary design');
    end
end
%Team 13 preliminary design
for k=1:10
    [state_WF(team13,:,k), t_new,e_new, rf] = WF_scheduler(eng(:,:,(team13)), state_WF(team13,:,k),'PDn',stream);
    t13p(i,k)=t13p(i,k)+t_new;
    e13p(i,k)=e13p(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during preliminary design');
    end
end
for k=1:10
    %team 21 preliminary design
    [state_WF(team21,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team21)), state_WF(team21,:,k),'PDn',stream);
    t21p(i,k)=t21p(i,k)+t_new;
    e21p(i,k)=e21p(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during preliminary design');
    end
end
%Team 22 preliminary design
for k=1:10
    [state_WF(team22,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team22)), state_WF(team22,:,k),'PDn',stream);
    t22p(i,k)=t22p(i,k)+t_new;
    e22p(i,k)=e22p(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during preliminary design');
    end
end
%Team 23 preliminary design
    for k=1:10
    [state_WF(team23,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team23)), state_WF(team23,:,k),'PDn',stream);
    t23p(i,k)=t23p(i,k)+t_new;
    e23p(i,k)=e23p(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during preliminary design');
    end
end

%team 31 preliminary design
for k=1:10
    [state_WF(team31,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team31)), state_WF(team31,:,k),'PDn',stream);
    t31p(i,k)=t31p(i,k)+t_new;
    e31p(i,k)=e31p(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during preliminary design');
    end
end
%Team 32 preliminary design
for k=1:10
    [state_WF(team32,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team32)), state_WF(team32,:,k),'PDn',stream);
    t32p(i,k)=t32p(i,k)+t_new;
    e32p(i,k)=e32p(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during function development');
    end
end
%team 41 preliminary design 
for k=1:10
    [state_WF(team41,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team41)), state_WF(team41,:,k),'PDn',stream);
    t41p(i,k)=t41p(i,k)+t_new;
    e41p(i,k)=e41p(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during preliminary design');
    end
end
%Team 42 preliminary design
for k=1:10
    [state_WF(team42,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team42)), state_WF(team42,:,k),'PDn',stream);
    t42p(i,k)=t42p(i,k)+t_new;
    e42p(i,k)=e42p(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during preliminary design');
    end
end
%Team 43 preliminary design
for k=1:10
    [state_WF(team43,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team43)), state_WF(team43,:,k),'PDn',stream);
    t43p(i,k)=t43p(i,k)+t_new;
    e43p(i,k)=e43p(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during preliminary design');
    end
end
%Team 44 preliminary design
for k=1:10
    [state_WF(team44,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team44)), state_WF(team44,:,k),'PDn',stream);
    t44p(i,k)=t44p(i,k)+t_new;
    e44p(i,k)=e44p(i,k)+e_new;
    if sum(rf)~=0
    disp('Error: reformulations occur during preliminary design');
    end
end
%determine total time doing preliminary design work and total effort
% each level of the heirarchy goes in parallel to find total time

t_pdn_WF(i)=max([sum(t11p(i,:)) sum(t12p(i,:)) sum(t13p(i,:)) sum(t21p(i,:)) sum(t22p(i,:)) sum(t23p(i,:)) sum(t31p(i,:)) sum(t32p(i,:)) sum(t41p(i,:)) sum(t42p(i,:)) sum(t43p(i,:)) sum(t44p(i,:))]);
e_pdn_WF(i)=sum(e11p(i,:))+sum(e12p(i,:))+sum(e13p(i,:))+sum(e21p(i,:))+sum(e22p(i,:))+sum(e23p(i,:))+sum(e31p(i,:))+sum(e32p(i,:))+sum(e41p(i,:))+sum(e42p(i,:))+sum(e43p(i,:))+sum(e44p(i,:));%effort is sum of all manhours



%% Perform detailed design including rework during reformulations
% detailed design performed by lower level teams. Integrators not
% involved.
%Set integrator states assuming positive outcome from detailed design effort. 
state_WF(pint,:,1)='Dc';
state_WF(t1int,:,1)='Dc'; 
state_WF(t2int,:,1)='Dc';
state_WF(t3int,:,1)='Dc';
state_WF(t4int,:,1)='Dc';
% each team performs detailed design for 10 functions
%team 11 detailed design 
for k=1:10
    [state_WF(team11,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team11)), state_WF(team11,:,k),'DDn',stream);
    t11d(i,k)=t11d(i,k)+t_new;
    e11d(i,k)=e11d(i,k)+e_new;
    rf11(:,i,k)=rf;
end
%Team 12 detailed design
for k=1:10
    [state_WF(team12,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team12)), state_WF(team12,:,k),'DDn',stream);
    t12d(i,k)=t12d(i,k)+t_new;
    e12d(i,k)=e12d(i,k)+e_new;
    rf12(:,i,k)=rf;
end
%Team 13 detailed design
for k=1:10
    [state_WF(team13,:,k), t_new,e_new, rf] = WF_scheduler(eng(:,:,(team13)), state_WF(team13,:,k),'DDn',stream);
    t13d(i,k)=t13d(i,k)+t_new;
    e13d(i,k)=e13d(i,k)+e_new;
    rf13(:,i,k)=rf;
end
%team 21 detailed design
for k=1:10
    [state_WF(team21,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team21)), state_WF(team21,:,k),'DDn',stream);
    t21d(i,k)=t21d(i,k)+t_new;
    e21d(i,k)=e21d(i,k)+e_new;
    rf21(:,i,k)=rf;
end
%Team 22 detailed design
for k=1:10
    [state_WF(team22,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team22)), state_WF(team22,:,k),'DDn',stream);
    t22d(i,k)=t22d(i,k)+t_new;
    e22d(i,k)=e22d(i,k)+e_new;
    rf22(:,i,k)=rf;
end
%Team 23 detailed design
for k=1:10
    [state_WF(team23,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team23)), state_WF(team23,:,k),'DDn',stream);
    t23d(i,k)=t23d(i,k)+t_new;
    e23d(i,k)=e23d(i,k)+e_new;
    rf23(:,i,k)=rf;
end
%team 31 detailed design
for k=1:10
    [state_WF(team31,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team31)), state_WF(team31,:,k),'DDn',stream);
    t31d(i,k)=t31d(i,k)+t_new;
    e31d(i,k)=e31d(i,k)+e_new;
    rf31(:,i,k)=rf;
end
%Team 32 detailed design
for k=1:10
    [state_WF(team32,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team32)), state_WF(team32,:,k),'DDn',stream);
    t32d(i,k)=t32d(i,k)+t_new;
    e32d(i,k)=e32d(i,k)+e_new;
    rf32(:,i,k)=rf;
end
%team 41 detailed design 
for k=1:10
    [state_WF(team41,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team41)), state_WF(team41,:,k),'DDn',stream);
    t41d(i,k)=t41d(i,k)+t_new;
    e41d(i,k)=e41d(i,k)+e_new;
    rf41(:,i,k)=rf;
end
%Team 42 detailed design
for k=1:10
    [state_WF(team42,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team42)), state_WF(team42,:,k),'DDn',stream);
    t42d(i,k)=t42d(i,k)+t_new;
    e42d(i,k)=e42d(i,k)+e_new;
    rf42(:,i,k)=rf;
end
%Team 43 detailed design
for k=1:10
    [state_WF(team43,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team43)), state_WF(team43,:,k),'DDn',stream);
    t43d(i,k)=t43d(i,k)+t_new;
    e43d(i,k)=e43d(i,k)+e_new;
    rf43(:,i,k)=rf;
end
%Team 44 detailed design
for k=1:10
    [state_WF(team44,:,k), t_new, e_new, rf] = WF_scheduler(eng(:,:,(team44)), state_WF(team44,:,k),'DDn',stream);
    t44d(i,k)=t44d(i,k)+t_new;
    e44d(i,k)=e44d(i,k)+e_new;
    rf44(:,i,k)=rf;
end
%determine total time doing detailed design work and total effort
% each level of the heirarchy goes in parallel to find total time

t_ddn_WF(i)=max([sum(t11d(i,:)) sum(t12d(i,:)) sum(t13d(i,:)) sum(t21d(i,:)) sum(t22d(i,:)) sum(t23d(i,:)) sum(t31d(i,:)) sum(t32d(i,:)) sum(t41d(i,:)) sum(t42d(i,:)) sum(t43d(i,:)) sum(t44d(i,:))]);
e_ddn_WF(i)=sum(e11d(i,:))+sum(e12d(i,:))+sum(e13d(i,:))+sum(e21d(i,:))+sum(e22d(i,:))+sum(e23d(i,:))+sum(e31d(i,:))+sum(e32d(i,:))+sum(e41d(i,:))+sum(e42d(i,:))+sum(e43d(i,:))+sum(e44d(i,:));%effort is sum of all manhours
e_rf1_WF(i)=sum(rf11(1,i,:))+sum(rf12(1,i,:))+sum(rf13(1,i,:))+sum(rf21(1,i,:))+sum(rf22(1,i,:))+sum(rf23(1,i,:))+sum(rf31(1,i,:))+sum(rf32(1,i,:))+sum(rf41(1,i,:))+sum(rf42(1,i,:))+sum(rf43(1,i,:))+sum(rf44(1,i,:)); %effort expended doing type 1 reformulations
e_rf2_WF(i)=sum(rf11(2,i,:))+sum(rf12(2,i,:))+sum(rf13(2,i,:))+sum(rf21(2,i,:))+sum(rf22(2,i,:))+sum(rf23(2,i,:))+sum(rf31(2,i,:))+sum(rf32(2,i,:))+sum(rf41(2,i,:))+sum(rf42(2,i,:))+sum(rf43(2,i,:))+sum(rf44(2,i,:)); %effort expended doing type 2 reformulations
e_rf3_WF(i)=sum(rf11(3,i,:))+sum(rf12(3,i,:))+sum(rf13(3,i,:))+sum(rf21(3,i,:))+sum(rf22(3,i,:))+sum(rf23(3,i,:))+sum(rf31(3,i,:))+sum(rf32(3,i,:))+sum(rf41(3,i,:))+sum(rf42(3,i,:))+sum(rf43(3,i,:))+sum(rf44(3,i,:)); %effort expended doing type 2 reformulations
t_rf_WF(i)=max([ sum(rf11(4,i,:)) sum(rf12(4,i,:)) sum(rf13(4,i,:)) sum(rf21(4,i,:)) sum(rf22(4,i,:)) sum(rf23(4,i,:)) sum(rf31(4,i,:)) sum(rf32(4,i,:)) sum(rf41(4,i,:)) sum(rf42(4,i,:)) sum(rf43(4,i,:)) sum(rf44(4,i,:))]);

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

bin1=[400:100:3200];

figure (1)
histogram (t_WF,bin1);
hold on
xlabel ('Time to complete software design (hrs)');
ylabel ('count');
title ('Histogram of waterfall simulation design times');
xlim([400 3200]);
ylim ([0 40]);
hold off

disp('Average time to complete waterfall software design');
avg_t_WF=mean(t_WF)

disp('Stdev time to complete waterfall software design');
std_t_WF=std(t_WF)
[h,p,adstat,cv] = adtest(t_WF)
figure (2)
histogram (e_WF);
hold on
xlabel ('Effort-hours to complete software design (hrs)');
ylabel ('count');
title ('Histogram of waterfall simulation design times');
%xlim([0 80]);
%ylim ([0 700]);
hold off

disp('Average effort to complete waterfall software design (Manhours)');
avg_e_WF=mean(e_WF)

disp('Stdev effort to complete waterfall software design (Manhours)');
std_e_WF=std(e_WF)
[h,p,adstat,cv] = adtest(e_WF)
figure (3)
histogram (t_rf_WF);
hold on
xlabel ('Time spent doing rework (hrs)');
ylabel ('count');
title ('Histogram of waterfall simulation design times');
%xlim([0 80]);
%ylim ([0 700]);
hold off

disp('Average time spent in rework for waterfall software');
avg_rf_WF=mean(t_rf_WF)

disp('Stdev time spent in rework for waterfall software');
std_rf_WF=std(t_rf_WF)
[h,p,adstat,cv] = adtest(t_rf_WF)

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

%Team 4 integrator requirements development 
[state_A(t4int,:,1), t_new,e_new, rf] = WF_scheduler(eng(:,:,(t4int)), state_A(t4int,:,1),'Req',stream);
t4A(i)=t4A(i)+t_new;
e4A(i)=e4A(i)+e_new;
if sum(rf)~=0
disp('Error: reformulations occur during requirements development');
end
%Time and effort spent on initial planning
t_req_A(i)=t_pintA(i)+max([t1A(i) t2A(i) t3A(i) t4A(i)]); %Time spent on initial planning
e_req_A(i)=e_pintA(i)+e1A(i)+e2A(i)+e3A(i)+e4A(i);%effort is sum of all manhours

%% Perform agile sprints to develop work by lower level teams

%Set integrator states assuming positive outcome from  design effort. 
state_A(pint,:,1)='Dc';
state_A(t1int,:,1)='Dc'; 
state_A(t2int,:,1)='Dc';
state_A(t3int,:,1)='Dc';
state_A(t4int,:,1)='Dc';
% each team performs design for 10 functions
%team 11 sprints 
for k=1:10
    [state_A(team11,:,k), t_new, e_new, rf] = A_scheduler(eng(:,:,(team11)), state_A(team11,:,k),'Req',stream);
    t11A(i,k)=t11A(i,k)+t_new;
    e11A(i,k)=e11A(i,k)+e_new;
    rf11A(:,i,k)=rf;
end
%Team 12 sprints
for k=1:10
    [state_A(team12,:,k), t_new, e_new, rf] = A_scheduler(eng(:,:,(team12)), state_A(team12,:,k),'Req',stream);
    t12A(i,k)=t12A(i,k)+t_new;
    e12A(i,k)=e12A(i,k)+e_new;
    rf12A(:,i,k)=rf;
end
%Team 13 sprints
for k=1:10
    [state_A(team13,:,k), t_new,e_new, rf] = A_scheduler(eng(:,:,(team13)), state_A(team13,:,k),'Req',stream);
    t13A(i,k)=t13A(i,k)+t_new;
    e13A(i,k)=e13A(i,k)+e_new;
    rf13A(:,i,k)=rf;
end
%team 21 sprints
for k=1:10
    [state_A(team21,:,k), t_new, e_new, rf] = A_scheduler(eng(:,:,(team21)), state_A(team21,:,k),'Req',stream);
    t21A(i,k)=t21A(i,k)+t_new;
    e21A(i,k)=e21A(i,k)+e_new;
    rf21A(:,i,k)=rf;
end
%Team 22 sprints
for k=1:10
    [state_A(team22,:,k), t_new, e_new, rf] = A_scheduler(eng(:,:,(team22)), state_A(team22,:,k),'Req',stream);
    t22A(i,k)=t22A(i,k)+t_new;
    e22A(i,k)=e22A(i,k)+e_new;
    rf22A(:,i,k)=rf;
end
%Team 23 sprints
for k=1:10
    [state_A(team23,:,k), t_new, e_new, rf] = A_scheduler(eng(:,:,(team23)), state_A(team23,:,k),'Req',stream);
    t23A(i,k)=t23A(i,k)+t_new;
    e23A(i,k)=e23A(i,k)+e_new;
    rf23A(:,i,k)=rf;
end
%team 31 sprints
for k=1:10
    [state_A(team31,:,k), t_new, e_new, rf] = A_scheduler(eng(:,:,(team31)), state_A(team31,:,k),'Req',stream);
    t31A(i,k)=t31A(i,k)+t_new;
    e31A(i,k)=e31A(i,k)+e_new;
    rf31A(:,i,k)=rf;
end
%Team 32 sprints
for k=1:10
    [state_A(team32,:,k), t_new, e_new, rf] = A_scheduler(eng(:,:,(team32)), state_A(team32,:,k),'Req',stream);
    t32A(i,k)=t32A(i,k)+t_new;
    e32A(i,k)=e32A(i,k)+e_new;
    rf32A(:,i,k)=rf;
end
%team 41 sprints
for k=1:10
    [state_A(team41,:,k), t_new, e_new, rf] = A_scheduler(eng(:,:,(team41)), state_A(team41,:,k),'Req',stream);
    t41A(i,k)=t41A(i,k)+t_new;
    e41A(i,k)=e41A(i,k)+e_new;
    rf41A(:,i,k)=rf;
end
%Team 42 sprints
for k=1:10
    [state_A(team42,:,k), t_new, e_new, rf] = A_scheduler(eng(:,:,(team42)), state_A(team42,:,k),'Req',stream);
    t42A(i,k)=t42A(i,k)+t_new;
    e42A(i,k)=e42A(i,k)+e_new;
    rf42A(:,i,k)=rf;
end
%Team 43 sprints
for k=1:10
    [state_A(team43,:,k), t_new, e_new, rf] = A_scheduler(eng(:,:,(team43)), state_A(team43,:,k),'Req',stream);
    t43A(i,k)=t43A(i,k)+t_new;
    e43A(i,k)=e43A(i,k)+e_new;
    rf43A(:,i,k)=rf;
end
%Team 44 sprints
for k=1:10
    [state_A(team44,:,k), t_new, e_new, rf] = A_scheduler(eng(:,:,(team44)), state_A(team44,:,k),'Req',stream);
    t44A(i,k)=t44A(i,k)+t_new;
    e44A(i,k)=e44A(i,k)+e_new;
    rf44A(:,i,k)=rf;
end
% Collect metrics from sprints
t_DA(i)=max([sum(t11A(i,:)) sum(t12A(i,:)) sum(t13A(i,:)) sum(t21A(i,:)) sum(t22A(i,:)) sum(t23A(i,:)) sum(t31A(i,:)) sum(t32A(i,:)) sum(t41A(i,:)) sum(t42A(i,:)) sum(t43A(i,:)) sum(t44A(i,:))]);
e_DA(i)=sum(e11A(i,:))+sum(e12A(i,:))+sum(e13A(i,:))+sum(e21A(i,:))+sum(e22A(i,:))+sum(e23A(i,:))+sum(e31A(i,:))+sum(e32A(i,:))+sum(e41A(i,:))+sum(e42A(i,:))+sum(e43A(i,:))+sum(e44A(i,:));%effort is sum of all manhours
e_rf1_A(i)=sum(rf11A(1,i,:))+sum(rf12A(1,i,:))+sum(rf13A(1,i,:))+sum(rf21A(1,i,:))+sum(rf22A(1,i,:))+sum(rf23A(1,i,:))+sum(rf31A(1,i,:))+sum(rf32A(1,i,:))+sum(rf41A(1,i,:))+sum(rf42A(1,i,:))+sum(rf43A(1,i,:))+sum(rf44A(1,i,:)); %effort expended doing type 1 reformulations
e_rf2_A(i)=sum(rf11A(2,i,:))+sum(rf12A(2,i,:))+sum(rf13A(2,i,:))+sum(rf21A(2,i,:))+sum(rf22A(2,i,:))+sum(rf23A(2,i,:))+sum(rf31A(2,i,:))+sum(rf32A(2,i,:))+sum(rf41A(2,i,:))+sum(rf42A(2,i,:))+sum(rf43A(2,i,:))+sum(rf44A(2,i,:)); %effort expended doing type 2 reformulations
e_rf3_A(i)=sum(rf11A(3,i,:))+sum(rf12A(3,i,:))+sum(rf13A(3,i,:))+sum(rf21A(3,i,:))+sum(rf22A(3,i,:))+sum(rf23A(3,i,:))+sum(rf31A(3,i,:))+sum(rf32A(3,i,:))+sum(rf41A(3,i,:))+sum(rf42A(3,i,:))+sum(rf43A(3,i,:))+sum(rf44A(3,i,:)); %effort expended doing type 2 reformulations
t_rf_A(i)=max([ sum(rf11A(4,i,:)) sum(rf12A(4,i,:)) sum(rf13A(4,i,:)) sum(rf21A(4,i,:)) sum(rf22A(4,i,:)) sum(rf23A(4,i,:)) sum(rf31A(4,i,:)) sum(rf32A(4,i,:)) sum(rf41A(4,i,:)) sum(rf42A(4,i,:)) sum(rf43A(4,i,:)) sum(rf44A(4,i,:))]);

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
xlabel ('Time to complete software design (hrs)');
ylabel ('count');
title ('Histogram of agile simulation design times');
xlim([400 3200]);
ylim ([0 40]);
hold off

disp('Average time to complete agile software design');
avg_t_A=mean(t_A)

disp('StdDev time to complete agile software design');
std_t_A=std(t_A)
[h,p,adstat,cv] = adtest(t_A)
figure (5)
histogram (e_A);
hold on
xlabel ('Effort-hours to complete software design (hrs)');
ylabel ('count');
title ('Histogram of agile simulation design times');
%xlim([0 80]);
%ylim ([0 700]);
hold off

disp('Average effort to complete agile software design (Manhours)');
avg_e_A=mean(e_A)

disp('Stdev of effort to complete agile software design (Manhours)');
std_e_A=std(e_A)
[h,p,adstat,cv] = adtest(e_A)
figure (6)
histogram (t_rf_A);
hold on
xlabel ('Time spent in rework (hrs)');
ylabel ('count');
title ('Histogram of agile simulation design times');
%xlim([0 80]);
%ylim ([0 700]);
hold off

disp('Average time spent in rework for agile software');
avg_rf_A=mean(t_rf_A)

disp('Stdev time spent in rework for agile software');
std_rf_A=std(t_rf_A)
[h,p,adstat,cv] = adtest(t_rf_A)
disp('')
disp('Ratio of average time to complete software design')
ratio_t=avg_t_A/avg_t_WF
disp('Ratio of averate effort to complete software design')
ratio_e=avg_e_A/avg_e_WF
disp('Ratio of time spent in rework')
ratio_rf=avg_rf_A/avg_rf_WF
