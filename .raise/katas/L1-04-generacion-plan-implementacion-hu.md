# RaiSE Kata: Generación de Plan de Implementación Detallado por HU (L1-04)

**ID**: L1-04
**Nombre**: Generación de Plan de Implementación Detallado por Historia de Usuario
**Descripción**: Guía el proceso para crear un plan de implementación detallado (en formato checklist) para una Historia de Usuario (HU) específica, a partir de su plan técnico de alto nivel (si existe) y sus Criterios de Aceptación (ACs). Este plan detallado servirá de base para la ejecución de la HU, referenciando Katas L2 y L3.
**Objetivo**:
    *   Estandarizar la creación de planes de implementación detallados para HUs.
    *   Asegurar que los planes cubran todos los aspectos necesarios: preparación, diseño, desarrollo de componentes, pruebas unitarias, integración, pruebas de aceptación y documentación.
    *   Facilitar la estimación y el seguimiento del progreso de la HU.
    *   Establecer cómo el plan de implementación detallado debe referenciar Katas L2 (Componentes) y L3 (Técnicas) para la construcción de elementos específicos.
**Dependencias**:
    *   `L0-01: Meta-Kata de Desarrollo`
    *   Historia de Usuario (HU) definida con Criterios de Aceptación (ACs) claros (idealmente en Gherkin).
    *   (Opcional pero recomendado) Plan Técnico de Alto Nivel para la HU.
**Reglas Cursor Relacionadas**:
    *   `010-raise-methodology-overview.mdc`
    *   Reglas de documentación relevantes para planes y checklists.

---

**Pasos del Kata (Practicante y Asistente RaiSE):**

**0. Verificación y Análisis de Brechas (Paso Previo Obligatorio):**
    *   **Propósito:** Asegurar que el plan se base en la realidad del código y no únicamente en la documentación, que puede estar desactualizada.
    *   **Instrucción (Practicante):** "Antes de planificar, debemos verificar las suposiciones del diseño técnico contra el código fuente actual. Identifica las principales entidades, DTOs y comandos mencionados en el diseño."
    *   **Acción (Asistente):**
        *   Lista las entidades clave del diseño técnico.
        *   Para cada entidad, usa `grep_search` o `read_file` para inspeccionar el archivo de código fuente correspondiente (ej. `Address.cs`, `CreateApplicantCommand.cs`).
        *   Compara las propiedades y métodos del diseño con el código real.
    *   **Instrucción (Practicante):** "Genera un 'Resumen de Análisis de Brechas' que destaque cualquier discrepancia encontrada."
    *   **Acción (Asistente):** Presenta un resumen. **Ejemplo:** "Análisis de Brechas: El diseño especifica añadir la propiedad `StreetName` a la entidad `Address`, pero el archivo `Address.cs` ya contiene esta propiedad. El plan de implementación se ajustará para reflejar esto."
    *   **Validación (Practicante):** "Resumen de brechas aprobado. Todo el plan de implementación subsiguiente debe basarse en este entendimiento verificado del código."

1.  **Inicio y Contexto (Practicante):**
    *   Identifica la HU a planificar (`[ID_JIRA]`), sus Criterios de Aceptación (ACs), y cualquier Plan Técnico de Alto Nivel existente (`[Plan Técnico Alto Nivel Path]`, si lo hay).
    *   **Instrucción:** "Con el análisis de brechas completo, vamos a generar el Plan de Implementación Detallado para la HU `[ID_JIRA]`. Por favor, revisa sus ACs [y su plan técnico en `[Plan Técnico Alto Nivel Path]` si existe], teniendo en cuenta nuestro análisis."

2.  **Análisis de Entradas (Asistente RAISE, instruido por Practicante):**
    *   **Acción (Asistente):** Lee los ACs de la HU y el plan técnico de alto nivel (si se proporcionó). Identifica los principales componentes, funcionalidades, flujos de datos y requisitos no funcionales descritos.
    *   **Instrucción (Practicante):** "Resume los principales módulos, componentes o funcionalidades que se deben desarrollar, modificar o integrar para satisfacer los ACs de la HU `[ID_JIRA]`."
    *   **Acción (Asistente):** Proporciona un resumen conciso de los elementos clave identificados.
    *   **Validación (Practicante):** Confirma el resumen y realiza ajustes si es necesario para asegurar una comprensión completa.

