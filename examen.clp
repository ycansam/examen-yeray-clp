
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
    (robot ?x movimientos ?m cajas ?n_cajas $?tipo)
    (limite ?xMax) 
    (test (and(< ?x ?xMax)(< ?m ?max_mov ))) 
    =>
    (assert (robot (+ ?x 1) movimientos (+ ?m 1) cajas ?n_cajas $?tipo)))

(defrule mover_izquierda
    ( declare (salience 1))
    (max_movimientos ?max_mov )
    (robot ?x movimientos ?m cajas ?n_cajas $?tipo)
    (limite ?xMax) 
    (test (and(> ?x 0)(< ?m ?max_mov )))
    =>
    (assert (robot (- ?x 1) movimientos (+ ?m 1) cajas ?n_cajas $?tipo)))

(defrule coger_cajas
    (declare (salience 10))
    (max_cajas ?max)
    ?f1 <- (robot ?x movimientos ?m cajas ?n_cajas $?tipo)
    ?f2 <- (palet ?pos ?tipo ?cajas_disponibles)
    ?f3 <- (pedido ?numCajasPedido ?algo de ?tipoPedido)
    (test (= ?pos ?x))
    (test (< ?n_cajas ?cajas_disponibles))
    (test (< ?n_cajas ?max)) 
    (test (eq $?tipo "")
    =>
    (retract ?f1)
    (retract ?f2)
    (retract ?f3)
    (assert (robot ?x movimientos ?m cajas (+ ?n_cajas 1) ?tipoPedido))
    (assert (palet ?pos ?tipo (- ?cajas_disponibles 1)))
    (assert (pedido (- ?numCajasPedido 1) ?algo de ?tipoPedido))
    ( printout t"paquetes recogidos" crlf)
)

(defrule entregar_cajas
    (declare (salience 100))
    (max_cajas ?max)
    ?f1 <- (robot ?x movimientos ?m cajas ?n_cajas $?tipo)
    (test (= 0 ?x))
    =>
    (retract ?f1)
    (assert (robot ?x movimientos ?m cajas 0))
    (assert (entregado $?tipo ?n_cajas))
    ( printout t"paquetes entregados" crlf)
)

(defrule finalizar_pedidos
    (declare (salience 200))
    (palet ?pos ?tipo ?cajas_restantes)
    (test (= 0 ?cajas_restantes))
    =>
    (halt)
    ( printout t"No quedan mas paquetes para entregar. finalizado" crlf)
)