(define (domain museum-d)

    (:predicates 
                (adj ?s1 ?s2) (wet ?s) (need-help ?g) (at ?who ?where)(is-on ?switch)
    )


    (:action goto
    :parameters (?from ?to)
    :precondition 
                (and
                    (adj ?from ?to)(at robot ?from)
                    (not(wet ?to))
                )
    :effect
            (and
                (at robot ?to)(not (at robot ?from))
            )
    )

    (:action turn-light-on
    :parameters (?where)
    :precondition
                (and
                    (at robot ?where)(at switch ?where)
                )
    :effect (is-on switch)

    )

    (:action help-group
    :parameters (?g ?where)
    :precondition
                (and
                    (need-help ?g)(at ?g ?where)(at robot ?where)
                )
    :effect (not(need-help ?g))
    )


)