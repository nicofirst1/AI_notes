% Assume you have a graph encoded as a list of edges in your knowledge base.
% Each edge is a directed connection between two nodes identified by an integer number.


edge(0, 1). edge(0, 2). 
edge(1, 3). edge(2, 3). 
edge(3, 4). edge(3, 5). 
edge(4, 6). edge(5, 7). 
edge(6, 8). edge(7, 8).

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
                               