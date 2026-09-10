#import "@local/tortugui:0.1.0": template, proof, solution
#import "../definitions.typ": apply_definitions, exercise, gris, deriv, words, eps
#import "@preview/finite:0.5.1" as finite: automaton, cetz
#import "@preview/flautomat:0.1.0": flautomat
#show: template.with(
  course: [Inteligencia Artificial y Teoría de la Computación],
  professor: [Jesús Rodríguez Viorato],
  professor_email: "jesusr@cimat.mx",
  title: [Tarea 2],
  student: [Antonio Barragán Romero],
  student_email: "antonio.barragan@cimat.mx",
  date: datetime(day: 27, month: 8, year: 2025),
)
#show: apply_definitions
// #let eps =  $epsilon$

#let automaton = finite.automaton.with(state-format: label => "", style: (
  state: (radius: 0.2, fill: gris, stroke: black + 0.5pt, extrude: 0.66),
  // q5: (radius: 0.3),
  transition: (curve: 0.01, stroke: black + 0.5pt, angle: (0deg)),
))
#let format_step(exp, automata) = {
  align(center)[
    #grid(columns: (1fr, 5fr), align: (horizon + left, center), exp, automata)
  ]
}


#exercise[10 pts][
  Demuestre que el lenguaje $L = {0^n 1^m: n!= m}$ no es regular.
]
#proof[
  Procedamos por contrapositiva y veamos que $L$ no satisface el _lema del bombeo_. Dado $n in NN$ consideremos la
  siguiente cadena $w$ dada por $w = 0^n 1^(n! + n)$, se puede ver que $w in L$ pues para todo $n in NN$ se tiene que $n! + n > n$.
  Luego para toda descomposición $w = x y z$ de $w$ con $abs(x y) <= n$ y $abs(y)>0$ se debe cumplir que $x=0^(n-k-i)$, $y = 0^k$ y $z = 0^i 1^(n! + n)$ para
  algún $k in {1, dots, n}$ y algún $i in {0,1, dots, n-1}$ de tal manera que $abs(x y) = n-l-i +k = n-i <=n$
  . Entonces, dado $k in {1, dots, n}$ la longitud de $y$, consideremos una de tales descomposiciones, es decir, $w = x y z$ con $x=0^(n-k -i)$, $y = 0^k$ y $z = 0^i 1^(n! + n)$,
  para algún $i in {0,1, dots, n-1}$, es claro que $n!/k in NN$ dado que $1<= k <=n$, y notemos que $x y^(n!/k + 1) z in.not L$, pues
  $
    x y^(n!/k + 1) z &= 0^(n-k -i) (0^k)^(n!/k + 1) 0^i 1^(n! + n) = 0^(n-k -i ) 0^(k n!/k + k) 0^i 1^(n! + n) \
                     &= 0^(n-k-i) 0^(n! +k) 0^i 1^(n! + n)= 0^n 0^n! 1^(n! + n) = 0^(n! + n)1^(n! + n),
  $
  tiene la misma cantidad de $0$'s que de $1$'s.
  De lo anterior, dado que $n$ fue arbitrario tenemos que $L$ no puede ser regular, pues no cumple el _lema del bombeo_.

  Otra forma de demostrarlo es suponiendo que $L$ es _regular_, entonces $L^complement$ también es _regular_, luego, dado que $0^*1^*$ es claramente regular,
  pues es concatenación de dos lenguajes regulares, obtenemos que $B := L^complement inter 0^*1^*$ debe ser _regular_. Sin embargo, notemos que
  $
    B := L^complement inter 0^*1^* = {0^n 1^n: n in NN_0 },
  $
  es cual sabemos no es _regular_, obtenemos asi una contradicción y por tanto $L$ no es _regular_.
]

