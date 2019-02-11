(define (domain fridge-d)
    (:predicates
        (is-in ?what ?where)(is-on ?fridge)(free ?arm)(screwable ?s)
        (is-arm-screw ?a)(is-arm-man ?a)(is-compressor ?c)(clear ?what)
    )

    (:action turnFridgeOff
    :parameters ()
    :precondition(and (is-on fridge))
    :effect (not(is-on fridge))
    
    )

    (:action replace-compressor
    :parameters ()
    :precondition
                (and
                    (is-in old-compressor fridge)(not(is-on fridge))
                    (is-in new-compressor arm-man)
                    (not (is-in backplane fridge))
                )
    :effect
            (and
                (is-in new-compressor fridge)(not(is-in old-compressor fridge))
                (is-in old-compressor arm-man)(not (is-in new-compressor arm-man))
                (not(free arm-man))
            )
    )

    (:action screw-On-Plate
    
        :parameters (?screw)
        :precondition
                    (and
                        (is-in ?screw arm-man)
                        (not(free arm-man))
                        (free arm-screw)
                        (screwable ?screw)

                    )
        :effect
                (and
                    (is-in ?screw backplane)
                    (not (is-in ?screw arm-man))
                    (free arm-man)
                    
                )
    )

    (:action pick-Up-Plate
    
        :parameters (?from)
        :precondition 
                    (and
                        (not(is-in screw1 backplane))(not(is-in screw2 backplane))
                        (free arm-man)(is-in backplane ?from)
                    )
        :effect
                (and
                    (is-in backplane arm-man)
                    (not (is-in backplane ?from))
                    (not (free arm-man))
                    
                )
    
    )

    (:action pickUp
    
        :parameters (?what)
        :precondition 
                    (and
                        (is-in ?what enviroment)
                        (free arm-man)
                       ; (clear ?what)
                    )
        :effect
                (and
                    (is-in ?what arm-man)
                    (not (free arm-man))
                    
                )
    
    )

    (:action place-On-Env
    :parameters (?what)
    :precondition
                (and
                    (is-in ?what arm-man)
                    (not (free arm-man))
                    
                )
    :effect
            (and
                (is-in ?what enviroment)
                (not (is-in ?what arm-man))
                (free arm-man)
                (clear ?what)
            )
    )

    (:action place-Plate
    :parameters (?where)
    :precondition
                (and
                    (is-in backplane arm-man)
                    (not (free arm-man))
                    (not(is-in screw1 backplane))
                    (not(is-in screw2 backplane))
                    (not (is-arm-man ?where))
                    
                )
    :effect
            (and
                (is-in backplane ?where)
                (not (is-in backplane arm-man))
                (free arm-man)
              ;  (clear ?what)
            )
    )

    (:action unscrew
    :parameters (?screw )
    :precondition 
                (and
                    (screwable ?screw) (is-in ?screw backplane)  
                    (free arm-man)
                )
    :effect
            (and
                (not(is-in ?screw backplane))(is-in ?screw arm-man)
                (not(free arm-man))

            
            )
    
    )



)