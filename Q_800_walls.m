gridsize = 40;
Q800Walls =zeros(gridsize,gridsize,4);
Walls = randi([1 gridsize], 800, 2);
Act = randi([1 4], 800, 1);
for i=1:800,
	Q800Walls(Walls(i, 1), Walls(i, 2), Act(i, 1)) = -inf;
end

%Setting boundary action Q values to -inf
Q800Walls(1,:,1)=-inf;
Q800Walls(:,1,4)=-inf;
Q800Walls(gridsize,:,3)=-inf;
Q800Walls(:,gridsize,2)=-inf;