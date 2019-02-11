(define (problem agric-p)
        (:domain argic-d)

        (:objects
                s00 s01 s02 s03
                s10 s11 s12 s13
                s20 s21 s22 s23
                s30 s31 s32 s33 

                spray1 spray2
            
        )

    (:init
            
        (adj s00 s01)(adj s00 s10)(adj s00 s11)
        (adj s01 s00)(adj s01 s02)(adj s01 s11)(adj s01 s10)(adj s01 s12)
        (adj s02 s01)(adj s02 s03)(adj s02 s12)(adj s02 s11)(adj s02 s13)
        (adj s03 s02)(adj s03 s13)(adj s03 s12)
        (adj s10 s00)(adj s10 s11)(adj s10 s20)(adj s10 s01)(adj s10 s21)
        (adj s11 s10)(adj s11 s01)(adj s11 s12)(adj s11 s21)(adj s11 s20)(adj s11 s02)(adj s11 s22)(adj s11 s00)
        (adj s12 s11)(adj s12 s02)(adj s12 s13)(adj s12 s22)(adj s12 s21)(adj s12 s03)(adj s12 s23)(adj s12 s01)
        (adj s13 s12)(adj s13 s03)(adj s13 s23)(adj s13 s22)(adj s13 s02)
        (adj s20 s10)(adj s20 s21)(adj s20 s30)(adj s20 s11)(adj s20 s31)
        (adj s21 s20)(adj s21 s11)(adj s21 s22)(adj s21 s31)(adj s21 s30)(adj s21 s12)(adj s21 s32)(adj s21 s10)
        (adj s22 s21)(adj s22 s12)(adj s22 s23)(adj s22 s32)(adj s22 s31)(adj s22 s13)(adj s22 s33)(adj s22 s11)
        (adj s23 s22)(adj s23 s13)(adj s23 s33)(adj s23 s32)(adj s23 s12)
        (adj s30 s20)(adj s30 s31)(adj s30 s21)
        (adj s31 s30)(adj s31 s21)(adj s31 s32)(adj s31 s22)(adj s31 s20)
        (adj s32 s31)(adj s32 s22)(adj s32 s33)(adj s32 s23)(adj s32 s21)
        (adj s33 s32)(adj s33 s23)(adj s33 s22)




        (at s00)
        (weed1 s21)(weed2 s02)(weed1 s33)
        (has spray1)(has spray2)
        (spray spray1)(spray spray2)

    )
    (:goal (and
                (not(weed1 s21))
                (not(weed2 s02))
                (not(weed1 s33))
                (at s00)
            )
    )


)