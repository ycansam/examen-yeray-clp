
(deffacts datos
    (max_movimientos 56 )
    (robot 0 movimientos 0)
    (palet 1 naranjas 5)
    (palet 2 manzanas 5)
    (palet 3 caquis 5)
    (palet 4 uva 5)
    (2 cajas de naranjas)
    (3 cajas de manzanas)
    (1 caja de uva)
    (limite 4))


(defrule mover_derecha
    ( declare (salience 1))
    (max_movimientos ?max_mov )
    (robot ?x movimientos ?m $?caja)
    (limites ?xMax) 
    (test (and(< ?x ?xMax)(< ?m ?max_mov ))) 
    =>
    (assert (robot (+ ?x 1) ?y movimientos (+ ?m 1) $?caja)))

(defrule mover_izquierda
    ( declare (salience 1))
    (max_movimientos ?max_mov )
    (robot ?x movimientos ?m $?caja)
    (limites ?xMax) 
    (test (and(> ?x 0)(< ?m ?max_mov ))) ;; mientras sea mayor que el limite
    =>
    (assert (robot (- ?x 1) ?y movimientos (+ ?m 1) $?caja)))