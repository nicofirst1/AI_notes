/*1. build the search tree for:
?- member(c,[a,c,b]).
?- plus1(Y,X,s(s(s(s(s(0))))))
?- reverse([a,b,c],X).

2.Write the PROLOG programs for 
- times
- power
- factorial
- minimum 
using the definitions given for natural numbers.

3. Write the PROLOG programs 
- suffix
- subset
- intersection
using lists to represent sets.

4. Write a PROLOG program for a depth-first visit of possibly cyclic graphs, represented through the relation arc(X,Y)
5. Write a PROLOG program implementing insertion sort on lists.*/


%---------------------------------------------
%EX 1
%---------------------------------------------

% If the elemnt is equal to the on in the head of the list then we found it!
member(Elem,[Elem|_]).
% else discard the head and go on with the search
member(Elem,[_|Lst]) :- member(Elem,Lst).

%---------------------------------------------
% plus1(Y,X,s(s(s(s(s(0)))))) wft?
%---------------------------------------------

% firs call the accumlator version of the function passing the empty list
reverse(Lst,Res) :- reverseAcc(Lst, [], Res).
% if the iteration list is empty then our job is done and we can set the value
% of Res equal to Acc
reverseAcc([], Acc, Acc).
% Take the head out of Lst, and append it to Acc, for example:
% Acc=[4,3,2], H=5 -> [H|Acc]=[5,4,3,2]
reverseAcc([H|Lst], Acc, Res):- reverseAcc(Lst,[H|Acc],Res).

%---------------------------------------------
%EX 2
%---------------------------------------------

natural_number(0).
natural_number(s(X)) :- natural_number(X).


% first save the value of Y into Y2 of the accumulator function.
% moreover reduce Y by one (this is done with 's(Y)' in the conclusion) in order
% to exclude the value 0 from the count
times(X,s(Y),Z) :- timesAcc(X,Y,Z,Y).

% if X is zero then we want to return Z as a natural number, notice that we
% do not care about the vale of Y
timesAcc(0,_,Z,_):- natural_number(Z).
% if Y is zero then we have to decrease X by 1 ('s(X)') and decrease Z 's(Z)'.
% notice that while X is decreasing we're actually increasing the number of successors 
% of Z, since, in the end, we want to know how many successors Z is made out of
timesAcc(s(X),0,s(Z),Y2):- timesAcc(X,Y2,Z,Y2).
% If Y is not 0 then decrease Y and Z.
timesAcc(X,s(Y),s(Z),Y2):- timesAcc(X,Y,Z,Y2).

%---------------------------------------------


% if Num2 has reached 0 then it is the lowest
min(_,0,Res) :- natural_number(Res).
% else if Num1 has reached 0 then it is the lowest
min(0,_,Res) :- natural_number(Res).
% else decrease both and increase Res.
min(s(Num1), s(Num2), s(Res)) :- min(Num1,Num2,Res). 

%---------------------------------------------
%EX 3
%---------------------------------------------

suffix(Lst1,Lst2) :- append(_,Lst1,Lst2).
prefix(Lst1,Lst2) :- append(Lst1,_,Lst2).


%---------------------------------------------
% since we're iterating on 'Lst2' we need to check when it is empty and then stop.
inter(_,[],_).

% We get the first element of Lst2 and check if it a member of Lst1.
% if yes append it to the Res and continue with another iteration
inter(Lst1,[H|Lst2],Res) :- 
                        member(H,Lst1),
                        append([H],Res,NewRes),
                        inter(Lst1,Lst2,NewRes).
% if no discard it and continue.
inter(Lst1,[_|Lst2],Res) :- inter(Lst1,Lst2,Res).
