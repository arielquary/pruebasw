# RaiSE Meta-Kata: Metodología de Desarrollo (L0-01)

## Objetivo

Establecer un marco metodológico para aplicar el sistema de katas RaiSE de manera efectiva durante el ciclo de desarrollo de software, definiendo cuándo y cómo seleccionar e implementar las katas específicas según el contexto del proyecto Jafra.

## Contexto/Setup Inicial

1. **Documentación Relacionada:**
   - Plan de Implementación y Seguimiento de RaiSE Katas
   - Reglas Cursor de RaiSE
   - Estructura de proyecto Jafra (Clean Architecture)

2. **Niveles de Katas Disponibles:**
   - **L0:** Meta-Katas (procesos orquestadores)
   - **L1:** Katas de Proceso (flujos end-to-end)
   - **L2:** Katas de Componente (implementaciones arquitectónicas específicas)
   - **L3:** Katas Técnicas (patrones técnicos reutilizables)

3. **Roles Involucrados:**
   - Desarrolladores
   - Arquitectos
   - Líderes técnicos
   - Facilitadores de kata-dojos

## Estructura de la Meta-Kata

### 1. Análisis del Contexto de Desarrollo

**Instrucción (Facilitador):** "Analicemos el contexto actual del desarrollo para determinar qué katas serían más aplicables."

**Acción (Asistente IA):**
   - Evaluar el tipo de trabajo a realizar según las siguientes categorías:
     - Nueva funcionalidad desde cero
     - Modificación de componente existente
     - Refactorización de código
     - Corrección de defectos
     - Análisis de requerimientos y planificación
   - Identificar las capas de la arquitectura involucradas
   - Considerar restricciones o requisitos especiales

**Ejemplo de Diálogo:**

```
Desarrollador: "Necesito implementar una nueva pantalla para mostrar el historial de pedidos de un cliente."

Asistente IA: "Analicemos este contexto:
- Es una nueva funcionalidad que involucra UI, presentación y acceso a datos
- Afecta a varias capas: presentación (ViewModel, componentes), dominio (casos de uso, entidades) y datos (repositorios)
- Probablemente requerirá manejo de operaciones asíncronas y tratamiento de errores

Basado en esto, podríamos aplicar diversas katas, centrándose primero en un enfoque de proceso end-to-end y luego en katas específicas para cada componente."
```

**Validación (Facilitador):** Confirmar que el análisis captura correctamente el contexto y restricciones.

### 2. Selección de Katas Aplicables

**Instrucción (Facilitador):** "Seleccionemos las katas más apropiadas para este contexto."

**Acción (Asistente IA):**
   - Proponer una ruta de aplicación de katas, priorizando según:
     - Nivel lógico (comenzar con L1, luego L2 y L3 según sea necesario)
     - Dependencias entre katas
     - Complejidad (comenzar con más simples)
   - Justificar la selección basándose en el análisis previo
   - Señalar prerrequisitos para aplicar las katas seleccionadas

**Ejemplo de Selección:**

```
Para implementar la pantalla de historial de pedidos, sugiero la siguiente ruta de katas:

1. L1-03: Implementación de HU desde Plan → Para tener un enfoque estructurado de la funcionalidad completa

Seguido de katas específicas para cada componente:
2. L2-01: Interfaces de Dominio → Para definir contratos de repositorio y entidades
3. L2-03: Casos de Uso → Para implementar la lógica de negocio de consulta de historial
4. L2-05: Repositorios → Para implementar el acceso a datos de pedidos
5. L2-07: ViewModels → Para conectar la UI con la lógica de negocio
6. L2-08: Componentes UI → Para implementar la interfaz visual

Katas técnicas de soporte:
7. L3-01: Modelado de Datos → Para estructurar la información de pedidos
8. L3-03: Patrones Async → Para manejar operaciones de carga y errores

Esta selección cubre todas las capas necesarias con un enfoque top-down.
```

**Validación (Facilitador):** Verificar que la selección de katas sea coherente con el contexto y las necesidades del desarrollo.

### 3. Planificación de Aplicación de Katas

**Instrucción (Facilitador):** "Definamos un plan concreto para aplicar estas katas en el desarrollo."

**Acción (Asistente IA):**
   - Establecer un orden de implementación considerando dependencias
   - Definir puntos de verificación para validar resultados
   - Proponer asignación de tiempo relativo para cada kata
   - Identificar posibles desafíos y cómo abordarlos

**Ejemplo de Plan:**

