# RaiSE Kata: Generación de Documento de Diseño Técnico (L1-07)

**ID**: L1-07
**Nombre**: Generación de Documento de Diseño Técnico
**Descripción**: Guía el proceso estructurado para generar un documento de diseño técnico para una nueva funcionalidad o Feature, asegurando que se analicen los requisitos, el código existente y las dependencias antes de sintetizar el diseño. Esta Kata está diseñada para evitar fallos por timeouts o análisis demasiado amplios, dividiendo la tarea en pasos granulares.
**Objetivo**:
    *   Proporcionar un flujo de trabajo claro y robusto para la creación de documentos de diseño técnico.
    *   Asegurar que el diseño se base en un análisis exhaustivo de los requisitos y el contexto técnico existente.
    *   Minimizar fallos y aumentar la fiabilidad en la generación de documentos complejos.
**Dependencias**:
    *   `L0-01: Meta-Kata de Desarrollo`
    *   Requisitos de usuario (Historias de Usuario, especificaciones).
    *   Acceso al código fuente del proyecto.
**Reglas Cursor Relacionadas**:
    *   Reglas de documentación técnica y estándares de diseño arquitectónico.

---

**Contexto:** El diseño técnico es un paso crucial antes de la implementación. Esta Kata desglosa un proceso complejo en fases manejables.

**Pasos del Kata (Practicante y Asistente RaiSE):**

### 1. Consolidar Requisitos

*   **Propósito:** Entender el "qué" y el "por qué" de la funcionalidad a partir de la documentación proporcionada.
*   **Instrucción (Practicante):** "Analiza las siguientes historias de usuario y documentos de requisitos: `[ruta/a/HU-001.md]`, `[ruta/a/HU-002.md]`, etc. Sintetiza un resumen claro de los requisitos funcionales y no funcionales."
*   **Acción (Asistente):**
    *   Lee todos los documentos de requisitos proporcionados.
    *   Extrae y consolida los requisitos clave en un resumen estructurado.
    *   **Ejemplo de Salida (Asistente):** "Requisitos Consolidados para [Nombre de la Funcionalidad]:\n-   **Funcionales:** Registro de nuevos asociados, Validación de CURP, Creación de perfil inicial.\n-   **No Funcionales:** Alta disponibilidad, Baja latencia, Seguridad de datos (GDPR)."
*   **Validación (Practicante):** Revisa el resumen de requisitos y lo aprueba, asegurando que la comprensión del Asistente sea completa y correcta.

### 2. Identificar Componentes Clave del Código Existente

*   **Propósito:** Comprender el estado actual del sistema para promover la reutilización, realizando búsquedas acotadas y seguras.
*   **Instrucción (Practicante):** "Basado en los requisitos, necesito que identifiques componentes de código relevantes. **En lugar de una búsqueda amplia**, realiza búsquedas dirigidas. Empieza buscando la clase `CreateAssociateCommand` dentro del directorio `src/Application`."
*   **Acción (Asistente):**
    *   Usa `grep_search` con parámetros específicos y acotados (ej. `query: "CreateAssociateCommand"`, `include_pattern: "*.cs"`, `path: "src/Application"`).
    *   Lista los componentes encontrados y sugiere el siguiente paso de análisis.
    *   **Ejemplo de Salida (Asistente):** "Componente encontrado: `src/Application/Commands/CreateAssociateCommand.cs`. De su análisis, veo que es manejado por `CreateAssociateCommandHandler`. Ahora procederé a buscar ese manejador."
*   **Validación (Practicante):** Guía y valida el proceso de descubrimiento paso a paso. "Correcto. Ahora analiza las dependencias de `CreateAssociateCommandHandler`."

### 3. Mapear Dependencias Externas

