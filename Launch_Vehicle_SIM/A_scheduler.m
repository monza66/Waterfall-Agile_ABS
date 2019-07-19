function [state_A, ti, e, rf,design] = A_scheduler(eng, state_A,state,stream,designdata,col,design)
% Marches FBS agents from R to D
% Keeps track of the amount of time and effort (manhours) required to 
% reach D
% Assumptions:
%	All agents must reach the next state in order to complete the current
%	state
%
% Modified on 10/25/18 for LV design simulation

%initialize counters
N=size(eng,3); %Number of agents
%t(N)=0; %Time
%rft(N)=0; %Reformulation time
rft=0; %reformulation time counter
e=0; %effort
rf=[0 0 0 0]; %Effort for reformulations
endr=1; %ending flag
rflag=zeros(N,1); %reformulation flag
t=0; %time 
if state ~= 'Req' %doing requirements development
	disp('Invalid starting state for A_scheduler.m')
else
   % Agile's goal is to reach D (working code) as soon as possible, some
   % agents will reach this earlier than others on a team. That is
   % permissible since it represents them creating their portion of the
   % project early in the process
   while endr==1
   for i=1:N
    %Transition R to D
    
    if state_A(i,:)~='Dc'	%Possible that reformulations will cause multiple previous states to be revisited	
			[state_A(i,:), Proc] = FBStrans(eng(:,:,i),state_A(i,:),stream);%advance FBS state
			e=e+1; %Increment effort
            %t(i)=t(i)+1; %Increment time

            %Track efforts associated with each reformulation type
            if rflag(i)==1
                rf(1)=rf(1)+1;
            elseif rflag(i)==2
                rf(2)=rf(2)+1;
            elseif rflag(i)==3
                rf(3)=rf(3)+1;
            end
			%Track effort associated with each reformulation and trigger
			%reformulation flag for first reformulation
            if Proc=='rf1'
                rf(1)=rf(1)+1;
                rflag(i)=1;
            elseif Proc=='rf2'
                rf(2)=rf(2)+1;
                rflag(i)=2;
			elseif Proc=='rf3'
                rf(3)=rf(3)+1;
                rflag(i)=3;
            end
    end
   
   end
     t=t+1;
            if sum(rflag)~=0 %if we are doing reformulations
              %  rft(i)=rft(i)+1; %increment reformulation counter by 1
              rft=rft+1; %increment reformulation time counter by 1
             
            end
   %Check for meeting termination criteria (all agents at state D)
       test=0; 
       for j=1:N   
            if state_A(i,:)=='Dc' %Check if all agents are at state D
              test=test+1;  
            end
       end
        if test==N %All agents are at D
            % determine design variable
            [design(col),refreq] = find_design_var(designdata,col,design,stream);
            %refreq=0; %Test to eliminate design coupling
            if refreq==1 %reformulation forced by design incompatibility
                % set all agents back to S
                for j=1:N   
                       state_A(i,:)='St' ;
                       e=e+1; %Increment effort
                     %  t(i)=t(i)+1; %Increment time
                       %rft(i)=rft(i)+1; %increment reformulation counter by 1
                       
                end
                t=t+1;
                rft=rft+1; %increment reformulation time counter by 1
                rf(1)=rf(1)+1; %Track as a type 1 reformulation - assumed that design is close and just needs adjustment to meet integration needs
            else % no reformulation needed, design is closed
                endr=0; %If all agents are at D. End loop
            end
        end
   end
 %  ti=max(t(:)); %Time is based on which agent takes the longest amount of time
   ti=t;
   rf(4)=rft;%Reformulation time %max(rft(:)); %Reformulation time is based on the worst-case reformulation time
end
end    
