import sys
from queue import PriorityQueue, LifoQueue

from utils import get_problem_variable


def A_star_state_check(problem):
    ret = get_problem_variable(problem)
    start, goal_condition, operators, heuristic, state_space_len, state_condition = ret

    frontier = PriorityQueue()
    came_from = {}
    cost_so_far = {}
    heuristic_cost = {}
    goals = []
    expansion_order = []

    frontier.put((0, start))
    came_from[start] = None
    cost_so_far[start] = 0
    heuristic_cost[start] = cost_so_far[start] + heuristic(start)

    while not frontier.empty():
        c = frontier.get()
        current = c[1]
        expansion_order.append(current)

        if goal_condition(current):

            if len(goals) == 0:
                goals.append(current)

            else:
                to_break = False

                for g in goals:
                    if cost_so_far[current] >= cost_so_far[g]:
                        to_break = True

                goals.append(current)

                if to_break:
                    break

        for op in operators:
            next = op(current)

            if not state_condition(next):
                continue

            if next in came_from.keys():
                next_cost = cost_so_far[current] + 1 + heuristic(next)
                if next_cost >= heuristic_cost[next]:
                    continue

            came_from[next] = current
            cost_so_far[next] = cost_so_far[current] + 1
            heuristic_cost[next] = cost_so_far[next] + heuristic(next)

            frontier.put((heuristic_cost[next], next))

    goal = None
    g_score = sys.maxsize
    for g in goals:
        if cost_so_far[g] < g_score:
            goal = g
            g_score = cost_so_far[g]

    return came_from, cost_so_far, heuristic_cost, expansion_order, goal


def A_star_no_state_check(problem):

    ret = get_problem_variable(problem)
    start, goal_condition, operators, heuristic, state_space_len, state_condition = ret


    frontier = PriorityQueue()
    came_from = {}
    cost_so_far = {}
    heuristic_cost = {}
    goals = []
    expansion_order = []

    frontier.put((0, start))
    came_from[start] = None
    cost_so_far[start] = 0
    heuristic_cost[start] = cost_so_far[start] + heuristic(start)

    while not frontier.empty():
        c = frontier.get()
        current = c[1]
        expansion_order.append(current)

        if goal_condition(current):

            if len(goals) == 0:
                goals.append(current)

            else:
                to_break = False

                for g in goals:
                    if cost_so_far[current] >= cost_so_far[g]:
                        to_break = True

                goals.append(current)

                if to_break:
                    break

        for op in operators:
            next = op(current)

            came_from[next] = current
            cost_so_far[next] = cost_so_far[current] + 1
            heuristic_cost[next] = cost_so_far[next] + heuristic(next)

            frontier.put((heuristic_cost[next], next))

    goal = None
    g_score = sys.maxsize
    for g in goals:
        if cost_so_far[g] < g_score:
            goal = g
            g_score = cost_so_far[g]

    return came_from, cost_so_far, heuristic_cost, expansion_order, goal


# probably incorrect
def IDA(problem):

    ret = get_problem_variable(problem)
    start, goal_condition, operators, heuristic, state_space_len, state_condition = ret



    frontier = LifoQueue()
    came_from = {}
    cost_so_far = {}
    heuristic_cost = {}
    goals = []
    expansion_order = []

    frontier.put((0, start))
    came_from[start] = None
    cost_so_far[start] = 0
    heuristic_cost[start] = cost_so_far[start] + heuristic(start)

    while not frontier.empty():

        c = frontier.get()
        current = c[1]
        expansion_order.append(current)

        if goal_condition(current):

            if len(goals) == 0:
                goals.append(current)

            else:
                to_break = False

                for g in goals:
                    if cost_so_far[current] >= cost_so_far[g]:
                        to_break = True

                goals.append(current)

                if to_break:
                    break

        for op in operators:
            next = op(current)

            if not state_condition(next):continue

            if next in came_from.keys():
                next_cost = cost_so_far[current] + 1 + heuristic(next)
                if next_cost >= heuristic_cost[next]:
                    continue

            came_from[next] = current
            cost_so_far[next] = cost_so_far[current] + 1
            heuristic_cost[next] = cost_so_far[next] + heuristic(next)

            if len(frontier.queue) == 0 or \
                    heuristic_cost[next] == min(min([elem[0] for elem in frontier.queue]), heuristic_cost[next]):
                frontier.put((heuristic_cost[next], next))

    goal = None
    g_score = sys.maxsize
    for g in goals:
        if cost_so_far[g] < g_score:
            goal = g
            g_score = cost_so_far[g]

    return came_from, cost_so_far, heuristic_cost, expansion_order, goal


def best_first(problem):
    ret = get_problem_variable(problem)
    start, goal_condition, operators, heuristic, state_space_len, state_condition = ret


    frontier = PriorityQueue()
    came_from = {}
    cost_so_far = {}
    heuristic_cost = {}
    goals = []
    expansion_order = []

    frontier.put((0, start))
    came_from[start] = None
    cost_so_far[start] = 0
    heuristic_cost[start] = heuristic(start)

    while not frontier.empty():
        c = frontier.get()
        current = c[1]
        expansion_order.append(current)

        if goal_condition(current):

            if len(goals) == 0:
                goals.append(current)

            else:
                to_break = False

                for g in goals:
                    if cost_so_far[current] >= cost_so_far[g]:
                        to_break = True

                goals.append(current)

                if to_break:
                    break

        for op in operators:
            next = op(current)

            if not state_condition(next):continue

            if next in came_from.keys():
                next_cost = cost_so_far[current] + 1 + heuristic(next)
                if next_cost >= heuristic_cost[next]:
                    continue

            came_from[next] = current
            heuristic_cost[next] = heuristic(next)
            cost_so_far[next] =cost_so_far[current]+1

            frontier.put((heuristic_cost[next], next))

    goal = None
    g_score = sys.maxsize
    for g in goals:
        if cost_so_far[g] < g_score:
            goal = g
            g_score = cost_so_far[g]

    return came_from, cost_so_far, heuristic_cost, expansion_order, goal
