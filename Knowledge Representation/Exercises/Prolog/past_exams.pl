
/*
Write a Prolog program that, given two lists L1 and L2, outputs
two new lists L3 and L4 such that L3 contains the elements of 
L1 which also belong to L2, while L4 contains the elements of L1 
which do not belong to L2. You may use the built-in predicate member.
As an example, the query listmem([a, r, t], [t, s, m, n, a], L3, L4) 
produces L3 = [a, t] and L4 = [r].
*/

% call the function which is divided into union and interception
listmem(L1,L2,L3,L4):-
    union(L1,L2,L3,[]),
    interception(L1,L2,L4,[]).



% if L1 is empty then set the result equal to the accumulator
union([],_,Res,Res).
% else if H1 is in Ls then append it to Acc
union([H1|L1],L2,Res,Acc):- 
    member(H1,L2),
    union(L1,L2,Res,[H1|Acc]).
% else continue and discard H1
union([_|L1],L2,Res,Acc):- 
    union(L1,L2,Res,Acc).

% same thing goes for the interception, except we use neagation as failure for the member
% condition
interception([],_,Res,Res).

interception([H1|L1],L2,Res,Acc):-
    \+ member(H1,L2),
    interception(L1,L2,Res,[H1|Acc]).

interception([_|L1],L2,Res,Acc):-
    interception(L1,L2,Res,Acc).


%---------------------------------------------
%---------------------------------------------
%---------------------------------------------


% try to understand what this is for...
foo(_ ,[],[]). 
foo(I,[I | P],R) :- foo(I,P,R). 
foo(I,[H | T],[H | R]) :- foo(I,T,R).


% Given foo(I,P,R).
% This predicate removes every occurrence of the element I in P 
% and checks if what is left is the same as the list R

foo(_ ,[],[]). 
% 1) Is used to return true whenever P and R are empty lists


foo(I,[I | P],R) :- foo(I,P,R). 
% 2) Is used to check if the first element of P is equal to I, if yes then 
% remove it and call foo on the tail of P, else call:

foo(I,[H | T],[H | R]) :- foo(I,T,R).
% 3) this last implementation is called when the first element of P is not equal to I.
% then it must be equal to the first element of R, if so call foo again removing
% the first element from P and R, else return false

% For example having:
% foo(1,[1,2,1,3,1,1,4,1,1],[2,3,4])
% will  first call 1) which fails, 2) removes the first one and we're left with:
% I=1, P=[2,1,3,1,1,4,1,1], R=[2,3,4]
% Now both 1) and 2) fails, and 3) removes 2 from both R and P, resulting in:
% I=1, P=[1,3,1,1,4,1,1], R=[3,4]
% 1 is removed with 2)
% I=1, P=[3,1,1,4,1,1], R=[3,4]
% 3 is removed with 3)
% I=1, P=[1,1,4,1,1], R=[4]
% 1 is removed with 2) two times
% I=1, P=[4,1,1], R=[4]
% 4 is removed with 3)
% I=1, P=[1,1], R=[]
% 1 is removed with 2) two times
% I=1, P=[], R=[]
% finally the input matches 1) and true is returned



%---------------------------------------------
%---------------------------------------------
%---------------------------------------------


/*
Write a Prolog program that given a binary tree and a list of forbidden members,
verifies that there exists a path from the root to a leaf that contains at most 
one occurrence of a forbidden number (x).
*/

% using the notation 
% tree(Symbol,LeftBranch,RightBranch)

/*
tree(1,
    tree(x,
        tree(4,
            tree(x,
                    nil,
                    tree(5,nil,nil)),
            tree(7,nil,nil)),
        tree(6,nil,nil)),
    tree(3,
        tree(2,nil,nil),
        tree(x,
            tree(8,
                tree(x,tree(9,nil,nil),nil),
                nil),
            tree(10,nil,nil))))
*/



check_symbol(Symbol,Counter):-
    Symbol == x,
    Counter is 1.

check_symbol(Symbol,Counter):-
    Symbol \== x,
    Counter is 0.

forbitten_path(Goal,Tree):- forbitten_path_acc(Goal,Tree,0).

forbitten_path_acc(Goal,tree(Goal,_,_),_).

