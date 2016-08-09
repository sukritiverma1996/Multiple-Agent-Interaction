import numpy as np
import matplotlib.pyplot as plt
alpha = 0.1
gamma = 0.999
gridsize = 40

Q = np.zeros((gridsize,gridsize,4), dtype = np.double)
Rtemp = np.ones((gridsize,gridsize), dtype = np.int)
R = np.multiply(Rtemp, -1)
epsilon = 0.8
K = 10000
k = 1
state = np.array([0,0])
goal = np.array([gridsize-1, gridsize-1])
R[goal[0], goal[1]] = 100
maxaction = 2

def nextState(state, maxaction, gridsize):
    nextstate = np.copy(state)
    if maxaction==1:
        if state[0]>0:
            nextstate[0] = state[0]-1
        else:
            maxaction = np.random.random_integers(2,4)
            nextstate, maxaction = nextState(state,maxaction,gridsize)
    if maxaction==2:
        if state[1]<gridsize-1:
            nextstate[1] = state[1]+1
        else:
            a = [1, 3, 4]
            maxaction = np.random.choice(a, 1)[0]
            nextstate, maxaction = nextState(state,maxaction,gridsize)
    if maxaction==3:
        if state[0]<gridsize-1:
            nextstate[0] = state[0]+1
        else:
            a = [1, 2, 4]
            maxaction = np.random.choice(a, 1)[0]
            nextstate, maxaction = nextState(state,maxaction,gridsize)
    if maxaction==4:
        if state[1]>0:
            nextstate[1] = state[1]-1
        else:
            maxaction = np.random.random_integers(1,3)
            nextstate, maxaction = nextState(state,maxaction,gridsize)
    return nextstate, maxaction


actions = np.zeros((1, 20000), dtype=np.int)
iterations = np.zeros((1, 20000), dtype=np.int)
for i in range(0, 20000):
    Rtemp = np.ones((gridsize,gridsize), dtype = np.int)
    R = np.multiply(Rtemp, -1)
    goal[0] = np.random.random_integers(34,39)
    goal[1] = np.random.random_integers(34,39)
    R[goal[0], goal[1]] = 100
    k = 1
    flag = 0
    state = np.array([0,0])
    while k<K:
        check = np.random.uniform(0.0, 1.0)
        if check<=epsilon:
            maxactionq = np.amax(Q[state[0],state[1],:])
            maxaction = np.argmax(Q[state[0],state[1],:])
            maxaction = maxaction + 1
        else:
            maxaction = np.random.random_integers(1,4)
        nextstate, maxaction = nextState(state,maxaction,gridsize)
        maxnextactionq = np.amax(Q[nextstate[0],nextstate[1],:])
        maxnextaction = np.argmax(Q[nextstate[0],nextstate[1],:])
        maxnextaction = maxnextaction + 1
        Q[state[0]][state[1]][maxaction-1] = Q[state[0]][state[1]][maxaction-1] + alpha*(R[nextstate[0]][nextstate[1]] + gamma*(maxnextactionq) - Q[state[0]][state[1]][maxaction-1])
        if state[0]==goal[0] and state[1]==goal[1]:
            flag = 1
            actions[0][i] = k
            iterations[0][i] = i
            break
        state = np.copy(nextstate)
        k = k+1
    if flag == 0:
        actions[0][i] = K
        iterations[0][i] = i

k=1
state = np.array([0,0])
while k<1000:
    maxactionq = np.amax(Q[state[0],state[1],:])
    maxaction = np.argmax(Q[state[0],state[1],:])
    maxaction = maxaction + 1
    print "\nCurrent State = ", state[0], " ", state[1], "\nAction taken: ", maxaction, "\nQ-value:", maxactionq
    nextstate = nextState(state,maxaction,gridsize)
    if state[0]==goal[0] and state[1]==goal[1]:
        break
    state = np.copy(nextstate)
    k=k+1

plt.plot(iterations[0,:], actions[0,:])
plt.show()
