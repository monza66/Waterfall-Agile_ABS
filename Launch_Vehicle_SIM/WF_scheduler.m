function [state_WF, t, e, rf,design] = WF_scheduler(eng, state_WF,state,stream,designdata,col,design)
% Marches all the FBS agents from an initial state to a final state
% Keeps track of the amount of time and effort (manhours) required to 
% reach the final state
% Assumptions:
%	All agents must reach the next state in order to complete the current
%	state
%

endr=0; %end loop flag
%initialize counters
t=0; % time
e=0; %effort
rf=[0 0 0 0]; % effort for reformulations
N=size(eng,3); %Number of agents
rflag=zeros(N,1); %Reformulation flag
if state == 'Req' %doing requirements development
	
	while endr<1
	        
        for i=1:N % for each agent
            if state_WF(i,:)=='Rq'		%If in requirements state
                [state_WF(i,:), ~] = FBStrans(eng(:,:,i),state_WF(i,:),stream); %advance to next state
                e=e+1; %increment effort
            elseif state_WF(i,:)=='Fn'
                %state is allowable
            elseif state_WF(i,:)=='Rq'
                %state is allowable
            else
                X=sprintf('Error, agent %d is not in an allowable state. Should be performing requirements development.',i);
                disp(X);
                break
            end
        end
       t=t+1; %Increment time
      
	%Check to see if all agents have reached end state
    endr=1;
        for j=1:N
           %disp('start') 
           
          % disp('end')
            if state_WF(j,:)=='Rq' %Not all agents done yet
                endr=0; %reset ending flag
                continue
            end		

        end
	

	end


elseif state=='Fun' % doing function development

while endr<1
	for i=1:N
		if state_WF(i,:)=='Fn'		
			[state_WF(i,:), ~] = FBStrans(eng(:,:,i),state_WF(i,:),stream); %Advance to next state
			e=e+1; %Increment effort
        elseif state_WF(i,:)=='Be'
                %state is allowable
        elseif state_WF(i,:)=='Fn'
                %state is allowable
        else
                X=sprintf('Error, agent %d is not in an allowable state. Should be performing function development.',i);
                disp(X)
                break
		end
	end
	t=t+1; %Incremenet time
	endr=1;
	%Check to see if all agents have reached end state
	for j=1:N
		if state_WF(j,:)=='Fn' %Not all agents done yet
			endr=0;
		end		

	end

	end



elseif state=='PDn' % Doing preliminary design

while endr<1
	for i=1:N
		if state_WF(i,:)=='Be'		
			[state_WF(i,:), ~] = FBStrans(eng(:,:,i),state_WF(i,:),stream);
			e=e+1; %Increment effort
        elseif state_WF(i,:)=='St'
                %state is allowable
        elseif state_WF(i,:)=='Be'
                %state is allowable
        else
                X=sprintf('Error, agent %d is not in an allowable state. Should be performing preliminary design.',i);
                disp(X)
                break
		end
	end
	t=t+1; %Increment time
	endr=1;
	%Check to see if all agents have reached end state
	for j=1:N
		
		if state_WF(j,:)=='Be' %Not all agents done yet
			endr=0;
		end		

	end

end




elseif state =='DDn' % doing detailed design

while endr<1
	for i=1:N
		if state_WF(i,:)~='Dc'	%Possible that reformulations will cause multiple previous states to be revisited	
			[state_WF(i,:), Proc] = FBStrans(eng(:,:,i),state_WF(i,:),stream);
			e=e+1;
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
    if sum(rflag)~=0 %If we are doing reformulations
        rf(4)=rf(4)+1;%Increment reformulation time counter by 1
    end
    
    test=0; 
       for j=1:N   
            if state_WF(i,:)=='Dc' %Check if all agents are at state D
              test=test+1;  
            end
       end
    
        if test==N %All agents are at D
            % determine design variable
            [design(col),refreq] = find_design_var(designdata,col,design,stream);
            %refreq=0; %test to force design compatibility
            if refreq==1 %reformulation forced by design incompatibility
                % set all agents back to S
                for j=1:N   
                       state_WF(i,:)='St' ;
                       e=e+1; %Increment effort
                                         
                end
                 t=t+1; %Increment time 
                 rf(4)=rf(4)+1;%Increment reformulation time counter by 1
                rf(1)=rf(1)+1; %Track as a type 1 reformulation - assumed that design is close and just needs adjustment to meet integration needs
            else % no reformulation needed, design is closed
                endr=1; %If all agents are at D. End loop
            end
        end
        

	end


else % Error
	disp('Error: invalid state specified for WF_Scheduler.m');
end