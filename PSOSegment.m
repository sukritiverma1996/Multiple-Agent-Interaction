for j=18809:20000,
	goal=randi([35 40],1,2);
	R=ones(gridsize,gridsize).*(-1);
	R(goal(1),goal(2))=100;
	for i=1:I
		y=0;
		while y<Y,
			k=1;
			state=[1 1];
			E=0;
			flag=0;
			
			while k<K,
				decision=rand(1);
				if decision<=epsilon,
					[nextactionq nextaction]=max(Q(i,state(1),state(2),:));
				else
					nextaction=randi([1 4],1,1);
				end
				while Q(i, state(1), state(2), nextaction) == -inf,
					nextaction = nextaction+1;
                	if nextaction>4,
                    	nextaction = 1;
                	end
				end
				nextstate = nextState(state,nextaction,gridsize);
				nextqbest=max(Q(i,nextstate(1),nextstate(2),:));
				Q(i,state(1),state(2),nextaction)=(1-alpha)*Q(i,state(1),state(2),nextaction)+alpha*(R(nextstate(1),nextstate(2))+discount*nextqbest);
				if state==goal,
					flag=1;
					L=k;
					break
				end
				state=nextstate;
				E=E+R(nextstate(1),nextstate(2))/(discount^k);
				k=k+1;
			end

			if flag==0,
				L=K;
			end
				E=E*(discount^L);
			if E>Ei(i),
				Pbest(i,:,:,:)=Q(i,:,:,:);
				Ei(i)=E;
			end
			if E>Eg,
				Gbest(1,:,:,:)=Q(i,:,:,:);
				Eg=E;
			end
			psoactionmaster(iter)=L;
			iter=iter+1;
			y=y+1;
		end
	end
	rand1=rand(1);
	rand2=rand(1);
	for agent=1:I,
		V(agent,:,:,:)=W.*V(agent,:,:,:)+C1*rand1.*(Pbest(agent,:,:,:)-Q(agent,:,:,:))+C2*rand2.*(Gbest(1,:,:,:)-Q(agent,:,:,:));
		Q(agent,:,:,:)=Q(agent,:,:,:)+V(agent,:,:,:);
	end
	t=t+I*Y;
end