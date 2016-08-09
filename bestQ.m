alpha=0.1;
discount=0.999;
K=10000;
I=4;
gridsize=40;
T=5000;
epsilon=0.8;
Q=zeros(I,gridsize,gridsize,4);
actionmaster=zeros(T*I,1);
iter=1;
for t=1:T,
	Qbest=zeros(gridsize,gridsize,4);
	goal=randi([gridsize-5 gridsize], 1,2);
	R=ones(gridsize,gridsize).*(-1);
	R(goal(1),goal(2))=100;
	%Ebest=-inf;
	%L=zeros(I,1);
	E=zeros(I,1);
	for i=1:I,
		state=[1 1];
		
		k=1;
		flag=0;
		
		while k<K,
			nextstate=state;
				check=rand(1);
			
				if check<epsilon,
					[maxq nextaction]=max(Q(i,state(1),state(2),:));
				else
					nextaction=randi([1 4],1,1);
				end
				[nextstate possible]=nextState(state,nextaction,gridsize);
			
			maxnextq=max(Q(i,nextstate(1),nextstate(2),:));
			Q(i,state(1),state(2),nextaction)=(1-alpha)*Q(i,state(1),state(2),nextaction)+alpha*discount*maxnextq+alpha*(R(nextstate(1),nextstate(2)));

			E(i)=E(i)+R(nextstate(1),nextstate(2))/(discount^k);
			if state==goal,
				L=k;
				flag=1;
				break
			end
			state=nextstate;
			k=k+1;
		end
		if flag==0,
			L=K;
		end
		E(i)=E(i)*(discount^L);
		actionmaster(iter)=L;
		iter=iter+1;
	end
	[Ebest maxagent]=max(E);
	Qbest(:,:,:)=Q(maxagent,:,:,:);
	for j=1:I,
		Q(j,:,:,:)=Qbest(:,:,:);
	end
end

