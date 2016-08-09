alpha = 0.1;
gamma = 0.999;
gridsize = 40;
%action index 1 implies go up
%action index 2 implies go right
%action index 3 implies go down
%action index 4 implies go left

Q = zeros(gridsize,gridsize,4);
R = zeros(gridsize,gridsize)-1;
epsilon = 0.8;
K = 10000;
k = 1;
state = [1 1];

% Walls = randi([1 gridsize], 400, 2);
% Act = randi([1 4], 400, 1);
% for i=1:400,
% 	Q(Walls(i, 1), Walls(i, 2), Act(i, 1)) = -inf;
% end
% 
% %Setting boundary action Q values to -inf
% Q(1,:,1)=-inf;
% Q(:,1,4)=-inf;
% Q(gridsize,:,3)=-inf;
% Q(:,gridsize,2)=-inf;

Q(:, :, :) = Q650Walls;
actions = zeros(1, 20000);

for i=1:20000,
  	R = zeros(gridsize,gridsize)-1;
  	goal = randi([35 40], 1, 2);
  	R(goal(1), goal(2)) = 100;
	k=1;
  	flag = 0;
	state=[1 1];
	while k<K,
		check=rand(1);
		%using a random number between 0 & 1, and comparing with epsilon
		if check<=epsilon,
			[maxactionq maxaction]=max(Q(state(1),state(2),:));
		else
			maxaction=randi([1 4], 1, 1);
		end
		while Q(state(1), state(2), maxaction) == -inf,
			maxaction = maxaction+1;
            if maxaction>4,
                maxaction = 1;
            end
		end

		nextstate = nextState(state,maxaction,gridsize);
		[maxnextactionq maxnextaction] = max(Q(nextstate(1),nextstate(2),:));

		Q(state(1),state(2),maxaction) = (1-alpha)*Q(state(1),state(2),maxaction) + alpha*R(nextstate(1),nextstate(2)) + alpha*gamma*maxnextactionq;
		state = nextstate;
		if state(1)==goal(1) && state(2)==goal(2),
			flag = 1;
            actions(1, i) = k;
            break;
		end 
		k=k+1;	
    end
  	if(flag == 0),
    	actions(1, i) = K;
  	end
end