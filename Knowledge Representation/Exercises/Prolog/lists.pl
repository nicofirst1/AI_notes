% checks if two lists have the same lenght and if the first one 
% is made up of 'a', the second one is mede up of 'b's

%tou always need something like the following predicate when working with lists
% it says that if two lists are both empty, then return true.
a2b([],[]).

% [a|Ta] is checking if the head (first element) of the first argument is equal to the
% 'a' character, same for [b|Tb]. The tail is then saved in Ta,Tb and passed again to 
% the function recursevely. The program will end when both are epmpty lists.
a2b([a|Ta],[b|Tb]) :- a2b(Ta,Tb).


%----------------------------------------------------------

% checks if X is the second element of a list by taking the second element from the list
% S and verifying that it is equal to X
second(X,Lst) :- [_,S|_]=Lst, S=X.

% it can be written in a more compact way 
second(X,[_,X|_]).

%----------------------------------------------------------

% Predicate which checks whether List1 is identical to List2 ,
% except that the first two elements are exchanged.
swap12(List1,List2) :- [F1,S1|Lst1]=List1, [F2,S2|Lst2]=List2, F1=S2, S1=F2, Lst1=Lst2.

% you can use a more compact notation if you remmeber that the same varaible can hold
% only same values, so you can use it as an equivalence:
swap12(List1,List2) :- [F,S|Lst]=List1, [S,F|Lst]=List2.
% in this case you have that F must be the same for the first element of List1 and 
% the second of List2. While the tail is the same for both.

%An even more compact way would be:
swap12([F,S|Lst],[S,F|Lst]).

%----------------------------------------------------------

%Suppose we are given a knowledge base with the following facts:
tran(uno,one).
tran(due,two).
tran(tre,three).
tran(quattro,four).
tran(cinque,five).
tran(sei,six).
tran(sette,seven).
tran(otto,eight).
tran(nove,nine).

%Write a predicate listtran(G,E) which translates a list of Italian
%number words to the corresponding list of English number words.
listtran([],[]). %return true if both are empty lists 
listtran([L1|Lst1],[L2|Lst2]) :- tran(L1,L2), listtran(Lst1,Lst2).

%----------------------------------------------------------

%Write a predicate twice(In,Out) whose left argument is a list, 
%and whose right argument is a list consisting of every element 
% in the left list written twice.

twice([],[]).
twice([I|In],[O1,O2|Out]) :- I=O1,I=O2, twice(In,Out).

% the second implementation gets the first element of In and the first two elements of Out.
%It checks whenever they are the same and repeat.


%----------------------------------------------------------


foo(_ ,[],[]).
foo(I,[I | P],R) :- foo(I,P,R). 
foo(I,[H | T],[H | R]) :- foo(I,T,R).

