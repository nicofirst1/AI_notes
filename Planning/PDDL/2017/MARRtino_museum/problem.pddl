(define 

    (problem museum-p)
    (:domain museum-d)

    (:objects
                s00 s01 s02 s03
                s10 s11 s12 s13
                g1 g2 g3 
                switch 
                robot
        
    )
    (:init

        (adj s00 s01)(adj s00 s10)
        (adj s01 s00)(adj s01 s02)
        (adj s02 s01)(adj s02 s03)
        (adj s03 s02)(adj s03 s13)
        (adj s10 s00)(adj s10 s11)
        (adj s11 s10)(adj s11 s12)
        (adj s12 s11)(adj s12 s13)
        (adj s13 s12)(adj s13 s03)

        (at g1 s00)(at g2 s02)(at g3 s12)
        (at robot s00)
        (wet s01)
        (at switch s11)

        (need-help g1)(need-help g2)(need-help g3)
        (not(is-on switch))
            
    )
    (:goal
            (and
                (is-on switch)
                (not (need-help g1))
                (not (need-help g2))
                (not (need-help g3))
            
            )
    
    )



)