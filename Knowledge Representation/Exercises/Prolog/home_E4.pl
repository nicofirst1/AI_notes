/*
1. Define in PROLOG the relation onlychild(X), exploiting the family defined before.

2. Define the predicate notMember(X,L), true if X does not occur in the list L.
Provide a definition using NAF and one without it, and compare them.

3. Define union using the negation of member. Build the search tree for the goal
? union([a,b],[b,c],Z).

4. Apply the cut operator to the program insert of assign- ment 2, and draw
the search tree for the goal insert(4, [3,5,7], X).

5. Define a predicate sortm(X,Y,Z), to order lists X and Y and return 
the result in Z, through merge-sort.

6. Add cuts to the program sortm if needed to obtain a single solution.
*/


%---------------------------------------------
%EX 1
%---------------------------------------------

% Family functions

descendant(X,Y):- son(X,Y).
descendant(X,Y) :- son(Z,Y),descendant(X,Z).
parent(X,Y) :- son(Y,X).
brother(X,Y) :- son(X,Z),son(Y,Z), X\==Y.
cousin(X,Y) :- son(X,Z),son(Y,P),brother(Z,P).


% My famili KB

son(nicolo,anna).
son(nicolo,enrico).
son(giulio,anna).
son(giulio,enrico).
son(pitta,anna).
son(pitta,enrico).

son(sole,elena).
son(sole,giudoZ).
son(ale,elena).
son(ale,giudoZ).


son(riki,gisella).
son(riki,valerio).
%son(fla,gisella). 
%son(fla,valerio).

son(anna,giudo).
son(anna,giuliana).
son(elena,giudo).
son(elena,giuliana).
son(gisella,giudo).
son(gisella,giuliana).

% function declaration:

% only child is simply not having brothers.
only_child(X) :- not(brother(X,_)).


%---------------------------------------------
%EX 2
%---------------------------------------------

% implement finding an element in a list
member([Elem| _], Elem).
member([_| Lst], Elem):-  member(Lst,Elem).

% nas stands for negation as failure, it can be used with \+ too
nas(Goal) :- Goal, !, fail. % if the goal is true, then fail
nas(_). % else return true

% netation as failure with the usage of the member predicate
nas_member(Lst,Elem):-  nas(member(Lst,Elem)).
%nas_member(Lst,Elem):- \+ member(Lst,Elem).

% implementation from scratch of not_member
not_memebr([],_).
not_memebr([H|Lst],Elem):- 
                H \= Elem,
                not_memebr(Lst,Elem).


/*
To understand the difference between nas_member and not_member let's look at an example:

Having the list Lst=[1,2,3,4,5,6] and the element 4 we query the KB.
nas_member(Lst,4) will have the following execution tree:
- is 1 = 4 ? No
- is 2 = 4 ? No
- is 3 = 4 ? No
- is 4 = 4 ? Yes
- Goal will then be true, thus a faiulure will occur.

On the other hand not_member(Lst,4) is:
- is 1 = 4 ? No
- is 2 = 4 ? No
- is 3 = 4 ? No
- is 5 = 4 ? No
- is 6 = 4 ? No
Notice that there are two more steps before the ending of the algoritmh.
*/


%---------------------------------------------
%EX 3
%---------------------------------------------

% Function declaration
% union(Lst1,Lst2, Res)

