(define (problem grid-p)
    (:domain grid-d)
    (:objects 
            s00 s01 s02 s03
            s10 s11 s12 s13
            s20 s21 s22 s23
            s30 s31 s32 s33

        n s e w no ne so se

    )
    (:init  


            (is-pos s00) (is-pos s01) (is-pos s02) (is-pos s03)
            (is-pos s10) (is-pos s11) (is-pos s12) (is-pos s13)
            (is-pos s20) (is-pos s21) (is-pos s22) (is-pos s23)
            (is-pos s30) (is-pos s31) (is-pos s32) (is-pos s33)
           (is-orent n)
           (is-orent s)
           (is-orent e)
           (is-orent w)
           (is-orent no)
           (is-orent ne)
           (is-orent so)
           (is-orent se)
           


   (adj s00 s01)

(adj s01 s00)
(adj s01 s02)

(adj s02 s01)
(adj s02 s03)
(adj s02 s13)

(adj s03 s02)
(adj s03 s13)

(adj s13 s03)
(adj s13 s23)
(adj s13 s22)
(adj s13 s02)

(adj s21 s22)
(adj s21 s31)
(adj s21 s30)
(adj s21 s32)

(adj s22 s21)
(adj s22 s23)
(adj s22 s32)
(adj s22 s31)
(adj s22 s13)
(adj s22 s33)

(adj s23 s22)
(adj s23 s13)
(adj s23 s33)
(adj s23 s32)

(adj s30 s31)
(adj s30 s21)

(adj s31 s30)
(adj s31 s21)
(adj s31 s32)
(adj s31 s22)

(adj s32 s31)
(adj s32 s22)
(adj s32 s33)
(adj s32 s23)
(adj s32 s21)

(adj s33 s32)
(adj s33 s23)
(adj s33 s22)


    (adj-loc n ne)(adj-loc ne n)
    (adj-loc n no )(adj-loc no n )
    (adj-loc n w)(adj-loc w n)
    (adj-loc n e)(adj-loc e n)
    (adj-loc s se)(adj-loc se s)
    (adj-loc s so )(adj-loc so s)
    (adj-loc s w)(adj-loc w s)
    (adj-loc s e)(adj-loc e s)

    (at-or ne)(at-pos s21)(rotation true)
                
            )
   (:goal  (and (at-pos s00)(at-or n)))
 ;   (:goal  (and (at-or s)))


)