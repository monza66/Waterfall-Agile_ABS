function [design_var,refreq] = find_design_var(designdata,col,design,stream)
%find_design_var determines a design variable (1-4) for a design team. It
%also compares this value with a set of feasible designs to determine if
%the team needs to perform a reformulation
% Inputs:
%   designdata is the set of feasible designs
%   col is the column of design data that is currently being chosen
%   design is a vector that defines the design variables already chosen
%   Stream is the random number stream
%
%Outputs:
   %    design_var is the value of the design variable
   %    refreq denotes if a reformulation is required 1=yes, 0= no
prob=rand(stream); % Get random value
%% Determine if the value is 1, 2, 3, or 4

if design(col)==0 %Design variable has not been selected
    % Use uniform probability to find design value
    if prob< 0.25
        design_var =1;
    elseif (prob>=0.25) &&(prob<0.5)
        design_var=2;
    elseif (prob>=0.5) &&(prob<0.75)
        design_var=3;
    else
        design_var=4;
    end
    
    
elseif design(col)==1 %design variable already exists and is 1
    
    if prob< 0.33
        design_var =2;
    elseif (prob>=0.33) &&(prob<0.66)
        design_var=3;
    else
        design_var=4;
    end
elseif design(col)==2 %design variable already exists and is 2
    
    if prob< 0.33
        design_var =1;
    elseif (prob>=0.33) &&(prob<0.66)
        design_var=3;
    else
        design_var=4;
    end
    
elseif design(col)==3 %design variable already exists and is 3
    
    if prob< 0.33
        design_var =1;
    elseif (prob>=0.33) &&(prob<0.66)
        design_var=2;
    else
        design_var=4;
    end
    
elseif design(col)==4 %design variable already exists and is 4
    
    if prob< 0.33
        design_var =1;
    elseif (prob>=0.33) &&(prob<0.66)
        design_var=2;
    else
        design_var=3;
    end
    
end
design(col)=design_var;
%%Check that design is feasible
    sz=size(designdata,1); %length of design data
    sz2=size(designdata,2); %width of design data
    refreq=1; %start with assumption that reformulation is required
    check=any(design,2); %Create vector defining which design elements are non-zero and need to be checked
    for i=1:sz
        if isequal(designdata(i,:).*check',design')==1 %Check to see if non-zero design values are in the list of valid designs
            refreq=0; %valid design found, no need to reformulate
        end
    end

end

