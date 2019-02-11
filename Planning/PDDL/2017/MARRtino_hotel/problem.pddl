(define 

    (problem marrtino-1)
    (:domain marrtino-1)


    (:objects  
        s11 s12 s13
        s21 s22 s23
        s31 s32 s33
        s41 s42 s43 
        )
    (:init 
        (adj s11 s21) (adj s21 s11)
        (adj s21 s31) (adj s31 s21) 
        (adj s31 s41) (adj s41 s31)

        (adj s12 s22) (adj s22 s12)
        (adj s22 s32) (adj s32 s22)
        (adj s32 s42) (adj s42 s32)

        (adj s13 s23) (adj s23 s13)
        (adj s23 s33) (adj s33 s23)
        (adj s33 s43) (adj s43 s33)

        (adj s21 s22) (adj s22 s21) 
        (adj s31 s32) (adj s32 s31)

        (adj s22 s23) (adj s23 s22) 
        (adj s32 s33) (adj s33 s32)


        (room s11) (room s12) (room s13)
        (room s21) (room s22) (room s23)
        (room s31) (room s32) (room s33)
        (room s41) (room s42) (room s43)

        (has-door s11)(has-door s12)(has-door s13)
        (has-door s41)(has-door s42)(has-door s43)

        (dirty s12)(dirty s41)(dirty s43)

        (not(free s11))(free s12)(not(fee s13))
        (not(fee s41))(not(free s42))(free s43)

        (open s21) (open s22) (open s23)
        (open s31) (open s32) (open s33)
        (not (open s11))(not (open s12))(not (open s13))
        (not (open s41))(not (open s42))(not (open s43))


        (at s21)


    )
   
      (:goal 
            (and
                (not (dirty s12))
                (not (dirty s43))
            )
      )
      (:goal 
            (and
                (not (dirty s12))
                (not (dirty s43))
                (not (dirty s41))
            )
      )


    

    


)