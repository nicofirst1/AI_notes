(define
    (domain grid-d)
    (:predicates    (adj ?s1 ?s2)
                    (is-pos ?s)(is-orent ?or)
                    (at-pos ?pos)(at-or ?orent)
                    (adj-loc ?or1 ?or2) (rotation ?avaiable))
    
    (:constants true)

    (:action rotate
    :parameters (?from ?to)
    :precondition 
                (and
                    (is-orent ?from)(is-orent ?to)
                    (at-or ?from)(adj-loc ?from ?to)
                    (rotation true)
                )
    :effect 
            (and
                (not(rotation true))
                (at-or ?to)(not(at-or ?from))
            )
    
    )
    (:action move
    :parameters (?from ?to ?orent)
    :precondition 
                (and
                    (is-pos ?from)(is-pos ?to)
                    (is-orent ?orent)
                    (at-pos ?from)(adj ?from ?to)
                )
    :effect 
            (and
                (rotation true)
                (at-pos ?to)(not(at-pos ?from))
            )
    
    )


)