%Define a 2-place predicate increment that holds only when its second
% argument is an integer one larger than its first argument.
% For example, increment(4,5) should hold, but increment(4,6) should not.

increment(X,Y) :- X+1 =:= Y.

%----------------------------------------------------------


% Define a 3-place predicate sum that holds only when its third argument
% is the sum of the first two arguments. 
% For example, sum(4,5,9) should hold, but sum(4,6,12) should not.

sum(X,Y,Z) :- X+Y=:=Z.

%----------------------------------------------------------

% Write a predicate addone/2 whose first argument is a list of integers,
% and whose second argument is the list of integers obtained
%  by adding 1 to each integer in the first list. 

addone([],[]).
addone([Ht|T], [Hr|R]) :-  Hr is Ht +1, addone(T,R).

% The first implementation is due to return true when both lists are empty.
% the second one force Ht+1 to be computed and assign its value to Hr through 'is'.
% it then call addone again with the tail of the two lists.

%----------------------------------------------------------

% Implement a 2-place, min(Lst, Min), predicate accMin which returns the minimum of a list of integers.
% to better understand the function of an accumulator check this:
% http://lpn.swi-prolog.org/lpnpage.php?pagetype=html&pageid=lpn-htmlse20

% The first implementation of min is used to call the accMin instantiating Acc to the 
% first element of the list E
min([E|Lst],Min) :- accMin(Lst,E,Min).

% then we add the check for the end of list Lst and we assign the value Acc to Min.
accMin([],Acc,Acc).

% If the list is not empty, then check if the first element is less than the current minimum 
% whic is Acc, if so call accMin again passing E as the minimum
accMin([E|Lst], Acc, Min) :- E < Acc, accMin(Lst,E,Min).

% if E is not less than Acc then discard E and pass Acc as the minimum
accMin([E|Lst], Acc, Min) :- E >= Acc, accMin(Lst,Acc,Min).


%----------------------------------------------------------

%Write a 3-place predicate scalarMult whose first argument is an integer,
% whose second argument is a list of integers, and whose third argument is
% the result of scalar multiplying the second argument by the first



scalarMult(_,[], []).
scalarMult(Int,[L|Lst], [R| Res]) :-  R is L * Int, scalarMult(Int, Lst, Res).

%----------------------------------------------------------


%Write a 3-place predicate dot whose first argument is a list of integers,
% whose second argument is a list of integers of the same length as the first,
% and whose third argument is the dot product of the first argument with the second

dotAcc([],[],Acc,Acc).
dotAcc([L1|Lst1],[L2|Lst2],Acc,Res) :- NewAcc is Acc + L1*L2, dotAcc(Lst1,Lst2,NewAcc,Res).
dot(Lst1,Lst2,Res) :- dotAcc(Lst1,Lst2,0,Res).

% Notice that I used a new varaible 'NewAcc' for the sum instead of 'Acc is Acc + L1*L2'
% this is because  in logic programming a variable can only grounded once, so doing something
% like 'Acc=2' 'Acc is Acc +1' will result in '2 is 3' which is false.
