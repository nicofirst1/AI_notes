import random

import numpy as np





class Slot_machines:

    def __init__(self):

        self.initial_state = "0,1,2"

        self.operator_list = [self.operator0, self.operator1, self.operator2]
        self.state_space_len = 5 ^ 3



    def goal_condition(self,state):

        state=state.split(",")
        return state[0]==state[1]==state[2]


    def heuristic(self,state):

        heuristic=2


        if self.goal_condition(state):
            return 0

        state=state.split(",")

        if state[0]==state[1] or state[1]==state[2]:
            heuristic-=1


        return heuristic


    def heuristic_local(self,state):

        heuristic=0


        if self.goal_condition(state):
            return 2

        state=state.split(",")

        if state[0]==state[1] or state[1]==state[2]:
            heuristic=1


        return heuristic


    def state_condition(self,sate):
        return True

    def operator0(self,state):

        state=state.split(",")

        digit=(int(state[0])+3)%5

        state[0]=str(digit)

        return ",".join(state)


    def operator1(self,state):
        state = state.split(",")

        digit = (int(state[1]) + 3) % 5

        state[1] = str(digit)

        return ",".join(state)


    def operator2(self,state):
        state = state.split(",")

        digit = (int(state[2]) + 3) % 5

        state[2] = str(digit)

        return ",".join(state)


class Three_digits:

    def __init__(self):

        #cells 00,01,10,11
        #values 0=empty, 1=A, 2=B
        self.initial_state = "0,1,2"

        self.goal=[2,1,0]

        self.operator_list = [self.push_button(idx) for idx in range(3)]
        self.state_space_len = 3^3


    def convert_state(self,state):

        if isinstance(state,str):
            return [int(elem) for elem in state.split(",")]

        elif isinstance(state,list):
            return ",".join([str(elem) for elem in state])

        else:
            raise Exception("No recognized instance")

    def goal_condition(self,state):

        goal=[2,1,0]
        state=self.convert_state(state)


        # no state is zero
        return state==goal


    def heuristic(self,state):

        state=self.convert_state(state)

        heuristic=sum(abs(g-c) for g,c in zip(self.goal,state))


        return heuristic

    def state_condition(self,state):




        return True



    def heuristic_local(self,state):

        state=self.convert_state(state)


        # number of zeroes
        state = np.asarray(state)
        ones = np.where(state != 0)[0]

        return len(ones)



    def push_button(self,index):

        def push_sub(state):
            state = self.convert_state(state)
            other=list(state)
            other.pop(index)
            new_val=sum(other)%3
            state[index]=new_val

            state=self.convert_state(state)
            return state

        return push_sub



class Wolf_sheep_cabbage:

    def __init__(self):

        #man,wolf, sheep, cabbage
        self.initial_state = "0,0,0,0"

        self.operator_list = [self.carryMan, self.carryWolf, self.carrySheep,self.carryCabbage]
        self.state_space_len = 2 ^ 4



    def goal_condition(self,state):

        state=state.split(",")
        return state[0]==state[1]==state[2]==state[3]=="1"


    def heuristic(self,state):

        heuristic=4


        if self.goal_condition(state):
            return 0



        state=state.split(",")

        if state[0]:
            heuristic-=1

        if state[1]:
            heuristic-=1

        if state[2]:
            heuristic-=1

        if state[3]:
            heuristic-=1


        return heuristic

    def state_condition(self,state):

        state=[int(elem) for elem in state.split(",")]
        state=np.asarray(state)

        #man is on right side of shore
        if state[0]:

            shore=np.where(state==0)[0]
            if 1 in shore and 2 in shore:return False
            if 2 in shore and 3 in shore: return False

        else:
            shore = np.where(state == 1)[0]
            if 1 in shore and 2 in shore: return False
            if 2 in shore and 3 in shore: return False


        return True







    def heuristic_local(self,state):

        heuristic = 0

        if self.goal_condition(state):
            return 4

        state = state.split(",")

        if state[0]:
            heuristic += 1

        if state[1]:
            heuristic += 1

        if state[2]:
            heuristic += 1

        if state[3]:
            heuristic += 1

        return heuristic



    def carryMan(self,state):

        state=state.split(",")

        digit=0 if int(state[0]) else 1



        state[0]=str(digit)

        return ",".join(state)


    def carryWolf(self,state):


        state=self.carryMan(state)

        state=state.split(",")

        digit=0 if int(state[1]) else 1



        state[1]=str(digit)

        return ",".join(state)

    def carrySheep(self, state):

        state = self.carryMan(state)

        state = state.split(",")

        digit = 0 if int(state[2]) else 1

        state[2] = str(digit)

        return ",".join(state)

    def carryCabbage(self, state):

        state = self.carryMan(state)

        state = state.split(",")

        digit = 0 if int(state[3]) else 1

        state[3] = str(digit)

        return ",".join(state)



