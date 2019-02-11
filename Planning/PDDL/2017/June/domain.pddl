(define (domain rcll-d)
    (:predicates 
        (delivered ?complete) (has ?what) (made-of ?what)
         (done-with ?what) (pos ?p)(at ?p) (ring ?r)
    )

    (:constants complete)


    (:action goto
    :parameters (?from ?to)
    :precondition
                (and
                    (at ?from)(pos ?from)(pos ?to)
                )
    :effect 
            (and
                (at ?to)(not(at ?from))
            )
    )

    (:action deliver
    :parameters ()
    :precondition (and(has complete)(at delivery-s))
    :effect (and(delivered complete))
    
    )

    (:action put-cap
    :parameters (?which)
    :precondition
                (and
                    (at cap-s)(ring ?which)
                    (made-of ?which)
                )
    :effect (and
            (made-of cap)
            (has complete)


    )
    )

     (:action put-ring
    :parameters (?which)
    :precondition
                (and
                    (at ring-s)(ring ?which)
                    (made-of base)
                )
    :effect (and
            (made-of ?which)
            

    )
    )

     (:action put-base
    :parameters ()
    :precondition
                (and
                    (at base-s)
                )
    :effect (and
            (made-of base)
            

    )
    )

)