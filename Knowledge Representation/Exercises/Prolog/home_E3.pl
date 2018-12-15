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
%EX 1.1
%---------------------------------------------

%Write a predicate istree/1 which succeeds if and only if its argument
% is a Prolog term representing a binary tree.

%since every tree must have some leafs that end with nil we are checking for their presence
% moreover we are using 'istree(Left), istree(Right).' in the same function since we want both 
% of them to be true at the same time
istree(nil).
istree(tree(_,Left,Right)):- istree(Left), istree(Right).

%---------------------------------------------
%EX 2
%---------------------------------------------

%2. Write a PROLOG program which implements member for a binary tree.

% if the element of the tree is equal to M return True
member(M,tree(M,_,_)).
% else look for the member in the left part
member(M,tree(_,L,_)):- member(M,L).
% else look for the member in the right part
member(M,tree(_,_,R)):- member(M,R).

%---------------------------------------------
%EX 3
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
%EX 4
%---------------------------------------------

/*
tree(symbol,depth,leftBranch, rightBranch)

tree(a,0,tree(b,1,tree(d,2,tree(h,3,nil,nil),tree(i,3,nil,nil)),tree(e,2, tree(l,3,nil,nil),nil)),tree(c,1,tree(f,2,tree(m,3,tree(n,3,nil,nil),tree(o,3,nil,nil)), nil),tree(g,2,nil,nil)))

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

%is_depth_tree_acc(Tree(Symbol,Depth,L,R),CurrentDepth):- 


% function calls the accumulator version with a counter used for getting the correct depth
is_depth_tree(Tree):-is_depth_tree_acc(Tree,0).
% if we're at a nil lode (leaf) return true
is_depth_tree_acc(nil,_).

% else check that Depth is equal to CurrD, if yes add 1 to depth and check other branches
is_depth_tree_acc(tree(_,CurrD,L,R),CurrD):- 
                NewD is CurrD +1,
                is_depth_tree_acc(L,NewD),
                is_depth_tree_acc(R,NewD).
                

                
%---------------------------------------------
%EX 5
%---------------------------------------------
% tree(symbol,depth,leftBranch, rightBranch)

% tree(a,0,tree(b,1,tree(d,2,tree(h,3,nil,nil),tree(i,3,nil,nil)),tree(e,2, tree(l,3,nil,nil),nil)),tree(c,1,tree(f,2,tree(m,3,tree(n,3,nil,nil),tree(o,3,nil,nil)), nil),tree(g,2,nil,nil)))
% Function declarations:
%get_constant_depth_5(Const,Depth,Tree)

% id the constant is equal to the one in the node, return the current depth
get_constant_depth_5(Const,CurrDepth,tree(Const,CurrDepth,_,_)).

% else look for it both in the Left part
get_constant_depth_5(Const,Depth,tree(_,_,L,_)):-
                get_constant_depth_5(Const,Depth,L).

% and in the right part
get_constant_depth_5(Const,Depth,tree(_,_,_,R)):-
                get_constant_depth_5(Const,Depth,R).



%---------------------------------------------
%EX 6
%---------------------------------------------

% same tree as before without the information depth
% tree(symbol,leftBranch, rightBranch)
% tree(a,nil,tree(c,tree(f,nil, nil),tree(g,nil,nil)))

% Function declarations:
%get_constant_depth_6(Const,Depth,Tree)
%get_constant_depth_acc_6(Const,Depth,Tree,CurrDepth)

% call the accumulator version initializing the depht to zero
get_constant_depth_6(Const,Depth,Tree):-get_constant_depth_acc_6(Const,Depth,Tree,0).

% id the constant is equal to the one in the node, return the current depth
get_constant_depth_acc_6(Const,CurrDepth,tree(Const,_,_),CurrDepth).

% else look for it both in the Left part
get_constant_depth_acc_6(Const,Depth,tree(_,L,_),CurrDepth):-
                NewCurrDepth is CurrDepth +1,
                get_constant_depth_acc_6(Const,Depth,L,NewCurrDepth).

% and in the right part
get_constant_depth_acc_6(Const,Depth,tree(_,_,R),CurrDepth):-
                NewCurrDepth is CurrDepth +1,
                get_constant_depth_acc_6(Const,Depth,R,NewCurrDepth).


%---------------------------------------------
%EX 7
%---------------------------------------------

%tree(a,tree(b,tree(d,tree(h,nil,nil),tree(i,nil,nil)),tree(e, tree(l,nil,nil),nil)),tree(c,tree(f,tree(m,tree(n,nil,nil),tree(o,nil,nil)), nil),tree(g,nil,nil)))

% Function decalrations:
% tree_converter(OriginalTree,DepthTree).
% tree_converter_acc(OriginalTree,DepthTree,Depth).

% return true if input is nil
tree_converter(nil,nil).
% Call the accumulator version with initial depth 0
tree_converter(OriginalTree,DepthTree):- 
        tree_converter_acc(OriginalTree,DepthTree,0).

% if we reached a leaf then return nil
tree_converter_acc(nil,nil,_).
% else construct the tree addign the depth 
tree_converter_acc(tree(Symbol,L,R),tree(Symbol,Depth,LD,RD),Depth):-
        NewDepth is Depth+1, % increase the depth
        tree_converter_acc(L,LD,NewDepth), % generate the left branch with the new depth
        tree_converter_acc(R,RD,NewDepth). % generate the left branch with the new depth
        