#exercise[10 pts][
  Convierte las siguientes ERs en AFNDs usando el método visto en clase (Teorema 1.54 de @Sipser_2013). Para todos los
  casos usa $Sigma = {a,b}$.
  #set enum(numbering: "A.")
  + $a(a b b)^* union b$
  + $a^+ union (a b)^+$
  + $(a union b^+)a^+b^+$
]
#solution[
  #set enum(numbering: "A.")
  Al igual que en @Sipser_2013 hagamoslo paso a paso.
  Vamos a saltarnos los pasos pequeños, es claro que se podrían remover algunas $eps$-transiciones, sin embargo las dejaremos por completitud.
  + Para la ER $a(a b b)^* union b$ tenemos lo siguiente:
    #format_step()[$a b b$][
      #scale(automaton(
        ((q0: (q1: "a"), q1: (q2: 0), q2: (q3: "b"), q3: (q4: 0), q4: (q5: "b"))),
        initial: "q0",
        final: "q5",
        labels: (q1-q2: $epsilon$, q3-q4: $epsilon$),
        state-format: label => "",
        style: (
          state: (radius: 0.2, fill: gris, stroke: black + 0.5pt, extrude: 0.66),
          q5: (radius: 0.3),
          transition: (curve: 0.01, stroke: black + .5pt),
        ),
      ))
    ]
    #format_step()[$(a b b)^*$][
      #scale(automaton(
        (q6: (q0: $eps$), q0: (q1: "a"), q1: (q2: 0), q2: (q3: "b"), q3: (q4: 0), q4: (q5: "b"), q5: (q0: $eps$)),
        initial: "q6",
        final: ("q6", "q5",),
        labels: (q1-q2: $epsilon$, q3-q4: $epsilon$),
        state-format: label => "",
        style: (
          state: (radius: 0.2, fill: gris, stroke: black + 0.5pt, extrude: 0.66),
          // q5: (radius: 0.3),
          transition: (curve: 0.01, stroke: black + 0.5pt),
          q5-q0: (curve: 1, label: (dist: -0.22)),
        ),
      ))
    ]
    #format_step()[$a(a b b)^*$][
      #scale(automaton(
        (
          q8: (q7: "a"),
          q7: (q6: $eps$),
          q6: (q0: $eps$),
          q0: (q1: "a"),
          q1: (q2: 0),
          q2: (q3: "b"),
          q3: (q4: 0),
          q4: (q5: "b"),
          q5: (q0: $eps$),
        ),
        initial: "q8",
        final: ("q6", "q5",),
        labels: (q1-q2: $epsilon$, q3-q4: $epsilon$),
        state-format: label => "",
        style: (
          state: (radius: 0.2, fill: gris, stroke: black + 0.5pt, extrude: 0.66),
          // q5: (radius: 0.3),
          transition: (curve: 0.01, stroke: black + 0.5pt),
          q5-q0: (curve: 1, label: (dist: -0.22)),
        ),
      ))
    ]
    #format_step()[$a(a b b)^* union b $][
      #scale(automaton(
        (
          q8: (q9: $eps$, q10: $eps$),
          q9: (q7: $a$),
          q7: (q6: $eps$),
          q6: (q0: $eps$),
          q0: (q1: $a$),
          q1: (q2: 0),
          q2: (q3: $b$),
          q3: (q4: 0),
          q4: (q5: $b$),
          q5: (q0: $eps$),
          q10: (q11: $b$),
        ),
        layout: (q8: (0, 0), q9: (1, 1), q10: (1, -1), rest: (rel: (1.3, 0))),
        initial: "q8",
        final: ("q6", "q5", "q11"),
        labels: (q1-q2: $epsilon$, q3-q4: $epsilon$),
        state-format: label => "",
        style: (
          state: (radius: 0.2, fill: gris, stroke: black + 0.5pt, extrude: 0.66),
          // q5: (radius: 0.3),
          transition: (curve: 0.01, stroke: black + 0.5pt, angle: 0deg),
          q5-q0: (curve: 1, label: (dist: -0.22)),
          q8-q10: (label: (dist: -0.33)),
        ),
      ))
    ]
  + Para le ER $a^+ union (a b)^+$ recordemos que $R^+ = R R^*$ y obtenemos que:
    #format_step()[$ a$][
      #scale(automaton((q0: (q1: "a"), q1: none)))
    ]
    #format_step()[$a^*$][
      #scale(automaton((p0: (p1: $eps$), p1: (p2: "a"), p2: (p1: $eps$)), final: ("p0", "p2"), style: (
        state: (radius: 0.2, fill: gris, stroke: black + 0.5pt, extrude: 0.66),
        // q5: (radius: 0.3),
        transition: (curve: 0.01, stroke: black + 0.5pt),
        p2-p1: (curve: .5),
      )))
    ]
    #format_step()[$a^+ := a a^*$][
      #scale(automaton(
        (q0: (q1: "a"), q1: (p0: $eps$), p0: (p1: $eps$), p1: (p2: "a"), p2: (p1: $eps$)),
        final: ("p0", "p2"),
        style: (
          state: (radius: 0.2, fill: gris, stroke: black + 0.5pt, extrude: 0.66),
          // q5: (radius: 0.3),
          transition: (curve: 0.01, stroke: black + 0.5pt),
          p2-p1: (curve: .5),
        ),
      ))
    ]
    #format_step()[$(a b)^*$][
      #scale(automaton(
        (r0: (r1: $eps$), r1: (r2: $a$), r2: (r3: $eps$), r3: (r4: $b$), r4: (r1: $eps$)),
        final: ("r0", "r4"),
        style: (
          state: (radius: 0.2, fill: gris, stroke: black + 0.5pt, extrude: 0.66),
          // q5: (radius: 0.3),
          transition: (curve: 0.01, stroke: black + 0.5pt),
          r4-r1: (curve: .8),
        ),
      ))
    ]
    #format_step()[$a^+ union (a b)^*$][
      #scale(automaton(
        (
          s: (q0: $eps$, r0: $eps$),
          q0: (q1: $a$),
          q1: (p0: $eps$),
          p0: (p1: $eps$),
          p1: (p2: $a$),
          p2: (p1: $eps$),
          r0: (r1: $eps$),
          r1: (r2: $a$),
          r2: (r3: $eps$),
          r3: (r4: $b$),
          r4: (r1: $eps$),
        ),
        layout: (s: (0, 0), q0: (1, 1), r0: (1, -1), rest: (rel: (1.3, 0))),
        final: ("p0", "p2", "r0", "r4"),
        style: (
          state: (radius: 0.2, fill: gris, stroke: black + 0.5pt, extrude: 0.66),
          // q5: (radius: 0.3),
          transition: (curve: 0.01, stroke: black + 0.5pt, angle: 0deg),
          r4-r1: (curve: .8),
          p2-p1: (curve: .5),
          s-r0: (label: (dist: -0.33), angle: (0deg)),
        ),
      ))
    ]
  + Para la ER $(a union b^+)a^+b^+$ usemos algunos autómatas construidos en el inciso anterior para obtener:
    #format_step()[$ a$][
      #scale(automaton((q0: (q1: $a$), q1: none)))
    ]
    #format_step()[$b^+ := b b^*$][
      #scale(automaton(
        (b0: (q1: $b$), q1: (p0: $eps$), p0: (p1: $eps$), p1: (p2: $b$), p2: (p1: $eps$)),
        final: ("p0", "p2"),
        style: (
          state: (radius: 0.2, fill: gris, stroke: black + 0.5pt, extrude: 0.66),
          // q5: (radius: 0.3),
          transition: (curve: 0.01, stroke: black + 0.5pt),
          p2-p1: (curve: .5),
        ),
      ))
    ]
    #format_step()[$a union b^+$][
      #scale(automaton((
        u0: (q0: ($eps$), r0: $eps$),
        q0: (q1: $a$),
        q1: none,
        r0: (r1: $b$),
        r1: (p0: $eps$),
        p0: (p1: $eps$),
        p1: (p2: $b$),
        p2: (p1: $eps$),
      ), layout: (u0: (0, 0), q0: (1, 1), r0: (1, -1), rest: (rel: (1.2, 0))), final: ("q1", "p0", "p2",), style: (
        state: (radius: 0.2, fill: gris, stroke: black + 0.5pt, extrude: 0.66),
        // q5: (radius: 0.3),
        transition: (curve: 0.01, stroke: black + 0.5pt, angle: 0deg),
        p2-p1: (curve: .5),
        u0-r0: (label: (dist: -0.33)),
      )))
    ]
    #format_step()[$a^+ := a a^*$][
      #scale(automaton(
        (a0: (a1: $a$), a1: (a2: $eps$), a2: (a3: $eps$), a3: (a4: $a$), a4: (a3: $eps$)),
        final: ("a2", "a4"),
        style: (
          state: (radius: 0.2, fill: gris, stroke: black + 0.5pt, extrude: 0.66),
          // q5: (radius: 0.3),
          transition: (curve: 0.01, stroke: black + 0.5pt),
          a4-a3: (curve: 0.5),
        ),
      ))
    ]
    #format_step()[$(a union b^+)a^+b^+$][
      #scale(automaton(
        (
          u0: (q0: ($eps$), r0: $eps$),
          q0: (q1: $a$),
          q1: (a0: $eps$),
          r0: (r1: $b$),
          r1: (p0: $eps$),
          p0: (p1: $eps$),
          p1: (p2: $b$),
          p2: (p1: $eps$, a0: $eps$),
          a0: (a1: $a$),
          a1: (a2: $eps$),
          a2: (a3: $eps$, b0: ($eps$)),
          a3: (a4: $a$),
          a4: (a3: $eps$, b0: ($eps$)),
          b0: (b1: $b$),
          b1: (b2: $eps$),
          b2: (b3: $eps$),
          b3: (b4: $b$),
          b4: (b3: $eps$),
        ),
        layout: (u0: (0, 0), q0: (1, -1), r0: (1, 1), a0: (4, -1), b0: (6.5, 1), rest: (rel: (1.2, 0))),
        final: ("b2", "b4"),
        style: (
          state: (radius: 0.2, fill: gris, stroke: black + 0.5pt, extrude: 0.66),
          // q5: (radius: 0.3),
          transition: (curve: 0.01, stroke: black + 0.5pt, angle: 0deg),
          p2-p1: (curve: 0.5, label: (dist: 0.2)),
          a4-a3: (curve: 0.5),
          b4-b3: (curve: 0.5),
          p2-a0: (curve: 0.5, label: (dist: 0.2, pos: 0.4)),
          a0-a1: (label: (dist: -0.32)),
          a4-b0: (curve: -0.5),
          u0-q0: (label: (dist: -0.33)),
        ),
      ))
    ]

]

