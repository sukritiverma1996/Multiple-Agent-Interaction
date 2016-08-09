function [nextstate possibility]=nextState(state,maxaction,gridsize)
	nextstate=state;
	possibility=0;
	switch maxaction
		%up
		case 1
			if state(1)>1,
				nextstate=[state(1)-1 state(2)];
			else
				possibility=1;
			end
		%right
		case 2
			if state(2)<gridsize,
				nextstate=[state(1) state(2)+1];
			else
				possibility=1;
			end
		%down
		case 3
			if state(1)<gridsize,
				nextstate=[state(1)+1 state(2)];
			else
				possibility=1;
			end	
		%left
		case 4
			if state(2)>1,
				nextstate=[state(1) state(2)-1];
			else
				possibility=1;
			end		
	end
end