```
Plan de aplicación para la nueva pantalla de historial de pedidos:

Fase 1: Fundamentos (Día 1)
- Aplicar L1-03 (Implementación de HU desde Plan): 2 horas
  - Desglosar la HU en componentes técnicos
  - Identificar criterios de aceptación detallados
  - Punto de verificación: Documento de plan técnico validado con equipo

Fase 2: Capa de Dominio y Datos (Día 1-2)
- Aplicar L2-01 (Interfaces de Dominio): 1 hora
  - Definir IPedidoHistorialRepository e interfaces relacionadas
  - Punto de verificación: Interfaces revisadas y aprobadas
- Aplicar L3-01 (Modelado de Datos): 1 hora
  - Modelar entidades de pedido, estado y filtros
- Aplicar L2-03 (Casos de Uso): 2 horas
  - Implementar ConsultarHistorialPedidosUseCase
  - Punto de verificación: Tests unitarios del caso de uso
- Aplicar L2-05 (Repositorios): 2 horas
  - Implementar PedidoHistorialRepository
  - Punto de verificación: Tests de integración

Fase 3: Capa de Presentación (Día 2-3)
- Aplicar L2-07 (ViewModels): 2 horas
  - Crear useHistorialPedidosViewModel con estados y operaciones
  - Aplicar L3-03 (Patrones Async) durante esta implementación
  - Punto de verificación: Tests del ViewModel
- Aplicar L2-08 (Componentes UI): 3 horas
  - Implementar pantalla, componentes de filtro y lista de pedidos
  - Implementar manejo de estados de carga y error
  - Punto de verificación: Revisión visual y pruebas de interacción

Desafíos anticipados:
- Complejidad en filtros de historial → Preparar opciones simplificadas para MVP
- Potenciales problemas de rendimiento → Implementar paginación desde el inicio
```

**Validación (Facilitador):** Revisar que el plan sea realista, completo y considere adecuadamente las dependencias entre katas.

### 4. Ejecución Guiada de Katas

**Instrucción (Facilitador):** "Apliquemos la primera kata del plan siguiendo el formato establecido."

**Acción (Asistente IA):**
   - Iniciar la aplicación de la primera kata seleccionada
   - Guiar al desarrollador paso a paso según la estructura de la kata
   - Proporcionar ejemplos y patrones relevantes al contexto específico, citando siempre la Regla Cursor canónica (ej. Regla 210 para ViewModels) y usando ejemplos concisos en la kata para ilustrar el paso actual del proceso
   - Resolución colaborativa de dudas o adaptaciones necesarias

**Ejemplo de Ejecución Guiada:**

```
Comenzamos con L1-03: Implementación de HU desde Plan

Paso 1: Analizar la historia de usuario
- HU: "Como cliente, quiero ver mi historial de pedidos para dar seguimiento a mis compras anteriores"
- Criterios: Visualizar los últimos 12 meses, filtrar por estado, ver detalles de productos

Paso 2: Identificar componentes técnicos necesarios
- Repositorio: PedidoHistorialRepository
- Caso de uso: ConsultarHistorialPedidosUseCase
- ViewModel: useHistorialPedidosViewModel
- Componentes UI: HistorialPedidosScreen, PedidosList, PedidoFilterBar, PedidoDetailModal

Paso 3: Definir contratos de interfaz
[Se aplica el patrón de la kata L2-01 para definir interfaces...]

Paso 4: Establecer plan de pruebas
- Tests unitarios para caso de uso con diferentes filtros
- Tests de ViewModel simulando diferentes estados
- Tests de integración del repositorio
- Pruebas E2E de la funcionalidad completa
```

**Validación (Facilitador):** Verificar el progreso y adaptaciones realizadas durante la aplicación de la kata.

### 5. Revisión y Feedback

**Instrucción (Facilitador):** "Evaluemos los resultados de la aplicación de katas y recopilemos aprendizajes."

**Acción (Asistente IA):**
   - Facilitar revisión del código producido con las katas
   - Comparar con criterios de éxito establecidos en cada kata
   - Identificar oportunidades de mejora
   - Documentar adaptaciones o extensiones realizadas a las katas

**Ejemplo de Revisión:**

```
Resultados de la aplicación de katas para la pantalla de historial:

Fortalezas:
- Separación clara de responsabilidades entre capas
- Manejo consistente de errores y estados de carga
- Tests completos para cada componente

Oportunidades de mejora:
- La implementación de filtros podría simplificarse siguiendo mejor el patrón CQRS
- El ViewModel maneja demasiadas responsabilidades, podría dividirse

Adaptaciones a las katas:
- Extendimos L2-07 (ViewModel) para incluir manejo de paginación
- Combinamos aspectos de L3-03 y L3-05 para testing de operaciones asíncronas

Aprendizajes:
- Las katas funcionan mejor cuando se aplican iterativamente, refinando la implementación
- La combinación de katas técnicas con katas de componente produce mejor código
```

**Validación (Facilitador):** Obtener consensus sobre aprendizajes y mejoras para futuras aplicaciones de katas.

## Criterios de Éxito

Esta meta-kata se considera exitosamente aplicada cuando:

1. **Selección Acertada:** Las katas seleccionadas son adecuadas para el contexto específico de desarrollo
2. **Adaptabilidad:** El proceso se adapta a restricciones o requisitos especiales del proyecto
3. **Composición Efectiva:** Las katas se aplican en un orden lógico, respetando dependencias
4. **Resultados Consistentes:** El código resultante cumple con los estándares de arquitectura limpia
5. **Eficiencia Mejorada:** El proceso de desarrollo es más eficiente y predecible gracias a las katas
6. **Transferencia de Conocimiento:** El equipo desarrolla un entendimiento común de patrones y prácticas

