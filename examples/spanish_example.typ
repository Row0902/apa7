#import "../src/lib.typ": apa7, apa-table, apa-figure, apa-appendix

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

La cita en bloque se utiliza para citas textuales de 40 palabras o más:

#quote(block: true)[
  Las citas textuales que superan las cuarenta palabras se estructuran como citas en bloque.
  En la séptima edición de las Normas APA en español, el bloque no utiliza comillas, mantiene
  el interlineado doble del resto del documento y se desplaza con una sangría uniforme de
  1.27 centímetros desde el margen izquierdo del texto principal.
]

== Resultados Empíricos

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