#exercise[10 pts][
  Encuentra una ER que represente el lenguaje de todas las cadenas de 0's y 1's que no contienen la subcadena $110$
]

#exercise[10 pts][
  Convierte el siguiente AFND en AFNDGs y luego reducelo quitando un estado a la vez hasta obtener una ER.
  #align(
    center,
  )[
    #figure(
      finite.automaton(
        (q1: (q2: $eps$, q3: $a$), q2: (q1: $a$), q3: (q2: $a, b$, q3: "b")),
        initial: "q1",
        final: "q2",
        labels: (q1: $1$, q2: $2$, q3: $3$),
        layout: (q1: (0, 0), q2: (4, 0), q3: (2, -4)),
        style: (
          state: (fill: gris, extrude: 0.75), 
          transition: (angle: 0deg),
          q1-q3: (curve: 0, ), 
          q3-q2: (curve: 0, label:(dist: 0.40)), 
          q3-q3: (anchor: right), 
          
          ),
        
      ),
    )
  ]
]#exercise[20 pts][
  Da una GLC que genere el lenguaje
  $
    A = {a^i b^j c^k: "donde" i=j " o " j=k "con" i, j, k >= 0}.
  $
]#solution[

]#exercise[20 pts][
  Muestre que los LLCs son cerrados bajo operaciones regulares: union, concatenación y estrella de Kleen.
]<problem_6>

