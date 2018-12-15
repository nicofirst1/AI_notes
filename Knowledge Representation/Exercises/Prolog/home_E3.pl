/*
1. Write a PROLOG program counting the elements of a list of lists.

2. Write a PROLOG program which implements member for a binary tree.

3. Write a PROLOG program which returns a list containing
all the nodes at a given depth D of a binary tree.

4. Consider the PROLOG terms representing the binary trees 
whose nodes are labelled by a constant symbol and, in addition,
store the depth of the node. Write a PROLOG program that 
returns true if its argument is a binary tree as above specified.

5. Write a PROLOG program that, given in input a binary tree
and a constant, returns the depth of a node containing the
given constant.

6. Write a PROLOG program that, given in input a binary 
tree without the depth information on the nodes and a constant, 
returns the depth of a node containing the given constant.

7. Write a PROLOG program that, given in input a binary tree 
without the depth information on the nodes, returns an isomorphic 
binary tree with the depth information stored in the nodes.
*/


%---------------------------------------------
%EX 1
%---------------------------------------------

% First we need a sub module function which counts the lenght of a list
% if the list is empty then return the value in Acc
sub_count([],Acc,Acc).
% else discard the head of the list '[_|Lst]' and add 1 to the Accumulator Value
sub_count([_| Lst],Lenght,Acc):- 
                NewAcc is Acc +1,
                sub_count(Lst,Lenght,NewAcc).

% this version calls the accumulator implementation passing zero as initial value
count_elem(Lst,Lenght):- count_elem_acc(Lst,Lenght,0).
% if the list is empty then we reached the end, return the accumulator value
count_elem_acc([],Acc,Acc).
% else count the element in the sublst H, add them to the accumulator value
% and pass the information to the next call
count_elem_acc([H|Lst],Lenght,Acc):- 
                sub_count(H,SubL,0),
                NewAcc is Acc + SubL,
                count_elem_acc(Lst,Lenght,NewAcc).


%==================
% Binary Trees
%==================

% Some tree examples:
% tree(a,tree(b,tree(d,nil,nil),tree(e,nil,nil)),tree(c,nil,tree(f,tree(g,nil,nil),nil))).
% tree(a,nil,nil).
% nil.

%---------------------------------------------

%Write a predicate istree/1 which succeeds if and only if its argument
% is a Prolog term representing a binary tree.

%since every tree must have some leafs that end with nil we are checking for their presence
% moreover we are using 'istree(Left), istree(Right).' in the same function since we want both 
% of them to be true at the same time
istree(nil).
istree(tree(_,Left,Right)):- istree(Left), istree(Right).

%---------------------------------------------

%2. Write a PROLOG program which implements member for a binary tree.

% if the element of the tree is equal to M return True
member(M,tree(M,_,_)).
% else look for the member in the left part
member(M,tree(_,L,_)):- member(M,L).
% else look for the member in the right part
member(M,tree(_,_,R)):- member(M,R).

%---------------------------------------------

%3. Write a PROLOG program which returns a list containing
% all the nodes at a given depth D of a binary tree.

% first we write the implemnetation which calls the accumulator version
% in this case the accumulator will be an indicator of the current depth.
depth_check(D,Tree,Res):- depth_check_sub(D,Tree,Res,1).


% if the current depth is equal to the chosen one, set Res to a list containing
% element
depth_check_sub(D,tree(Elem,_,_),[Elem],D).
 
%The above function can also be implemented as follows:

/*
depth_check_sub(D,tree(Elem,_,_),Res,CurrentD):- 
                CurrentD==D,
                append([],[Elem],Res).
*/

% if we haven't reached the desired depth D
depth_check_sub(D,tree(_,L,R),Res,CurrentD):- 
                CurrentD \== D, % you can omit this (since the previous call has failed)
                NewCurrentD is CurrentD+1, % increase the depth
                depth_check_sub(D,L,ResL,NewCurrentD), % call the function for the left part
                depth_check_sub(D,R,ResR,NewCurrentD),% call the function for the right part
                append(ResL,ResR,Res). % append results from left and right



                
%---------------------------------------------


%Write a predicate cbal_tree/2 to construct completely balanced binary
%trees for a given number of nodes. The predicate should generate all
%solutions via backtracking. 

cbal_tree(N,Tree):- cbal_tree_acc(N,Tree,tree(0,_,_)).

%cbal_tree_acc(N,Tree,Acc). 

