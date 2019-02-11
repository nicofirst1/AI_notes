(define (domain marrtino-1)
(:predicates (adj ?s1 ?s2) (room ?r) (has-door ?r) (dirty ?r)(open ?r) (free ?r)(at ?r))

(:action go-to
:parameters (?from ?to)
:precondition (and
                (room ?from)(room ?to)
                (at ?from)(adj ?from ?to)
                (open ?to)
                )
:effect (and
            (at ?to)(not(at ?from))
        )

)

(:action open-door
:parameters (?from ?to)
:precondition (and
                (room ?from)(room ?to)(at ?from)
                (adj ?to ?from)
                (has-door ?to)
                (not (open ?to))(free ?to)
                )
:effect (and
            (open ?to)

        )
)

(:action clean
:parameters (?where)
:precondition (and
                    (at ?where) (dirty ?where) (room ?where)
                )
:effect (and (not(dirty ?where)))

)



)