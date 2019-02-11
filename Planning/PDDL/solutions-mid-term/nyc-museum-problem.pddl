(define (problem museum-problem)
  (:domain museum-domain)
  (:objects sq-0-0 sq-0-1 sq-0-2 sq-0-3 
            sq-1-0 sq-1-1 sq-1-2 sq-1-3
            robot customer1 customer2 customer3 on)

  (:init (adj sq-0-0 sq-1-0) (adj sq-1-0 sq-0-0)
         (adj sq-0-0 sq-0-1) (adj sq-0-1 sq-0-0)
         (adj sq-0-1 sq-0-2) (adj sq-0-2 sq-0-1)
         (adj sq-0-2 sq-0-3) (adj sq-0-3 sq-0-2)
 
         (adj sq-0-3 sq-1-3) (adj sq-1-3 sq-0-3)
         (adj sq-1-0 sq-1-1) (adj sq-1-1 sq-1-0)
         (adj sq-1-1 sq-1-2) (adj sq-1-2 sq-1-1)
         (adj sq-1-2 sq-1-3) (adj sq-1-3 sq-1-2)

         (wet sq-0-1)
         (not (lights on))
         (at robot sq-1-0)
         (ro robot)
         (cu customer1) (cu customer2) (cu customer3)
         (at customer1 sq-0-0) (at customer2 sq-0-2) (at customer3 sq-1-2)
  )
  (:goal (and (lights on) (helped customer1) (helped customer2) (helped customer3)))
)
