(define 
    (domain manipulator-d)
    (:predicates 
                (locked ?case)(is-in ?what ?where)(pos ?p)
                (free ?hand)(has ?what) (can-interact ?what)
    )



    (:action grasp
    :parameters (?what ?from)
    :precondition
                (and 
                    (free hand)(can-interact ?what)
                    (pos ?from)(not(locked ?from))
                    (is-in ?what ?from)
                )
    :effect
            (and
                (not(free hand))(has ?what)
            )
    )

    (:action release
    :parameters (?what ?where)
    :precondition
                (and
                    (has ?what)
                    (not(locked ?where))(pos ?where)
                )
    :effect (and
                (not(has ?what))(free hand)(is-in ?what ?where)

            )
    
    )

    (:action unlock1
    :parameters ()
    :precondition 
                (and
                    (has key1)(locked case1)    
                )
    :effect
            (and
                (not(locked case1))
            )
    
    )

    (:action unlock2
    :parameters ()
    :precondition 
                (and
                    (has key2)(locked case2)    
                )
    :effect
            (and
                (not(locked case2))
            )
    
    )

     (:action lock1
    :parameters ()
    :precondition 
                (and
                    (has key1)(not(locked case1))    
                )
    :effect
            (and
                (locked case1)
            )
    
    )

    (:action lock2
    :parameters ()
    :precondition 
                (and
                    (has key2)(not(locked case2))    
                )
    :effect
            (and
                (locked case2)
            )
    
    )


)