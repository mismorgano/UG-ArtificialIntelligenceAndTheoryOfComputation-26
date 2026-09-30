#import "@local/tortugui:0.1.0": definition, exercise, proof, solution, template
#import "../definitions.typ": apply_definitions, exercise, gris, deriv, words, eps, bs
#show: template.with(
  course: [Inteligencia Artificial y Teoría de la Computación],
  professor: [Jesús Rodríguez Viorato],
  professor_email: "jesusr@cimat.mx",
  title: [Tarea 3],
  student: [Antonio Barragán Romero],
  student_email: "antonio.barragan@cimat.mx",
  date: datetime(day: 26, month: 9, year: 2026),
)

#show: apply_definitions

#show raw.where(lang: "pseudocode"): it => [
  #show regex("\b(for|do|to|begin|end)\b"): keyword => text(weight: "bold", keyword)
  #it
]
#exercise[
  Sea $n in NN$, y sea $L$ el conjunto de palabras palindromicas de longitud $2n$. Es decir, el lenguaje:
  $
    L = {w w^r: w in {a, b}^* y abs(w) = n}.
  $
  Donde $w^r$ representa la palabra escrita al revés. Encuentre la cantidad minima de estados que puede tener un
  automata deterministico que reconozca $L$. Justifica tu respuesta.
]

#exercise[
  Diseña una maquina de Turing que decida el lenguaje
  $
    L = {w in {0, 1}^*: w "contiene el doble de" 0's "que de" 1's}.
  $
]

#exercise[
  Revisa la definición formal de MT y contesta las siguientes preguntas:
  + ¿Puede una MT escribir un espacio en blanco?
  + ¿Puede el alfabeto de la tira $Gamma$ ser el mismo que el alfabeto de la entrada $Sigma$?
  + Sobre la cabeza de la MT, ¿puede estar en el mismo lugar dos pasos sucesivos?
  + Una maquina de Turing, ¿puede tener solo un estado?
]
#solution[
  Las respuestas dependen de las definiciones usadas. Los textos de referencia son @Sipser_2013 y @Martin_2011.
  + Si, una MT puede escribir un espacio en blanco pues las funciones de transición $delta$ lo permiten.
    En el caso de @Sipser_2013 tenemos que $delta:Q times Gamma -> Q times Gamma times {L, R}$, donde $bs in Gamma$. 
    En el caso de @Martin_2011 se tiene que $delta:Q times (Gamma union {bs}) -> (Q union {q_("accept"), q_("reject")} times (Gamma union {bs}) times {L, R, S}$.
  + Depende de la definición. Por ejemplo, @Sipser_2013 menciona que el alfabeto de entrada no contiene el #bs mientras que el alfabeto de la tira si, entonces no pueden ser iguales. 
    Por otro lado, @Martin_2011 permite la igualdad pues $Sigma subset Gamma$ y $bs in.not Gamma$.
  + Depende de la definición, por ejemplo en @Martin_2011 vimos que las "direcciones" incluyen a $S$(stay), 
    por lo cual si permite estar en el mismo lugar dos pasos sucesivos.
    Por otro lado, en @Sipser_2013 las direcciones permitidas solo son $L, R$, por lo cual en principio dos pasos sucesivos no pueden estar en el mismo lugar,
    sin embargo, menciona que sí la _cabeza_ de la tira esta al principio de la tira e intenta moverse a la izquierda entonces se queda donde esta, y este es el único caso donde no se mueve en dos pasos consecutivos. 
  + No, siempre una MT tiene al menos dos estados distintos el de _aceptación_ y el de _rechazo_, 
    aunque dependiendo de la definición estos pueden no ser parte de $Q$ (los estados).
]

#exercise[
  De una definición formal de un enumerador, o sea, una MT que imprime los elementos del lenguaje. Considérela que se
  una maquina con dos cintas y que usa su segunda tinta como impresora. Incluye la definición de un lenguaje enumerado.
]
#solution[
  a
]

#exercise[
  Revisa el Teorema 3.21 del libro; se demuestra que un lenguaje es Turing-reconocible si algún enumerador lo enumera.
  ¿Por qué no utilizamos el siguiente algoritmo más simple para la prueba? Como en la prueba, $s_1, s_2, dots$ es una
  lista de todas las cadenas $Sigma^*$.
  #align(center)[
    ```pseudocode
    E = "Ignora el input".
      for i= 1, 2, 3, ... do
        EXECUTE M en s_i
        Si la acepta, imprima s_i
      end for"
    ```
  ]
]
#solution[
  Porque el algoritmo anterior no nos garantiza que $E$ se ejecute sobre todas las palabras $s_i$, pues podría suceder
  que $M$ se atore en un loop infinito al ejecutarse sobre alguna $s_j$. Por eso el algoritmos de la prueba esta bien,
  pues nos garantiza que $E$ se va a ejecutar sobre todas las palabras $s_i$ ya que solo ejecuta $M$ un numero finito de
  pasos evitando bucles infinitos.
]

#exercise[
  Demuestre que un AFD con cola reconoce los mimos lenguajes que las MTs, es decir, que son maquinas equivalentes.
]