forbitten_path_acc(Goal,tree(Symbol,L,_),ForbittenCount):-
    check_symbol(Symbol,C),
    NewForbittenCount is ForbittenCount +C,
    NewForbittenCount =<1,
    forbitten_path_acc(Goal,L,NewForbittenCount).

forbitten_path_acc(Goal,tree(Symbol,_,R),ForbittenCount):-
    check_symbol(Symbol,C),
    NewForbittenCount is ForbittenCount +C,
    NewForbittenCount =<1,
    forbitten_path_acc(Goal,R,NewForbittenCount).


%---------------------------------------------
%---------------------------------------------
%---------------------------------------------

% Assume you have a graph encoded as a list of edges in your knowledge base.
% Each edge is a directed connection between two nodes identified by an integer number.

%Uncomment to use this tree
/*
edge(0, 1). edge(0, 2). 
edge(1, 3). edge(2, 3). 
edge(3, 4). edge(3, 5). 
edge(4, 6). edge(5, 7). 
edge(6, 8). edge(7, 8).
*/

% Write a Prolog program that, given a start and a target node,
% finds a path - if it exists - such that all the nodes appear in increasing order.

% functions to revert a list
accRev([H|T],A,R):- accRev(T,[H|A],R).
accRev([],A,A).
rev(L,R):- accRev(L,[],R).


% if the start/end are edges then we can safely return a list like
% [Start,End]
path(Start,End,P):- edge(Start,End),append([],[Start,End],P).

% else we need to use the accumulator function, which returns Acc as the 
% inverted list of nodes (for example path(0,8) gives [8,6,4,3,1,0]) so we 
% need to run 'rev(Acc,P)'
path(Start,End,P):- 
                    pathAcc(Start,End,Acc,P),
                    append(Acc,[Start],NewAcc),
                    rev(NewAcc,P).

% if the Start and the End are edges then the path is found
% append the end to the accumulator and return.
pathAcc(Start, End, Acc, _) :- edge(Start,End), append([End],[],Acc).

% otherwise we need to find some node 'Mid' which is an edge of 'Start' such that:
% 'Mid' and 'End' shares some path. If 'Mid' is found then append it to the Acc
% list and return
pathAcc(Start, End, Acc, P) :- 
            edge(Start,Mid),pathAcc(Mid,End,NewAcc,P),
            append(NewAcc,[Mid],Acc).


%---------------------------------------------
%---------------------------------------------
%---------------------------------------------                             

/*
Assume to have a graph, in your Prolog knowledge base, encoded as a 
collection of edges.For example:

edge(a, b). edge(b, c). edge(c, d).

Moreover, assume that each node of the graph is associated
with a value. For example:

val(a, 1). val(b, 0). val(c, 1). val(d, 2).

Write a Prolog program which returns a path that only traverses nodes
that have binary values (0 or 1). In the example, [a, b, c] is such a path, 
while [b, c, d)] is not.
*/


/*
Using
edge(symbol1,symbol1)
val(symbol,val)


0                                 A 
                                  |
1                 B------------------------------C
                  |                              | 
2         D---------------E               G--------------F                               
          |               |                              |
3 H --------------I       L                              M
                                                         |
4                                               N-----------------O

*/




% Uncomment the following to use function
/*
edge(a,b). edge(a,c).
edge(b,d). edge(b,e). edge(c,g). edge(c,f).
edge(d,h). edge(d,i). edge(e,l). edge(f,m).
edge(m,n). edge(m,o).

val(a,0). val(h,1).
val(b,1). val(i,6).
val(c,0). val(l,1).
val(d,1). val(m,6).
val(e,2). val(n,1).
val(f,0). val(o,0).
val(g,5).
*/

% auxiliary function to check whenever a value is binary or not
check_binary_val(Val):-
    Val == 0.
check_binary_val(Val):-
    Val == 1.


% original function called by the user
% initilize the accumulator to an empty list and the start to a
traversable_path(Path):-traversable_path_acc(Path,a,[]).

% any path that has reached this step is a valid path, so return it
traversable_path_acc(Path,Current,Acc):-
    append(Acc,[Current],Path). % append current and return

% to reach other steps we need a recursive function
traversable_path_acc(Path,Current,Acc):-
        append(Acc,[Current],NewAcc), % append current to new accumualtor
        edge(Current,Mid), % check for the existance of an edge Mid
        val(Mid,Val), % get the value of Mid
        check_binary_val(Val), % check if Val is binary
        traversable_path_acc(Path,Mid,NewAcc). % if yes search for its childrens.