3.  **Estructuración del Plan de Implementación Detallado (Practicante y Asistente):**
    *   **Instrucción (Practicante):** "Crearemos el Plan de Implementación Detallado para `[ID_JIRA]` en el archivo `[Path HU]/IMPLEMENTATION_PLAN_[ID_JIRA].md`. Este plan debe seguir un formato de checklist Markdown y organizarse en fases estándar:
        1.  Preparación y Configuración
        2.  Diseño Detallado (si es necesario para componentes complejos)
        3.  Desarrollo de Componentes (desglosado por cada componente/módulo)
        4.  Pruebas Unitarias (por componente/módulo y escenario)
        5.  Integración de Componentes
        6.  Pruebas de Aceptación (mapeo a ACs Gherkin)
        7.  Documentación
        8.  Refinamiento y Revisión Final"
    *   **Acción (Asistente):** Genera una plantilla inicial para el archivo `[Path HU]/IMPLEMENTATION_PLAN_[ID_JIRA].md` con las secciones de fases mencionadas, usando formato de checklist Markdown (ej. `- [ ] Tarea`).
    *   **Validación (Practicante):** Revisa la estructura base del plan.

4.  **Desglose de Tareas de Desarrollo por Componente/Funcionalidad (Practicante y Asistente - Bucle por cada componente/funcionalidad principal):**
    *   **Instrucción (Practicante):** "Para el componente/funcionalidad `[Nombre del Componente/Funcionalidad identificado en el paso 2]`, vamos a detallar las tareas en el Plan de Implementación. Bajo 'Desarrollo de Componentes', incluye la creación/modificación de archivos, definición de interfaces/clases/funciones, implementación de la lógica central y manejo de errores. Importante: para cada tarea de desarrollo de un componente arquitectónico (entidad, caso de uso, repositorio, etc.), añade una referencia a la Kata L2 o L3 relevante que guiará su implementación específica."
    *   **Acción (Asistente):**
        *   Añade al checklist de `IMPLEMENTATION_PLAN_[ID_JIRA].md` las tareas detalladas para el componente/funcionalidad, bajo la sección "Desarrollo de Componentes".
        *   **Ejemplos de tareas con referencia a Katas:**
            *   `- [ ] Implementar la entidad 'NombreEntidad' (Ref: L2-02 Entidades de Dominio)`
            *   `- [ ] Definir la interfaz para 'INombreRepositorio' (Ref: L2-01 Interfaces de Dominio)`
            *   `- [ ] Desarrollar el caso de uso 'NombreCasoDeUso' (Ref: L2-03 Casos de Uso)`
            *   `- [ ] Implementar el 'NombreRepositorioImpl' (Ref: L2-05 Repositorios)`
            *   `- [ ] Crear ViewModel 'NombreViewModel' (Ref: L2-07 ViewModels)`
            *   `- [ ] Desarrollar Componente UI 'NombreComponenteUI' (Ref: L2-08 Componentes UI)`
            *   `- [ ] Aplicar patrones de validación para 'ModuloX' (Ref: L3-02 Validación)`
    *   **Validación (Practicante):** Revisa el desglose de tareas para el componente/funcionalidad actual, asegurando la correcta referenciación a las Katas L2/L3.

5.  **Desglose de Tareas de Pruebas Unitarias (Practicante y Asistente - Bucle por cada componente/funcionalidad):**
    *   **Instrucción (Practicante):** "Para el mismo componente/funcionalidad `[Nombre del Componente/Funcionalidad]`, detalla ahora las tareas para 'Pruebas Unitarias'. Considera los escenarios clave, casos límite y la verificación de la lógica interna. Las pruebas deben seguir los lineamientos de la Kata L3-05 (Testing Estratégico)."
    *   **Acción (Asistente):** Añade al checklist las tareas para pruebas unitarias, indicando la referencia a `L3-05`.
        *   `- [ ] Escribir pruebas unitarias para 'NombreEntidad' (escenarios: creación válida, validación de campos) (Ref: L3-05)`
    *   **Validación (Practicante):** Revisa las tareas de pruebas unitarias.