*   **Propósito:** Entender las interacciones con otros servicios o sistemas a través de sus contratos.
*   **Instrucción (Practicante):** "El análisis de código muestra una dependencia con un servicio externo de 'Perfiles'. Por favor, localiza y analiza el archivo `.proto` correspondiente a `ProfileService` en el directorio `src/Protos`."
*   **Acción (Asistente):**
    *   Usa `read_file` para leer el archivo de contrato especificado (ej. `src/Protos/profile_v1.proto`).
    *   Resume las operaciones (RPCs) y los mensajes (estructuras de datos) relevantes para la funcionalidad actual.
    *   **Ejemplo de Salida (Asistente):** "Dependencia Externa Identificada: `profile_v1.proto`\n-   **Servicio:** `ProfileService`\n-   **Operación Relevante:** `rpc GetProfile(GetProfileRequest) returns (GetProfileResponse);`\n-   **Estructura de Datos:** `message ProfileData { ... }`"
*   **Validación (Practicante):** Confirma la relevancia de la dependencia y sus operaciones para el diseño.

### 4. Proponer Arquitectura y Flujo

*   **Propósito:** Esbozar la solución de alto nivel uniendo toda la información recopilada.
*   **Instrucción (Practicante):** "Con la información de requisitos, componentes existentes y dependencias, propón una arquitectura de alto nivel y un flujo de datos para la nueva funcionalidad. Incluye un diagrama de secuencia Mermaid."
*   **Acción (Asistente):**
    *   Sintetiza toda la información recopilada.
    *   Propone un diseño (ej. componentes nuevos/modificados, interacciones).
    *   Genera un diagrama Mermaid (`sequenceDiagram` es ideal aquí) y una descripción textual del flujo.
    *   **Ejemplo de Salida (Asistente):**
        ```mermaid
        sequenceDiagram
            participant Cliente
            participant AssociateController
            participant CreateAssociateCommandHandler
            participant ProfileService
            participant RegistrationRepository

            Cliente->>AssociateController: POST /api/registration/Associate
            AssociateController->>CreateAssociateCommandHandler: Ejecuta CreateAssociateCommand
            CreateAssociateCommandHandler->>ProfileService: GetProfile(request)
            ProfileService-->>CreateAssociateCommandHandler: Devuelve perfil existente o nulo
            CreateAssociateCommandHandler->>RegistrationRepository: Guardar nuevo asociado
            RegistrationRepository-->>CreateAssociateCommandHandler: Confirmación
            CreateAssociateCommandHandler-->>Cliente: Resultado
        ```
*   **Validación (Practicante):** Revisa la arquitectura y el flujo propuestos. "El flujo es correcto. Procede."

### 5. Borrador del Documento de Diseño Técnico

*   **Propósito:** Compilar toda la información en un documento de diseño técnico formal.
*   **Instrucción (Practicante):** "Excelente. Ahora, genera el borrador completo del documento de diseño técnico usando la plantilla `@tech_design.md`. Integra todas las secciones que hemos validado: Requisitos Consolidados, Análisis de Componentes, Dependencias Externas, y la Arquitectura y Flujo propuestos."
*   **Acción (Asistente):**
    *   Combina toda la información de los pasos anteriores en un solo documento Markdown.
    *   Asegura una estructura lógica, una redacción clara y la inserción correcta del diagrama.
    *   Presenta el contenido completo del archivo para revisión final.
*   **Validación (Practicante):** Revisa el documento completo y da la aprobación final.

---

**Resultado Esperado:**

*   Un documento de diseño técnico (`.md`) completo y estructurado, que cubra los requisitos, el análisis de código existente, las dependencias y la propuesta de arquitectura y flujo para la nueva funcionalidad.
*   El documento sirve como una base sólida para la planificación de la implementación a nivel de Historias de Usuario (usando `L1-04`).

**Principios RaiSE Reforzados:**

*   **Diseño Precede al Código (Design First):** Enfatiza un análisis profundo antes de cualquier implementación.
*   **Explicabilidad Inherente (Inherent Explicability):** El proceso conduce a un documento detallado que explica la solución.
*   **Resiliencia:** Un proceso más estructurado y granular reduce la probabilidad de fallos por falta de contexto o por acciones demasiado amplias. 