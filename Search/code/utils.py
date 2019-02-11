import random
import networkx as nx
import matplotlib.pyplot as plt

def path2goal(paths,goal_s):
    """
    Returns the path from the initial state to the goal
    :param paths: the dictionary of paths
    :param goal_s: the goal state
    :return:
    """

    res_path=[]
    current=goal_s

    while current is not None:

        res_path.append(current)
        current=paths[current]

    res_path.reverse()
    return res_path


def prettyprint(params,name,graph=True):
    came_from, cost_so_far, heuristic_cost, expansion_order, goal=params

    if graph:
        plt.title(name)
        plt.plot([], [], ' ', label= f"Total cost to goal: {cost_so_far[goal]}")
        plt.plot([], [], ' ', label= f"Number of expanded nodes: {len(expansion_order)}")

        legend = plt.legend(loc='lower right', shadow=True, fontsize='x-large',prop={'size': 6})

        G = nx.Graph([(k,v) for k,v in came_from.items() if k in expansion_order])
        G.graph['graph']={'label':name,'labelloc':'t'}
        nx.draw_spring(G, node_size=300, with_labels=True)
        plt.show()

    if goal is None or goal is "":
        to_print="No goal Found\n"

    else:
        to_print="Path to goal: \n"

        for elem in path2goal(came_from,goal):
            to_print+=f"{elem} -> "
        to_print=to_print[:-3]
        to_print+=f"\nWith total cost of {cost_so_far[goal]}\n\n"


    to_print+="The expansion order is:\n"

    for idx in range(len(expansion_order)):

        if len(heuristic_cost)==0:
            to_print+=f"{idx}) {expansion_order[idx]} (with total cost of {cost_so_far[expansion_order[idx]]})\n"
        else:
            to_print+=f"{idx}) {expansion_order[idx]} (with total cost of {heuristic_cost[expansion_order[idx]]})\n"



    print(to_print)

def prettyprint_local(params):
    goal, expansion_order, came_from = params

    to_print = "Path to goal: \n"
    goals=path2goal(came_from, goal)
    for elem in goals:
        to_print += f"{elem} -> "
    to_print = to_print[:-3]
    to_print += f"\nWith total cost of {len(expansion_order)}\n\n"

    to_print += "The expansion order is:\n"

    for idx in range(len(expansion_order)):

        to_print += f"{idx}) {expansion_order[idx]}\n"

    print(to_print)


def get_problem_variable(problem,local=False):
    """
    Returns the problem variables
    :param problem: a class Problem
    :param local: if to return the local search heuristic
    :return:
    """
    start = problem.initial_state
    goal_condition = problem.goal_condition
    operators = problem.operator_list
    heuristic = problem.heuristic
    state_space_len = problem.state_space_len
    state_condition=problem.state_condition

    #shuffle operators to get different results
    random.shuffle(operators)

    if local:
        heuristic=problem.heuristic_local

    return start,goal_condition,operators,heuristic,state_space_len,state_condition