class Device_palcement:

    def __init__(self):

        #cells 00,01,10,11
        #values 0=empty, 1=A, 2=B
        self.initial_state = "0,0,0,0"

        self.operator_list = [self.putA(idx) for idx in range(4)]+ [self.putB(idx) for idx in range(4)]
        self.state_space_len = 3^4


    def convert_state(self,state):

        if isinstance(state,str):
            return [int(elem) for elem in state.split(",")]

        elif isinstance(state,list):
            return ",".join([str(elem) for elem in state])

        else:
            raise Exception("No recognized instance")

    def goal_condition(self,state):

        state=self.convert_state(state)

        # no state is zero
        return all(state)


    def heuristic(self,state):

        state=self.convert_state(state)

        #number of zeroes
        state=np.asarray(state)
        zeros=np.where(state==0)[0]

        return len(zeros)

    def state_condition(self,state):

        state=self.convert_state(state)

        if state[0]==state[1]!=0 or state[0]==state[2]!=0:
            return False

        if  state[1]==state[3]!=0 or state[2]==state[3]!=0:
            return False




        return True



    def heuristic_local(self,state):

        state=self.convert_state(state)


        # number of zeroes
        state = np.asarray(state)
        ones = np.where(state != 0)[0]

        return len(ones)



    def putA(self,index):

        def putA_sub(state):
            state = self.convert_state(state)

            if state[index]!=1:
                state[index]=1

            state = self.convert_state(state)

            return state

        return putA_sub

    def putB(self, index):

        def putA_sub(state):
            state = self.convert_state(state)
            if state[index] ==0:
                state[index] = 2
            state = self.convert_state(state)

            return state

        return putA_sub


class Grid_world:

    def __init__(self):

        #cells 00,01,10,11
        #values 0=empty, 1=A, 2=B
        dim=10
        self.map = np.zeros((dim,dim))

        self.initial_state=(0,0)


        self.operator_list = [self.putA(idx) for idx in range(4)]+ [self.putB(idx) for idx in range(4)]
        self.state_space_len = 3^4


    def convert_state(self,state):

        if isinstance(state,str):
            return [int(elem) for elem in state.split(",")]

        elif isinstance(state,list):
            return ",".join([str(elem) for elem in state])

        else:
            raise Exception("No recognized instance")

    def goal_condition(self,state):

        state=self.convert_state(state)

        # no state is zero
        return all(state)


    def heuristic(self,state):

        state=self.convert_state(state)

        #number of zeroes
        state=np.asarray(state)
        zeros=np.where(state==0)[0]

        return len(zeros)

    def state_condition(self,state):

        state=self.convert_state(state)

        if state[0]==state[1]!=0 or state[0]==state[2]!=0:
            return False

        if  state[1]==state[3]!=0 or state[2]==state[3]!=0:
            return False




        return True



    def heuristic_local(self,state):

        state=self.convert_state(state)


        # number of zeroes
        state = np.asarray(state)
        ones = np.where(state != 0)[0]

        return len(ones)



    def putA(self,index):

        def putA_sub(state):
            state = self.convert_state(state)

            if state[index]!=1:
                state[index]=1

            state = self.convert_state(state)

            return state

        return putA_sub

    def putB(self, index):

        def putA_sub(state):
            state = self.convert_state(state)
            if state[index] ==0:
                state[index] = 2
            state = self.convert_state(state)

            return state

        return putA_sub

