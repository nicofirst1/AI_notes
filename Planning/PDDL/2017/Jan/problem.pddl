(define (problem mobile-manipulator)
        (:domain manipulator-d)
        
        (:objects case1 case2 obj key1 key2 hand working-place)
        (:init 
                (locked case1)(not(locked case2))(not(locked working-place))
                (is-in obj case2)(is-in key1 working-place)(is-in key2 working-place)
                (free hand)
                (can-interact obj)(can-interact key1)(can-interact key2)
                (pos case1)(pos case2)(pos working-place)

            )
        (:goal (and(is-in obj case1)(is-in key1 case2)(locked case1)))
)