6.  **Desglose de Tareas de Integración (Practicante y Asistente):**
    *   **Instrucción (Practicante):** "Identifiquemos los puntos de integración entre los componentes desarrollados (ej. Caso de Uso llamando a Repositorio, ViewModel usando Caso de Uso). Añade las tareas correspondientes en la sección 'Integración de Componentes' del plan."
    *   **Acción (Asistente):** Añade las tareas de integración al checklist.
    *   **Validación (Practicante):** Revisa y valida las tareas de integración.

7.  **Mapeo de Criterios de Aceptación a Tareas de Prueba de Aceptación (Practicante y Asistente):**
    *   **Instrucción (Practicante):** "Para cada Criterio de Aceptación (AC) Gherkin de la HU `[ID_JIRA]`, añade una tarea de alto nivel en la sección 'Pruebas de Aceptación' del plan. Esta tarea indicará la necesidad de verificar dicho AC. La estrategia detallada para estas pruebas se guiará por la Kata L3-05 (Testing Estratégico)."
    *   **Acción (Asistente):** Añade ítems al checklist para cada AC Gherkin, ej. `- [ ] Verificar AC: [Given/When/Then del AC] (Estrategia guiada por L3-05 Testing Estratégico)`.
    *   **Validación (Practicante):** Confirma que todos los ACs estén cubiertos.

8.  **Definición de Tareas Generales (Practicante y Asistente):**
    *   **Instrucción (Practicante):** "Completemos el plan añadiendo tareas generales a las secciones de 'Preparación y Configuración' (ej. creación de rama, revisión de dependencias), 'Documentación' (ej. docstrings, README de módulo si aplica), y 'Refinamiento y Revisión Final' (ej. limpieza de código, revisión de pares)."
    *   **Acción (Asistente):** Añade estas tareas generales a las secciones correspondientes del checklist.
    *   **Validación (Practicante):** Revisa la completitud de las tareas generales.

9.  **Revisión y Finalización del Plan de Implementación Detallado (Practicante y Asistente):**
    *   **Instrucción (Practicante):** "Por favor, muéstrame el contenido completo del archivo `[Path HU]/IMPLEMENTATION_PLAN_[ID_JIRA].md` para una revisión final."
    *   **Acción (Asistente):** Presenta el plan de implementación detallado completo.
    *   **Validación (Practicante):** Revisa la claridad, completitud, consistencia y correcta referenciación a otras Katas. Realiza los ajustes finales necesarios.
    *   **Confirmación (Practicante):** "El Plan de Implementación Detallado para la HU `[ID_JIRA]` está completo y aprobado. Este plan ahora será la guía principal para la ejecución de la HU, utilizando la Kata `L1-03 Implementación de HU desde Plan` y las Katas L2/L3 referenciadas para cada tarea específica."

---

**Resultado Esperado:**

*   Un archivo `IMPLEMENTATION_PLAN_[ID_JIRA].md` creado en la ruta especificada, conteniendo un plan detallado en formato checklist.
*   El plan debe estar estructurado por fases y desglosar las tareas de desarrollo, pruebas, integración y documentación para la HU.
*   Las tareas de desarrollo de componentes deben incluir referencias explícitas a las Katas L2 y L3 relevantes que guiarán su implementación.
*   El plan está listo para ser utilizado como entrada para la Kata `L1-03 Implementación de HU desde Plan`.

**Principios RaiSE Reforzados:**

*   **Documentación Precede al Código (Documentation First):** El plan detallado es un artefacto de diseño clave.
*   **Desarrollo Guiado por Katas (Kata-Driven Development):** Esta kata guía la creación de un plan que, a su vez, referencia otras katas.
*   **Explicabilidad Inherente (Inherent Explicability):** El plan detallado hace explícito el proceso de implementación.
*   **Orquestación Humana, Asistencia IA:** El practicante define la estrategia y valida, mientras el asistente ayuda en la generación y estructuración del plan. 