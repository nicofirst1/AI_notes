(define (domain argic-d)
(:predicates (weed1 ?pos)(weed2 ?pos)(at ?pos)(adj ?pos1 ?pos2)(has ?spray)(spray ?s))



    (:action refuel
        :parameters ()
        :precondition (and (at s00) )
        :effect (and (has spray1)(has spray2))

    )

    (:action sprayWeed1
        :parameters (?where ?spray)
        :precondition 
                    (and
                        (has ?spray)
                        (at ?where)
                        (weed1 ?where)
                        (spray ?spray)

                    )
        :effect 
                (and
                    (not(has ?spray))
                    (not(weed1 ?where))
                )
    )

    (:action sprayWeed2
        :parameters (?where )
        :precondition 
                    (and

                        (has spray1)
                        (has spray2)
                        (at ?where)
                        (weed2 ?where)

                    )
        :effect 
                (and
                    (not(has spray1))
                    (not(has spray2))
                    (not(weed2 ?where))
                )
    )

    (:action goto
        :parameters(?from ?to)
        :precondition
                    (and
                        (at ?from)(adj ?from ?to)
                    )

        :effect 
                (and
                    (at ?to)(not(at ?from ))
                )
    )



)



