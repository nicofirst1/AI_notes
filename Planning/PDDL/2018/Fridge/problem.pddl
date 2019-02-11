(define (problem fridge-p)

    (:domain fridge-d)

    (:objects fridge screw1 screw2 backplane 
                old-compressor new-compressor arm-screw arm-man
                enviroment)
    (:init
        (is-in screw1 backplane)(is-in screw2 backplane)(is-in backplane fridge)
        (is-in old-compressor fridge)(is-in new-compressor enviroment)
        (free arm-screw)(free arm-man)
        (screwable screw1)(screwable screw2)
        (is-arm-screw arm-screw)(is-arm-man arm-man)
        (clear new-compressor)
        (is-on fridge)

    )
   ; (:goal (and
            

;                (is-in new-compressor fridge)
  ;              (is-in screw1 backplane)(is-in screw2 backplane)
   ;             (is-in backplane fridge)

    ;))

      (:goal (and

                (is-in backplane fridge)
                (is-in screw1 backplane)(is-in screw2 backplane)

                (is-in new-compressor fridge)


    ))


)