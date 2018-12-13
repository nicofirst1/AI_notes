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
% Append and stuff
%----------------------------------------------------------

% Let’s call a list doubled if it is made of two consecutive blocks
% of elements that are exactly the same. For example, [a,b,c,a,b,c] is
% doubled (it’s made up of [a,b,c] followed by [a,b,c] ) and so is 
%[foo,gubble,foo,gubble] . On the other hand, [foo,gubble,foo] is not doubled.
% Write a predicate doubled(List) which succeeds when List is a doubled list.

% first write a predicate which calls the accumulator version
doubled(List) :- doubleAcc(List, []).
% if the two lists are identical then return true
doubleAcc(L,L).
% get the first element of List and append it to Acc, resulting in Acc=[Acc,H]
% then call doubleAcc again.
doubleAcc([H|List],Acc) :- append(Acc,[H],X), doubleAcc(List,X).

%----------------------------------------------------------
% A palindrome is a word or phrase that spells the same forwards and backwards.
% For example, ‘rotator’, ‘eve’, and ‘nurses run’ are all palindromes.
% Write a predicate palindrome(List) , which checks whether List is a palindrome

% predicate which calls the accumalator version, passing both an empty list as the
% accumulator and a original version of the list which will not be modified
palindrome(Lst) :- palindromeAcc(Lst, [], Lst).
% If the iterative list is empty then we checked it all and we want to know if the accumulator
% and the original list are the same
palindromeAcc([],L,L).
% take the head of the list and append it in reverse to the accumulator ([H|Acc]), 
% pass the list withouth the first element and the original one to the next call.
palindromeAcc([H|Lst], Acc, Original) :- palindromeAcc(Lst,[H|Acc],Original).

%----------------------------------------------------------
% Write a predicate toptail(InList,OutList) which says no if InList is a
% list containing fewer than 2 elements, and which deletes the first and
% the last elements of InList and returns the result as OutList , 
%when InList is a list containing at least 2 elements.

% if the list contains one element then '[_,_|InList]' returns false.
% if the list contains two elements then 'OutList=[]' returns [].
toptail([_,_|InList], OutList) :- InList=[], OutList=[].
% if the list contains more than two elements then we discard the first '_'
% and we call the Accumulator version giving the second as first element of the new list.
toptail([_,S|InList], OutList) :-  toptailAcc(InList, [S], OutList).
% if the next element in the InList is the lst one '[_|[]]' (this measn the tail is the empty list)
% then the return the Accumulator value
toptailAcc([_| []], Acc, Acc).
% Else append the value taken from InList to Acc, which result will ben NewAcc
% and call the function again.
toptailAcc([H|InList], Acc, OutList):- append(Acc,[H],NewAcc),toptailAcc(InList,NewAcc,OutList).

%----------------------------------------------------------
/* There is a street with three neighbouring houses that all have a different colour,
namely red, blue, and green. People of different nationalities live in the
 different houses and they all have a different pet. Here are some more
facts about them:

The Englishman lives in the red house.
The jaguar is the pet of the Spanish family.
The Japanese lives to the right of the snail keeper.
The snail keeper lives to the left of the blue house.

Who keeps the zebra? Don’t work it out for yourself:
define a predicate zebra/1 that tells you the nationality of the owner of the zebra!*/

suffix(S,L):- append(_,S,L).
prefix(P,L):- append(P,_,L).
sublist(SubL,L):- suffix(S,L), prefix(SubL,S).


% house( color, nationality, pet)
zebra(X,Y) :- 
        member(house(red, english, _), [H0,H1,H2]),
        member(house(_, spanish, jaguar), [H0,H1,H2]),
        member(house(Y, X, zebra), [H0,H1,H2]),
        
        sublist([house(_, _, snail), house(_, japanese, _)], [H0,H1,H2]),
        sublist([house(_, _, snail), house(blue, _, _)], [H0,H1,H2]).
