gridsize = 40;
Q750Walls =zeros(gridsize,gridsize,4);
Walls = randi([1 gridsize], 700, 2);
Act = randi([1 4], 700, 1);
for i=1:700,
	Q750Walls(Walls(i, 1), Walls(i, 2), Act(i, 1)) = -inf;
end

%Setting boundary action Q values to -inf
Q750Walls(1,:,1)=-inf;
Q750Walls(:,1,4)=-inf;
Q750Walls(gridsize,:,3)=-inf;
Q750Walls(:,gridsize,2)=-inf;