# volumen_overhead

`Docker-origami` existe porque repetia siempre la misma secuencia antes de archivar o mover un proyecto: snapshot, limpieza, git, compilacion, compresion. En vez de fingir que eran cinco herramientas separadas, las meti en un solo flujo.

## Que problema queria quitarme

- basura de metadatos,
- carpetas de trabajo sin versionar,
- proyectos que compilan en una maquina y en otra no,
- empaquetados manuales hechos deprisa y mal.

## Por que esta tan parametrizado

Porque cada proyecto pide una combinacion distinta de Git, Docker, compilacion y compresion. La desventaja es evidente: hay mas variables de entorno de las que me gustaria. La ventaja es que el mismo esqueleto me sirve para varios tipos de entrega.

## Lo que hace bien

- preparar un arbol antes de distribuirlo,
- automatizar snapshots,
- dejar el proyecto comprimido y con menos ruido.

## Deuda honesta

- es mejor para empaquetado y cierre que para desarrollo diario,
- si no sabes exactamente que quieres automatizar, tanta variable confunde,
- la parte mas valiosa es la disciplina del flujo, no el "framework" en si.