%---------------------------------------------
%---------------------------------------------
%---------------------------------------------                             


/*
Consider trees whose nodes are labelled with positive integers. 
Write a program that given such a tree as input, verifies that it is a 
binary search tree. A binary search tree is a tree where the value of 
each node is greater than the value of the left child and smaller or 
equal to the value of the right child. The algorithm must be able to 
handle unbalanced trees and void trees.
*/

/*
Using
edge(symbol1,symbol1)
val(symbol,val)


0                                 A [50] 
                                  |
1                 B[20]------------------------------C[70]
                   |                                  | 
2         D[10]---------------E[27]        G[63]--------------F[85]                               
            |                                                    
3 H[7] --------------I[13]                                 
                                                        

*/



% Uncomment the following to use function 

/*
edge(a,b). edge(a,c).
edge(b,d). edge(b,e). edge(c,g). edge(c,f).
edge(d,h). edge(d,i). 

val(a,50). val(h,7).
val(b,20). val(i,13).
val(c,70). val(f,85). 
val(d,10). val(g,63).
val(e,27). 

*/

% We need an auxiliary functions for checking if an element is the smaller
% af a list

smallest_element(_,[]).

smallest_element(Elem,[H|List]):-
        Elem<H,
        smallest_element(Elem,List).

% the function doesn't need any parameters since the tree is defined above
check_binary_tree():- check_binary_tree_acc(a,[]).

% if a node has no branches then return true
check_binary_tree_acc(Start,_):- 
    \+ edge(Start,_).

% else check the value of the branches
check_binary_tree_acc(Start,Traversed):- 
    val(Start,Val), % get the value of the current node
    append(Traversed,[Val],NewTraversed), % append it to the others

    % get the left and right nodes
    edge(Start,Left),
    edge(Start,Right),

    % which must be diffrent nodes
    Left \= Right,

    % get the values
    val(Left,ValL),
    val(Right,ValR),

    % check if the left one is the smallest 
    % and the right is higher than the current one
    smallest_element(ValL,NewTraversed),
    ValR>=Val,

    % continue to check for their childrens
    check_binary_tree_acc(Left,NewTraversed),
    check_binary_tree_acc(Right,Traversed).


%---------------------------------------------
%---------------------------------------------
%---------------------------------------------                             


/*
Given a binary tree, where the nodes contain integer numbers,
write a Prolog program which returns a full path (i.e., a path from 
the root to a leaf, represented as a list) such that all the 
elements in the path appear in increasing order from the root to the leaf.
*/



/*
Using
edge(symbol1,symbol1)
val(symbol,val)


0                                 A [13] 
                                  |
1                 B[11]--------------------------C[14]
                   |                              | 
2         D[4]------------E[15]        G[12]-------------F[3]                               
            |                                                    
3 H[2] -----------I[13]                                 
                                                        

*/

% Uncomment the following to use function 

edge(a,b). edge(a,c).
edge(b,d). edge(b,e). edge(c,g). edge(c,f).
edge(d,h). edge(d,i). 

val(a,13). val(h,2).
val(b,11). val(i,13).
val(c,14). val(f,3). 
val(d,4). val(g,12).
val(e,15). 



% we need an auxiliary function to chech whenever a list is sorted
sorted_lst([]). % if the list is empty return true
sorted_lst([_]). % if the list has one element return true
sorted_lst([F,S|Lst]):-
    F<S, % check if the first element is less than the secon
    sorted_lst([S|Lst]). % recall function with list withouth F

% the function doesn't need any parameters since the tree is defined above
sorted_binary_tree():- sorted_binary_tree_acc(a,[]).

% if a node has no branches then return true
sorted_binary_tree_acc(Start,_):- 
    \+ edge(Start,_).

% else check the value of the branches
sorted_binary_tree_acc(Start,Traversed):- 
    val(Start,Val), % get the value of the current node
    append([Val],Traversed,NewTraversed), % append it to the others

    % get an adjacent node
    edge(Start,Next),
    % and its value
    val(Next,ValN),
    % check if the list containing its value is ordered
    sorted_lst([ValN|NewTraversed]),

    % continue to check for their childrens
    sorted_binary_tree_acc(Next,NewTraversed).
