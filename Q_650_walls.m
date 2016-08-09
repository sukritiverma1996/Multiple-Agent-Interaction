gridsize = 40;
Q650Walls =zeros(gridsize,gridsize,4);
Walls = randi([1 gridsize], 650, 2);
Act = randi([1 4], 650, 1);
for i=1:650,
	Q650Walls(Walls(i, 1), Walls(i, 2), Act(i, 1)) = -inf;
end

%Setting boundary action Q values to -inf
Q650Walls(1,:,1)=-inf;
Q650Walls(:,1,4)=-inf;
Q650Walls(gridsize,:,3)=-inf;
Q650Walls(:,gridsize,2)=-inf;