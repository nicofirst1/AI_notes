/*
Write a PROLOG program that given a list of lists of integers and an integer N
returns a list containing only the lists of the input structure that have less
than N elements. The check on the length of the list must be implemented.
For example, given the input [[1,2,3],[1,5],[4,6]] and N is 3 the answer
is [[1,5],[4,6]].
*/

% First we need the functions to get the lenght of a list
% this one return true as soon as i have iterated throught all the list 
len([],Acc,Acc).
% this one increases the value of Acc  for every element in the list.
len([_|Lst],Acc,Lenght) :- NewAcc is Acc +1, len(Lst,NewAcc,Lenght).

% the function to be called will be this one, which calls the accumulator version
less_than(Lst,N,Res):- less_thanAcc(Lst,N,Res,[]).
% the accumulator version ends as soon as the list we're iterating is empty, it then 
% sets the value of the accumulator to the variable Res
less_thanAcc([],_,Acc,Acc).
% This next function first calculates the lenght of the first element of the list
% then it checks if the lenght is strictly less than the natural number N
% if yes then if appends the element H (a list) to the accumulator and goes on
less_thanAcc([H|Lst],N,Res,Acc):- len(H,0,L), L<N, less_thanAcc(Lst,N,Res,[H|Acc]).
% if no it ignores the value of H (_) and does not append it to the accumulator
less_thanAcc([_|Lst],N,Res,Acc):-  less_thanAcc(Lst,N,Res,Acc).


%-------------------------------------------------------------------------------
%-------------------------------------------------------------------------------

/*
Write a PROLOG program that given a list of lists of integers and an integer N,
and returns a list containing only the lists of the input structure,
whose elements are all greater than N. For example, given the input
[[1,2,3],[1,5,2],[4,6,8]] N=2, the answer is [[4,6,8]].
*/

% firs we need a function which checks if all the elements of a given list are grather than N
% this implementation is used as a stop when we reach the end of the list
check_grather([],_).
% Then we just perform an iteration, taking the first element of the list H and 
% comparing it to N, if it is grather then iterate over the next element
% else return false (there is no other implementation that can return True)
check_grather([H| Lst],N):-  H>N, check_grather(Lst,N).

%First implement the function which will be called bu the user and which will call the accumulator version
only_grather(Lst,N,Res):- only_gratherAcc(Lst,N,Res,[]).

% The accumulator function needs to stop when the list is empty (end of iteration) and
% set the value of res the same as the value of Acc
only_gratherAcc([],_,Acc,Acc).
% If the check_grather is true then append H to Acc and call the new list NewAcc,
% pass it to the other call and go on
only_gratherAcc([H|Lst],N,Res,Acc):-  check_grather(H,N), append(Acc, [H],NewAcc), only_gratherAcc(Lst,N,Res,NewAcc).
% else ignore the element and go on
only_gratherAcc([_|Lst],N,Res,Acc):-  only_gratherAcc(Lst,N,Res,Acc).

