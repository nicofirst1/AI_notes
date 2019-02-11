from Problems import Slot_machines, Wolf_sheep_cabbage, Device_palcement, Grid_world, Three_digits
from informed_search import A_star_state_check, IDA, best_first
from uninformed_search import breadth_first, depth_first, uniform_cost
from utils import path2goal, prettyprint, prettyprint_local


# choose a probelm from the Problems file
problem=Three_digits()

# chose a search alghoritm 
ret_astar=A_star_state_check(problem)
ret_ida=IDA(problem)
ret_best_first=best_first(problem)

ret_breadth_first=breadth_first(problem)
ret_depth_first=depth_first(problem)
ret_uniform_cost=uniform_cost(problem)


# if to plot the graph
graph=True

# print results
print("A START WITH STATE CHECK")
prettyprint(ret_astar,"A star",graph)

print("\n\nIDA")
prettyprint(ret_ida,"IDA",graph)

print("\n\nbest_first")
prettyprint(ret_best_first,"Best first",graph)


print("\n\nBREADTH FIRST")
prettyprint(ret_breadth_first,"Breadth First",graph)

print("\n\nDEPTH FIRST")
prettyprint(ret_depth_first,"Depth First",graph)




print("\n\nuniform_cost")
prettyprint(ret_uniform_cost,"Uniform cost",graph)




