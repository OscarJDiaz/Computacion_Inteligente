;Autor: Oscar Jesus Diaz de la Fe

;Minijuego interactivo basado en reglas


(deftemplate personaje
	(slot nombre)
	(slot vida)
	(slot da�o))

(deffacts initial 
	(personaje
	(nombre heroe) 
	(vida 100)
	(da�o 20))

	(personaje
	(nombre enemigo) 
	(vida 160)
	(da�o 20))

	(inicio))

;-----------------------------------

(defrule comienzo
(inicio)
=>
(printout t "Es un dia como cualquier otro. 
Te acabas de deperta en tu peque�a casa, 
preparadao para un nuevo dia en el pueblo.
Al abrir la puerta encuentras una nota, 
el rey te reclama
�Que haras? 
#############################################
#     ()          __             _[]______  #
#    (__)        (__)           /_________| #
#   (_||_)      (____)   _()_     |     |   #
#-----||----------||------||------| []  |---#
#-----------------||------------------------#
#############################################
#                                           #
#         castillo      bosque              #
#                                           #
#############################################" crlf)
(printout t "ir a:")
(assert (ir (readline))))

;-----------------------------------

(defrule castillo
(ir "castillo")
=>
(printout t "Te diriges al castillo.
Cuando llegas los caballeros te escoltan
a la sala del trono donde te espera el rey
Rey-'El reino vecino ha sido conquistado por 
el se�or oscuro, como descendiente del gran heroe
solo tu puedes derrotarlo.
Ve al templo del bosque, reclama la espada de tu 
ancentro y salva a nuestros aliados'
#############################################
#   _ |||        _ _ (  )  _ _  (  )  __ (  #
#  | |( )       | | | ||  | | |  ||  |  | ||#
#  | |_|_   _()_|_|_| ||  |_|_|  ||  |  | ||#
#  |   | |   ||      (  )       (  ) |  |(  #
#-------------------------------------------#
#############################################
#                                           #
#         si               no               #
#                                           #
#############################################" crlf)
(printout t "aceptar la mision?:")
(assert (mision (readline))))

;-----------------------------------

(defrule No
(mision "no")
=>
(printout t "Le cuentas al rey que no
arriesgaras tu vida solo porque lo dice
una vieja leyenda
REY -'Oh, no estaba pidiendo tu opinion,
ahora ve o te ejecutamos aqui y ahora'

Los argumentos del rey, y los 5 guardias detras 
de ti para ejecutarte, te han combencido.
Has aceptado la mision" crlf)
(assert (mision "si")))

;-----------------------------------

(defrule Templo
(mision "si")
=>
(printout t "Llegas al templo del bosque sagrado
Puedes apreciar la belleza del templo ya en reuinas
y en medio, en un altar de piedra bajo la luz del sol,
la espada sagrada
#############################################
#                                 /   /     #
#                   |            /   /      #
#          _()_   __T__         /   /       #
#           ||   |     |       /   /        #
#-------------------------------------------#
#############################################
#                                           #
#         si               no               #
#                                           #
#############################################" crlf)
(printout t "Coger la espada?:")
(assert (espada (readline)))
)

;-----------------------------------

(defrule NoNecesitoArmas
(espada "no")
=>
(printout t "Decidistes que llevar una espada
no es lo tuyo, 'soy un campesino, no un guerrero.
Me largo de aqui'. Te das la vuelta y sales por la
gran entrada del templo sin remordimiento alguno.

Que pena que te estubiera esperando el 
se�or oscuro para darte una pelea...
#############################################
#        _ _0_ ____ _   ___                 #
#       //|   |____|_| |x_x|                #
#      // | _ |         _|_                 #
#         // //         _|_                 #
#-------------------------------------------#
#############################################
#                                           #
#         FINAL: HOMBRE DE PAZ              #
#                                           #
#############################################" crlf)
(printout t "Tu aventura termina aqui, pero
otra empieza, este es el bucle del heroe
Listo (si para recomenzar):")
(assert (bucle (readline))))

;-----------------------------------

(defrule Bucle
(bucle ?a)
=>
(if(eq ?a "si")
then
(printout t "Bien, entonces volvamos al
principio de esta historia." crlf)
(reset)
(run)
else
(printout t "Je... Muy bien, dejemos al heroe descansar  
...por ahora." crlf)
(assert(fin juego))))

;-----------------------------------

(defrule encuentro
(espada "si")
=>
(printout t "�Quien le diria que no a una
espada gratis? Te acercas a la empulladura de
la espada y la estraes del pedestal con todas 
tus fuerzas.
Has reclamado la espada legendaria, es hora de
acabar con el se�or oscuro.
Por suerte, o por desgracia, el se�or oscuro te
esperaba a la entrada del templo
SE�OR OSCURO: 'veo que portas una espada, veamos
si sabes usarla
#############################################
#        _ _0_ __                   ____/   #
#       //|   |||     /            /        #
#      // | _ |||    /_()_        /         #
#         // //        ||        /          #
#-------------------------------------------#
#############################################
#                                           #
#       atacar          curar               #
#                                           #
#############################################" crlf)
(printout t "Accion: ")
(assert (batalla (readline))))

;-----------------------------------

(defrule Batalla
(batalla ?accion)
(personaje (nombre heroe) (vida ?vh) (da�o ?dh))
(personaje (nombre enemigo) (vida ?ve) (da�o ?de))
=>
(if (eq ?accion "atacar")
then
(bind ?ve (- ?ve ?dh))
(printout t "Atacas al se�or oscuro
le haces 20 de da�o
#############################################
#        _ _0_ __                   ____/   #
#       //|   |||                  /        #
#      // | _ ||| ___|_()_        /         #
#         // //      | ||        /          #
#-------------------------------------------#
#   vida E "?ve"    vida tu "?vh"           #
#############################################
#                                           #
#       atacar          curar               #
#                                           #
#############################################" crlf )
(printout t "enter para continuar:")
(assert (continuar (readline))))

(if (eq ?accion "curar")
then
(bind ?vh (+ ?vh 50))
(printout t "Usas el poder de la espada
para curar tus heridas, recuperas 50 de salud
#############################################
#        _ _0_ __     ' '             ____/ #
#       //|   |||   '|    '         /       #
#      // | _ |||   '|_()_ '       /        #
#         // //     '  ||  '      /         #
#-------------------------------------------#
#   vida E "?ve"    vida tu "?vh"           #
#############################################
#                                           #
#       atacar          curar               #
#                                           #
#############################################" crlf )
(printout t "enter para continuar:")
(assert (continuar (readline))))

(if (<= ?vh 0)
then
(printout t "Has muerto
#############################################
#        _ _0_ ____ _   ___                 #
#       //|   |____|_| |x_x|                #
#      // | _ |         _|_                 #
#         // //         _|_                 #
#-------------------------------------------#
#############################################
#                                           #
#             GAME     OVER                 #
#                                           #
#############################################" crlf)
(assert(fin juego))
else
(if (> ?ve 0)
then
(bind ?vh (- ?vh ?de))
(printout t "El se�or oscuro ataca, te hace 
20 de da�o
#############################################
#        _ _0_ ____ _    _             ___/ #
#       //|   |____|_|  |_|          /      #
#      // | _ |         _|_         /       #
#         // //         _|_        /        #
#-------------------------------------------#
#   vida E "?ve"    vida tu "?vh"           #
#############################################
#                                           #
#       atacar          curar               #
#                                           #
#############################################" crlf)
(retract *)
(printout t "Accion: ")
(assert (batalla (readline)))
(assert(personaje (nombre heroe) (vida ?vh) (da�o ?dh)))
(assert(personaje (nombre enemigo) (vida ?ve) (da�o ?de)))

else
(printout t "Has derrotado al se�or oscuro,
el reino esta a salvo
#############################################
#           |                          ___/ #
#           |_()_                    /      #
#         ____||____                /       #
#      ()|__________|              /        #
#-------------------------------------------#
#############################################
#                                           #
#       FINAL: HEROE DE LEYENDA             #
#                                           #
#############################################" crlf))
(assert(fin juego)))
)

;-----------------------------------

(defrule Bosque
(ir "bosque")
=>
(printout t "Estas en el bosque, es dificil
saber donde estas con exactitud
#############################################
#     ()      ()     ()      ()      ()     #
#    (__)    (__)   (__)    (__)    (__)    #
#   (_||_)  (_||_) (_||_)  (_||_)  (_||_)   #
#-----||------||-----||-_()_-||------||-----#
#------------------------||-----------------#
#############################################
#                                           #
#    norte          sur        este         #
#                                           #
#############################################"crlf)
(printout t "A donde vas?:")
(assert (bosque (readline)))
)

;-----------------------------------

(defrule Bosque2
(or
(bosque "norte")
(bosque "sur")
(bosque "este"))
=>
(printout t "Sigues en el bosque, es dificil
saber donde estas con exactitud
#############################################
#     ()      ()     ()      ()      ()     #
#    (__)    (__)   (__)    (__)    (__)    #
#   (_||_)  (_||_) (_||_)  (_||_)  (_||_)   #
#-----||-_()_-||-----||------||------||-----#
#---------||--------------------------------#
#############################################
#                                           #
#    norte          sur        este         #
#                                           #
#############################################"crlf)
(printout t "A donde vas?:")
(assert (bosque2 (readline)))
)

;-----------------------------------

(defrule Bosque3
(or
	(bosque2 "norte")
	(bosque2 "sur")
	(bosque2 "este"))
=>
(printout t "Sigues en el bosque, pero oyes
una voz desde dentro de una cueva cercana
#############################################
#     ()      ()     ()      ()        ---/ #
#    (__)    (__)   (__)    (__)      /   | #
#   (_||_)  (_||_) (_||_)  (_||_)_()_/    / #
#-----||------||-----||------||---||/----/--#
#-------------------------------------------#
#############################################
#                                           #
#    si                       no            #
#                                           #
#############################################"crlf)
(printout t "Entrar a la cueva?:")
(assert (cueva (readline))))

;-----------------------------------

(defrule Casa
(cueva "no")
=>
(printout t "Decides ignorar los secretos de la
cueva y regresar a casa. Despues de un par de 
hora consigues regresar al pueblo.
Otro gran dia al aire libre !!!
#############################################
# |               _ _      _______ <zzz)    #
# |_    ____     |_|_|    |_____|0|         #
# | |  |    |             |    |  |         #
#-------------------------------------------#
#############################################
#                                           #
#    FINAL    DIA AGOTADOR                  #
#                                           #
#############################################"crlf)
(assert(fin juego)))

;-----------------------------------

(defrule Cueva
(cueva "si")
=>
(printout t "Decides explorar la cueva, el frio
y la humedad te congelan los huesos, pero continuas
en busca del misterioso sonido. 
Finalmente llegas a lo m�s profundo de la cueva para
encontrar a un dragon durmiendo sobre una pila enorme
de oro 
#############################################
#                ''     _____/|_____________#
#                 ''___/_/  /_|            /#
#        _()_    /___________/ /______/ /_/ #
#         ||           |______/    |___/    #
#############################################
#                                           #
#    luchar       correr     robar          #
#                                           #
#############################################"crlf)
(printout t "Entrar a la cueva?:")
(assert (dragon (readline))))

;-----------------------------------

(defrule Dragon
(dragon "luchar")
=>
(printout t "Intentas pateticamente golpearlo
con tus pu�os, por suerte no se ha despertado,
Te vas de la cueva, pero tienes una extra�a
sensacion de orgullo y verguenza"crlf)
(assert (dragon "correr")))

;-----------------------------------

(defrule Pueblo
(dragon "correr")
=>
(printout t "Llegas a la plaza del pueblo,
donde cuentas a todo el mundo sobre tu
encuentro con el dragon.
Nadie te cree, y poco a poco empiezas a ser 
conocido como el loco del pueblo
#############################################
#       ha ha ha                            #
#             ha ha ha              ha ha   #
#       ()-   ()-         _()_      _()     #
#       ||    ||           ||        ||     #
#############################################
#                                           #
#    FINAL    BUFON DEL PUEBLO              #
#                                           #
#############################################"crlf)
(assert(fin juego)))

;-----------------------------------

(defrule Ladron
(dragon "robar")
=>
(printout t "Por desgracia dejastes tu saco 
en tu casa, pero seguro que te las puedes 
apallar para llevarte un buen par de tesoros.
Al llegar al pueblo te has combertido en una
persona inmensamente rica, pasastes el resto
de tu vida viviendo en la alta sociedad entre
fiestas y lujos 
#############################################
#     _|_      _|_      _|_      _|_        #
#    (_|_     (_|_     (_|_     (_|_        #
#     _|_)     _|_)     _|_)     _|_)       #
#      |        |        |        |         #
#############################################
#                                           #
#    FINAL           RIQUESAS ABSOLUTAS     #
#                                           #
#############################################"crlf)
(assert(fin juego)))

;-----------------------------------

(defrule NoEncontrado
(not(fin juego))
=>
(printout t "Lo que has escrito no era una opcion, vuelve a intentarlo"crlf)
(printout t "enter para continuar:")
(assert (continuar (readline)))
(reset)
(run)
)




















