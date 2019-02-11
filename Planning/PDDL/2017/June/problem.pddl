(define (problem rcll-p)
    (:domain rcll-d)


    (:objects base-s cap-s ring-s entrance delivery-s
                 ring1 ring2 base cap )
                 
    (:init    (pos base-s) (pos cap-s) (pos ring-s) (pos entrance)(pos delivery-s)
            (at entrance) (ring ring1) (ring ring2)
    
    
    
    )
    (:goal 
            (and
                (made-of base)(made-of ring1)(made-of ring2)(made-of cap)(delivered complete)

            )
    )


)