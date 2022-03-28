
(deffacts datos
    (max_movimientos 56 )
    (robot 0 movimientos 0 cajas 0)
    (max_cajas 3)
    (palet 1 naranjas 5)
    (palet 2 manzanas 5)
    (palet 3 caquis 5)
    (palet 4 uva 5)
    (pedido 2 cajas de naranjas)
    (pedido 3 cajas de manzanas)
    (pedido 1 caja de uva)
    (limite 4))


(defrule mover_derecha
    (declare (salience 1))
    (max_movimientos ?max_mov )
    (max_cajas ?max_cajas)
    (robot ?x movimientos ?m cajas ?n_cajas )
    (limite ?xMax) 
    (test (and(< ?x ?xMax)(< ?m ?max_mov ))) 
    =>
    (assert (robot (+ ?x 1) movimientos (+ ?m 1) cajas ?n_cajas )))

(defrule mover_izquierda
    ( declare (salience 1))
    (max_movimientos ?max_mov )
    (robot ?x movimientos ?m cajas ?n_cajas )
    (limite ?xMax) 
    (test (and(> ?x 0)(< ?m ?max_mov ))) ;; mientras sea mayor que el limite
    =>
    (assert (robot (- ?x 1) movimientos (+ ?m 1) cajas ?n_cajas )))

(defrule coger_caja
    (declare (salience 10))
    (max_cajas ?max_cajas)
    (robot ?x movimientos ?m cajas ?n_cajas)
    (palet ?pos ?tipo ?cajas_disponibles)
    (test (= ?pos ?x))
    (test (< ?n_cajas ?max_cajas))
    =>
    (assert (robot ?x movimientos ?m cajas ?n_cajas)
    ))