function [eng] = FBS_Designator(N, FBS_mat, FBS_var, stream)
% Creates a 5X5XN matrix where each 5X5 matrix represents
% an FBS transition matrix for an individual.
% 
% FBS transition matrix is setup as follows:
%
%			R	F	Be	S	D
%		R	X	X	0	0	0
%		F	0	X	X	0	0
%		Be	0	0	X	X	0
%		S	0	X	X	X	X
%		D	0	0	0	0	X
%
% X's denote a value and 0's denote an enforced 0, i.e. there is no
% possibility of making a transition to that state.
% The Be state, the analysis process, and evaluation process are
% modeled as being part of the Structure state as they must be performed
% anytime the structure state is reached and including them would also require
% setting up a complex logic framework to indicate next states based on states that
% had previously been visited.
%
% Random variables are used to determine the values in the matrix with FBS_mat representing
% the mean, and FBS_var representing the maximum expected variation from the mean
%
% Mitch Bott 8-21-17
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

eng=zeros(5,5,N); %Initialize engineer matrix

FBS_shape = [ 1 1 0 0 0 %Initialize a matrix of 1's and 0's to match the FBS transition matrix
0 1 1 0 0 
0 0 1 1 0
0 1 1 1 1
0 0 0 0 1];

for i = 1:N %for each engineer

% get random value

prob= rand(stream,5); % Create a 5x5 array of random numbers
prob = prob*FBS_shape; % make array similar to FBS matrices

engi (:,:,i) = FBS_mat+(2*prob-FBS_shape).*FBS_var; %initialize engineer's FBS matrix based on the mean (FBS_mat) +/- variation up to 3 sigma (FBS_var)
for j=1:5
    for k=1:5
if engi(j,k,i) <0
    engi(j,k,i)=0; %set transition probability to 0 if it is less than 0
end
    end
end

    
    
% Normalize values to obtain transition probabilities that sum to 1 across
% rows
eng(1,1,i)=engi(1,1,i)/(engi(1,1,i)+engi(1,2,i));
eng(1,2,i)=engi(1,2,i)/(engi(1,1,i)+engi(1,2,i));
eng(2,2,i)=engi(2,2,i)/(engi(2,2,i)+engi(2,3,i));
eng(2,3,i)=engi(2,3,i)/(engi(2,2,i)+engi(2,3,i));
eng(3,3,i)=engi(3,3,i)/(engi(3,3,i)+engi(3,4,i));
eng(3,4,i)=engi(3,4,i)/(engi(3,3,i)+engi(3,4,i));
eng(4,2,i)=engi(4,2,i)/(engi(4,2,i)+engi(4,3,i)+engi(4,4,i)+engi(4,5,i));
eng(4,3,i)=engi(4,3,i)/(engi(4,2,i)+engi(4,3,i)+engi(4,4,i)+engi(4,5,i));
eng(4,4,i)=engi(4,4,i)/(engi(4,2,i)+engi(4,3,i)+engi(4,4,i)+engi(4,5,i));
eng(4,5,i)=engi(4,5,i)/(engi(4,2,i)+engi(4,3,i)+engi(4,4,i)+engi(4,5,i));
eng(5,5,i)=1;

end