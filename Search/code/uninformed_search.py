from queue import PriorityQueue, Queue, LifoQueue

import sys
from utils import get_problem_variable


def breadth_first(problem):

    start, goal_condition, operators, heuristic, state_space_len, state_condition=get_problem_variable(problem)

    frontier = Queue()
    came_from = {}
    cost_so_far = {}
    expansion_order=[]
    goal=""

    frontier.put(start)
    came_from[start] = None
    cost_so_far[start] = 0



    while not frontier.empty():
        current = frontier.get()
        expansion_order.append(current)


        for op in operators:
            next=op(current)

            if not state_condition(next):continue

            if next in came_from.keys():
                    continue


            came_from[next]=current
            cost_so_far[next]=cost_so_far[current]+1

            if goal_condition(next):
                goal = next

                break

            frontier.put(next)





    return came_from, cost_so_far, {},expansion_order,goal


def depth_first(problem):

    start, goal_condition, operators, heuristic, state_space_len, state_condition=get_problem_variable(problem)

    frontier = LifoQueue()
    came_from = {}
    cost_so_far = {}
    expansion_order=[]
    goal=""

    frontier.put(start)
    came_from[start] = None
    cost_so_far[start] = 0

    while not frontier.empty():
        current = frontier.get()
        expansion_order.append(current)

        if goal_condition(current):

            goal=current

            break




        for op in operators:
            next=op(current)

            if not state_condition(next):continue

            if next in came_from.keys():
                    continue


            came_from[next]=current
            cost_so_far[next]=cost_so_far[current]+1

            frontier.put(next)





    return came_from, cost_so_far, {},expansion_order,goal




def uniform_cost(problem):

    start, goal_condition, operators, heuristic, state_space_len, state_condition=get_problem_variable(problem)

    frontier = PriorityQueue()
    came_from = {}
    cost_so_far = {}
    expansion_order=[]
    goal=""

    frontier.put((0, start))
    came_from[start] = None
    cost_so_far[start] = 0

    while not frontier.empty():
        c = frontier.get()
        current = c[1]
        expansion_order.append(current)

        if goal_condition(current):

            goal=current

            break




        for op in operators:
            next=op(current)

            if not state_condition(next):continue

            if next in came_from.keys():
                    continue


            came_from[next]=current
            cost_so_far[next]=cost_so_far[current]+1

            frontier.put((cost_so_far[next], next))





    return came_from, cost_so_far, {},expansion_order,goal