#proof[
  #let L1 = $L_1$
  #let L2 = $L_2$
  #let G1 = $G_1$
  #let G2 = $G_2$
  #let S1 = $S_1$
  #let S2 = $S_2$
  #let derivg = $attach(deriv, br: G)$
  #footnote[#show: apply_definitions
    Utilizaremos la notación $deriv$ de @Martin_2011 para derivación en GLCs. ]
  Sean $L_1$ y $L_2$ dos LLCs y sean $G_1 = (V_1, Sigma, R_1, S_1)$, $G_2 = (V_2, Sigma, R_2, S_2)$ las respectivas GLCs
  que los generan #footnote[Podemos suponer que $V_1 inter V_2 = emptyset$ y que $S1 != S2$ .].

  Primero probaremos que son cerrados bajo la _union_.
  Sea $S$ una variable distinta de $S_1$ y $S_2$ y consideremos la GLC $G = (V, Sigma, R, S)$, donde $V = V_1 union V_2 union {S}$ y $R = R_1 union R_2 union {S -> S_1 | S_2}$.
  Mostraremos que $L(G) = L_1 union L_2$. Sea $w in L_1 union L_2$, supongamos $w in L_1$ entonces como $L_1= L(G_1)$ tenemos que $S_1 deriv w$, luego, en $G$ tenemos que $S => S_1$ por lo cual se tiene que $S deriv w$, es decir, $w in L(G)$, de manera similar si $w in L_2$.
  Lo anterior nos dice que $L_1 union L_2 subset L(G)$. Ahora bien si $w in L(G)$ se cumple que $S deriv w$, luego, como la única _regla de sustitución_ en $G$ que contiene a $S$ es $S -> S_1 | S_2$,
  se tiene una de dos posibles _derivaciones_ $S => S_1 deriv w$ o $S => S_2 deriv w$, es decir $S_1 deriv w$ o $S_2 deriv w$ lo cual implica que $w in L_1$ o $w in L_2$, es decir $w in L_1 union L_2$. Como $w$ fue arbitrario tenemos que $L(G) subset L_1 union L_2$.
  Por lo anterior obtenemos que $L(G) = L_1 union L_2$.
  // en cualquier caso obtenemos que $S_i deriv w$ lo que implica que $w in L_i$

  Ahora probaremos que son cerrados bajo _concatenación_.
  Sea $S$ una variable distinta de $S_1$ y $S_2$ y consideremos la GLC $G = (V, Sigma, R, S)$, donde $V = V_1 union V_2 union {S}$ y $R = R_1 union R_2 union {S -> S_1 S_2}$. Mostraremos que $L(G) = L1 L2$.
  Sea $w in L1 L2$ entonces existen cadenas $x in L1$ y $y in L2$ tqs $w = x y$. Dado que $x in L1=L(G1)$ y $y in L2=L(G2)$ entonces $S1 deriv x$ y $S2 deriv y$. Notemos que:
  $
    S => S1 S2 deriv x S2 deriv x y = w,
  $
  por lo cual $S deriv w$, es decir, $w in L(G)$.
  Ahora bien, si $w in L(G)$ entonces $S deriv w$ y dado que la única _regla de sustitución_ de $G$ que contiene a $S$ es $S -> S1 S2$, se debe cumplir que $S => S1 S2 deriv w$,
  dado que $S1, S2$ son variables distintas y _no-terminales_ tenemos que existen derivaciones en $G$, $S1 derivg x$ y $S2 derivg y$ para algún $x, y in words$ tqs $w = x y$,
  ademas como $V_1 inter V_2 = emptyset$, las derivaciones a partir de $S_i$ en $G$ implican que son derivaciones a partir de $S_i$ en $G_i$ (pues son las únicas que contienen las variables $V_i$)
  es decir $S_1 attach(=>, tr: *, br: G1) x$ y $S_1 attach(=>, tr: *, br: G2) y$, lo cual implica que $x in L1$ y $y in L2$, y por tanto $w in L1 L2$, como queremos. Por lo anterior tenemos que $L(G) = L1 L2$.

  Por ultimo veamos que son cerrados bajo _estrella de Kleen_.
  Sea $S$ una variable distinta de $S1$ y consideremos la GLC $G = (V, Sigma, R, S)$, donde $V = V_1 union {S}$ y $R = R_1 union {S -> S S1 | eps}$.
  Mostraremos que $L(G) = L1^*$. Si $w in L1^*$ entonces $w in L(G1)^k$ para algún $k >=0$. Si $k=0$ entonces $w = eps$ y puede ser derivado en $G$ mediante $S => eps$,
  si $k>0$ entonces $w$ es derivable de $S1^k$ y $S1^k$ es derivable en $G$ mediante
  $
    S => S S1 => S S1 S1 => dots deriv S S1^k => S1^k,
  $
  por lo cual $S deriv w$, y asi obtenemos que $w in L(G)$ y por tanto $L1^* subset L(G)$. De manera similar, si $w in L(G)$ entonces $S deriv w$ y dado que el orden de sustitución no cambia la cadena final,
  podemos suponer que _derivamos por la izquierda_, es decir, en cada paso la variable mas a la izquierda es remplazada.
  Luego, dadas las reglas de sustitución que contienen a $S$ es claro que en la derivación de $w$ en algún momento se tuvo que pasar por 
  $
    S => S S1 => S S1 S1 => dots deriv S S1^k => S1^k deriv w,
  $
  para algún $k >=0$, y como las únicas reglas de substitution que contienen a $S1$ son las de $R_1$ tenemos que $S1^k deriv w$ en $L(G1)^k$ y por tanto $x in L(G1)^k=L1^k subset L1^*$, en consecuencia $L(G) subset L1^*$. Por lo anterior concluimos que $L(G) = L1^*$ como queremos.
  // sea $k$  dicha cota, entonces se tiene que
  // no necesariamente esta en S1^k
]

#exercise[20 pts][
  Sea *B* el lenguaje de todas las cadenas palindromicas en ${0, 1}$ que contienen la misma cantidad de 0's que de 1's.
  Muestre que *B* no es libre de contexto.
]#bibliography("../../biblio.yml")