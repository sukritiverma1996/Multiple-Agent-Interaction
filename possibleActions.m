function [possibleactions ]=possibleActions(state,gridsize)
	nextstate=state;
	possibleactions=zeros(4,1);
	possibility=0;
			if state(1)>1,
				%nextstate=[state(1)-1 state(2)];
			else
				possibileactions(1)=1;
			
			end
		%right
			if state(2)<gridsize,
				%nextstate=[state(1) state(2)+1];
			else
				possibileactions(2)=1;
			end
		%down
			if state(1)<gridsize,
				%nextstate=[state(1)+1 state(2)];
			else
				possibileactions(3)=1;
			end	
		%left
			if state(2)>1,
				%nextstate=[state(1) state(2)-1];
			else
				possibileactions(4)=1;
			end		

end
