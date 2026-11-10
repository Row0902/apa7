#import "../src/lib.typ": (
  apa7,
  apa-table,
  apa-figure,
  apa-appendix,
  apa-stat,
  apa-mean,
  apa-t,
  apa-ci,
  apa-theorem,
  apa-definition,
  apa-proof,
  eq,
  deq,
  sen,
  tg,
  mcd,
)

#show: apa7.with(
  title: "Efectos de la Privación de Sueño en el Rendimiento Cognitivo",
  authors: (
    (name: "Carolina Sánchez", affiliation: "Universidad Nacional"),
    (name: "Carlos Pedraza", affiliation: "Universidad Nacional"),
    (name: "Joaquín Rueda", affiliation: "Universidad Nacional"),
  ),
  paper-type: "student",
  course: "PSIC 201: Metodología de la Investigación",
  instructor: "Dra. María Duarte",
  due-date: datetime(year: 2026, month: 11, day: 9),
  abstract: [
    Este estudio analiza el impacto de la restricción crónica del sueño sobre la memoria
    de trabajo y los tiempos de reacción en estudiantes universitarios. Los resultados
    sugieren una degradación estadísticamente significativa de la retención a corto plazo.
  ],
  keywords: ("Privación de sueño", "Memoria de trabajo", "Psicología cognitiva"),
  lang: "es",
)

= Introducción

La privación del sueño es un problema prevalente en el ámbito académico contemporáneo.
Siguiendo los modelos de memoria de trabajo de @baddeley1974, la capacidad ejecutiva
depende de ciclos de consolidación neural estables.

== Marco Teórico

#apa-definition(title: "Tiempo de Respuesta Efectivo", lang: "es")[
  Se define la variable #eq("T", $T$) como el tiempo en milisegundos transcurrido entre la presentación
  del estímulo visual y el registro de la respuesta motora.
]

#apa-theorem(title: "Invarianza de Carga", lang: "es")[
  Si la tasa de error es acotada, el incremento de la latencia media es monótono respecto a la privación.
]

#apa-proof(lang: "es")[
  La derivación se deduce aplicando las propiedades de monotonía sobre el modelo lineal.
  En análisis armónico asociado, el límite fundamental emplea la notación en español:
  #deq("Limite del seno de x sobre x cuando x tiende a cero es uno", $ lim_(x -> 0) (sen(x)) / x = 1 $)
]

La cita en bloque se utiliza para citas textuales de 40 palabras o más:

#quote(block: true)[
  Las citas textuales que superan las cuarenta palabras se estructuran como citas en bloque.
  En la séptima edición de las Normas APA en español, el bloque no utiliza comillas, mantiene
  el interlineado doble del resto del documento y se desplaza con una sangría uniforme de
  1.27 centímetros desde el margen izquierdo del texto principal.
]

== Resultados Empíricos

Una prueba _t_ de muestras independientes indicó que la capacidad de retención disminuyó
significativamente tras la privación (#apa-mean(64.8, sd: 7.1)) en comparación con la línea base
(#apa-mean(71.2, sd: 6.4)), #apa-t(48, -2.45, p: 0.018, d: -0.71), con un intervalo de confianza
de #apa-ci(-10.20, -1.20).

A continuación se presenta la tabla y figura correspondientes:

#apa-table(
  title: [Estadísticas Descriptivas de las Evaluaciones Cognitivas],
  columns: (2fr, 1fr, 1fr),
  header: ([*Dimensión*], [*Línea Base (_M_)*], [*Post-Prueba (_M_)*]),
  note: [Puntajes evaluados en escala normalizada de 0 a 100 puntos.],
  lang: "es",
  [Capacidad de Retención], [71.2 (6.4)], [64.8 (7.1)],
  [Atención Sostenida], [83.5 (5.2)], [72.3 (6.9)],
)

#apa-figure(
  rect(width: 100%, height: 60pt, fill: luma(245), stroke: 0.5pt + luma(180))[
    #align(center + horizon)[#text(size: 11pt, style: "italic")[Diagrama de Trayectorias]]
  ],
  title: [Modelo Predictivo del Desempeño Cognitivo],
  alt: "Diagrama causal que muestra los efectos directos de la privación de sueño",
  note: [Las flechas representan trayectorias causales directas. Nivel de significancia: _p_ < .05.],
  lang: "es",
)

#apa-appendix(title: [Instrumentos de Evaluación y Batería de Pruebas], lang: "es")[
  Este apéndice contiene la descripción detallada de las pruebas administradas.
]

#bibliography("sample.bib")
