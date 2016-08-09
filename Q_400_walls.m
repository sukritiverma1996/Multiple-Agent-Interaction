gridsize = 40;
Q400Walls =zeros(gridsize,gridsize,4);
Walls = randi([1 gridsize], 400, 2);
Act = randi([1 4], 400, 1);
for i=1:400,
	Q400Walls(Walls(i, 1), Walls(i, 2), Act(i, 1)) = -inf;
end

%Setting boundary action Q values to -inf
Q400Walls(1,:,1)=-inf;
Q400Walls(:,1,4)=-inf;
Q400Walls(gridsize,:,3)=-inf;
Q400Walls(:,gridsize,2)=-inf;