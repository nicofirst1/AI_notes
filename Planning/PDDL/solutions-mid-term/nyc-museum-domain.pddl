(define (domain museum-domain)
  (:requirements :strips)
  (:predicates (at ?x ?y) (adj ?x ?y) (lights ?x) (wet ?y) (ro ?x) (cu ?x) (helped ?x))


  (:action turnOn
    :parameters (?a)
    :precondition (and (ro ?a)
		       (ro ?a)
           (at ?a sq-1-1)
		       (not (lights on)))
    :effect (and (lights on)))

  (:action talk
    :parameters (?a ?loc ?to)
    :precondition (and (at ?a ?loc)
           (at ?to ?loc)
           (ro ?a)
           (cu ?to)
           (lights on))
    :effect (and (helped ?to)))

  (:action move
    :parameters (?a ?from ?to)
    :precondition (and (at ?a ?from)
		       (adj ?from ?to)
		       (not (wet ?to))
           (ro ?a))
    :effect (and (not (at ?a ?from)) (at ?a ?to)))
)
