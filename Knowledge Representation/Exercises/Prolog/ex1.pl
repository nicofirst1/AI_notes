% try to understand what this is for...
foo(_ ,[],[]). 
foo(I,[I | P],R) :- foo(I,P,R). 
foo(I,[H | T],[H | R]) :- foo(I,T,R).


% Given foo(I,P,R).
% This predicate removes every occurrence of the element I in P 
% and checks if what is left is the same as the list R

foo(_ ,[],[]). 
% 1) Is used to return true whenever P and R are empty lists


foo(I,[I | P],R) :- foo(I,P,R). 
% 2) Is used to check if the first element of P is equal to I, if yes then 
% remove it and call foo on the tail of P, else call:

foo(I,[H | T],[H | R]) :- foo(I,T,R).
% 3) this last implementation is called when the first element of P is not equal to I.
% then it must be equal to the first element of R, if so call foo again removing
% the first element from P and R, else return false

% For example having:
% foo(1,[1,2,1,3,1,1,4,1,1],[2,3,4])
% will  first call 1) which fails, 2) removes the first one and we're left with:
% I=1, P=[2,1,3,1,1,4,1,1], R=[2,3,4]
% Now both 1) and 2) fails, and 3) removes 2 from both R and P, resulting in:
% I=1, P=[1,3,1,1,4,1,1], R=[3,4]
% 1 is removed with 2)
% I=1, P=[3,1,1,4,1,1], R=[3,4]
% 3 is removed with 3)
% I=1, P=[1,1,4,1,1], R=[4]
% 1 is removed with 2) two times
% I=1, P=[4,1,1], R=[4]
% 4 is removed with 3)
% I=1, P=[1,1], R=[]
% 1 is removed with 2) two times
% I=1, P=[], R=[]
% finally the input matches 1) and true is returned




