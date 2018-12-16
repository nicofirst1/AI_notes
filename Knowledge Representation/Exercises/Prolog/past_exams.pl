
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