## Antipatrones a Evitar

- **Aplicación Rígida:** Seguir las katas al pie de la letra sin adaptarlas al contexto
- **Sobrecarga de Katas:** Intentar aplicar demasiadas katas en un solo ciclo de desarrollo
- **Foco en la Forma sobre Función:** Priorizar seguir la kata por encima de resolver el problema real
- **Ignorar Restricciones:** No considerar limitaciones de tiempo o recursos al planificar katas
- **Silos de Conocimiento:** Permitir que solo algunos miembros del equipo dominen las katas
- **Katascopismo:** Perder la visión global del producto por enfocarse en katas específicas

## Adaptaciones Comunes

- **Kata Express:** Versión simplificada para desarrollos urgentes que mantiene los principios esenciales
- **Kata Híbrida:** Combinación de múltiples katas cuando las responsabilidades se superponen
- **Kata Exploratoria:** Versión más flexible para contextos de investigación o prueba de concepto
- **Kata de Refactorización:** Adaptación específica para mejorar código existente sin cambiar funcionalidad
- **Pair-Kata:** Adaptación para programación en parejas donde se alternan roles de guía y ejecutor

## Integración con Flujo de Trabajo

### En Planificación de Sprint

1. Revisar historias de usuario
2. Identificar katas aplicables por historia
3. Incluir tiempo para aplicación de katas en estimaciones
4. Preparar material de referencia necesario

### En Desarrollo Diario

1. Iniciar con selección de katas para la tarea del día
2. Aplicar katas siguiendo el orden planificado
3. Documentar adaptaciones o desafíos encontrados
4. Validar resultados según criterios de la kata

### En Revisión de Código

1. Verificar cumplimiento de patrones establecidos por las katas
2. Sugerir katas específicas para mejorar áreas débiles
3. Reconocer implementaciones ejemplares de katas

### En Retrospectiva

1. Evaluar efectividad de katas aplicadas
2. Identificar katas que requieren refinamiento
3. Proponer nuevas katas para necesidades emergentes
4. Ajustar proceso de aplicación de katas

## Recursos Adicionales

- **Guía de Decisión de Katas:** Árbol de decisión para seleccionar las katas más apropiadas
- **Plantillas de Adaptación:** Formatos para documentar adaptaciones a katas estándar
- **Métricas de Efectividad:** Indicadores para evaluar el impacto de las katas en la calidad y eficiencia
- **Biblioteca de Ejemplos:** Implementaciones de referencia de cada kata en el contexto de Jafra

## Ejemplo Completo: Desarrollo de Funcionalidad de Búsqueda

### Contexto
Implementar una funcionalidad de búsqueda avanzada de productos con filtros múltiples.

### Selección de Katas
1. **L1-04:** Generación de Planes Técnicos (planeación general)
2. **L2-01 + L2-02:** Interfaces y Entidades de Dominio (modelos de búsqueda)
3. **L2-03:** Casos de Uso (lógica de búsqueda)
4. **L2-05:** Repositorios (acceso a datos de productos)
5. **L3-03:** Patrones Async (manejo de búsqueda en tiempo real)
6. **L2-07:** ViewModels (estado y lógica de presentación)
7. **L2-08:** Componentes UI (interfaz de búsqueda)

### Plan de Aplicación
```
Día 1:
- [L1-04] Elaborar plan técnico detallado (2h)
- [L2-01 + L2-02] Diseñar interfaces de búsqueda y entidades (2h)
  • IProductoSearchRepository
  • SearchCriteria, SearchResult, y filtros

Día 2:
- [L2-03] Implementar BuscarProductosUseCase (3h)
  • Validación de criterios
  • Aplicación de reglas de negocio para búsqueda
- [L2-05] Implementar ProductoSearchRepository (3h)
  • Traducción de criterios a parámetros de API
  • Manejo de respuestas y errores

Día 3:
- [L3-03] Implementar patrones async para búsqueda (2h)
  • Debounce para búsqueda en tiempo real
  • Cancelación de búsquedas anteriores
- [L2-07] Implementar useProductoSearchViewModel (3h)
  • Estados de búsqueda y resultados
  • Transformación de datos para UI

Día 4:
- [L2-08] Implementar componentes UI (5h)
  • SearchBar con autocompletado
  • Filtros avanzados
  • Visualización de resultados con paginación
  • Manejo de estados vacíos y errores
```

### Revisión de Resultados
Verificación contra criterios de éxito de cada kata, con énfasis en:
- Rendimiento de búsqueda (tiempo de respuesta)
- Experiencia de usuario (facilidad de uso)
- Calidad del código (mantenibilidad)
- Cobertura de pruebas (robustez)

### Aprendizajes Documentados
```
• La implementación de debounce (L3-03) fue clave para optimizar llamadas al API
• Separar SearchCriteria de SearchParams (L2-01) facilitó la traducción entre capas
• El manejo de estados de búsqueda en ViewModel (L2-07) requirió más estados de los previstos
• Para próximas implementaciones, considerar separar resultados y filtros en ViewModels distintos
``` 