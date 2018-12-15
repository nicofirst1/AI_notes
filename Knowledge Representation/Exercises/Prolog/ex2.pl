/*
Write a Prolog program that given a binary tree and a list of forbidden members,
verifies that there exists a path from the root to a leaf that contains at most 
one occurrence of a forbidden number (x).
*/

% using the notation 
% tree(Symbol,LeftBranch,RightBranch)

/*
tree(1,
    tree(x,
        tree(4,
            tree(x,
                    nil,
                    tree(5,nil,nil)),
            tree(7,nil,nil)),
        tree(6,nil,nil)),
    tree(3,
        tree(2,nil,nil),
        tree(x,
            tree(8,
                tree(x,tree(9,nil,nil),nil),
                nil),
            tree(10,nil,nil))))
*/



check_symbol(Symbol,Counter):-
    Symbol == x,
    Counter is 1.

check_symbol(Symbol,Counter):-
    Symbol \== x,
    Counter is 0.

forbitten_path(Goal,Tree):- forbitten_path_acc(Goal,Tree,0).

forbitten_path_acc(Goal,tree(Goal,_,_),_).

forbitten_path_acc(Goal,tree(Symbol,L,_),ForbittenCount):-
    check_symbol(Symbol,C),
    NewForbittenCount is ForbittenCount +C,
    NewForbittenCount =<1,
    forbitten_path_acc(Goal,L,NewForbittenCount).

forbitten_path_acc(Goal,tree(Symbol,_,R),ForbittenCount):-
    check_symbol(Symbol,C),
    NewForbittenCount is ForbittenCount +C,
    NewForbittenCount =<1,
    forbitten_path_acc(Goal,R,NewForbittenCount).

