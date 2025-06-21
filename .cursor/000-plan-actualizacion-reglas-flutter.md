# Plan de Actualización de Reglas Cursor para facturamovilapp (Flutter)

## 1. Propósito y Requisitos Previos

**Propósito**: Alinear el conjunto de reglas de Cursor (`.cursor/rules/`) con la documentación arquitectónica oficial del frontend Flutter, ubicada en `.raise/docs/architecture/`. El objetivo es capacitar al asistente de IA para que genere, analice y refactorice código Dart/Flutter de manera consistente, idiomática y alineada con los patrones establecidos en el proyecto.

**Requisitos Previos**: Se ha observado que algunos documentos de arquitectura clave (como `02_GESTION_DE_ESTADO_Y_FLUJO_DE_DATOS.md` y `06_CONVENCIONES_Y_GUIAS_DE_ESTILO.md`) podrían no contener toda la información necesaria. Antes de ejecutar las fases correspondientes de este plan, es **imprescindible** verificar y, si es necesario, completar estos documentos con la información arquitectónica relevante.

## 2. Metodología

El plan se ejecutará en fases. Cada fase se centra en un aspecto de la arquitectura documentada. Se realizará una auditoría de las reglas existentes, se eliminarán o archivarán las que no apliquen al frontend de Flutter, y se crearán o actualizarán reglas específicas basadas en la documentación.

---

## 3. Fases del Plan

### Fase 0: Auditoría y Organización Inicial

*   **Tarea**: Analizar todas las reglas existentes en `.cursor/rules/`.
*   **Acciones**:
    1.  **Identificar Reglas de Backend**: Agrupar todas las reglas que aplican exclusivamente al backend (JPA, SpringBoot, Zuul, Shedlock, etc.).
    2.  **Reorganizar Reglas de Backend**: Para evitar que se apliquen incorrectamente al código Flutter, se recomienda renombrar estas reglas con un prefijo `backend-` (ej. `backend-101-arquitectura-springboot.mdc`). Sus `globs` deberán ser revisados para asegurar que solo apunten a archivos de backend (ej. `**/*.java`) y no a código Dart.
    3.  **Identificar Reglas de Frontend**: Localizar las reglas existentes para Flutter (`201-arquitectura-frontend-flutter.mdc`, `205-gestion-estado-provider.mdc`, `220-convenciones-nomenclatura-dart.mdc`) para su revisión y actualización en las fases posteriores.
    4.  **Validar Reglas Generales/Meta**: Las reglas de propósito general (Docker, K8s, gestión de reglas) se mantendrán, asegurando que sus `globs` sean correctos.

### Fase 1: Estructura, Estilo y Convenciones

*   **Fuentes Principales**: `01_ESTRUCTURA_Y_CAPAS.md`, `06_CONVENCIONES_Y_GUIAS_DE_ESTILO.md`
*   **Acciones**:
    1.  **Revisar/Actualizar `201-arquitectura-frontend-flutter.mdc`**:
        *   **Contenido**: Debe reflejar fielmente la estructura de directorios (`screens`, `widgets`, `providers`, `services`, `models`, `router`, `themes`) y la responsabilidad de cada capa.
        *   **Anti-Patrón**: Añadir una sección específica que prohíba explícitamente el uso del directorio `librerias/` para nuevas dependencias, explicando los riesgos de mantenibilidad y seguridad.
    2.  **Revisar/Actualizar `220-convenciones-nomenclatura-dart.mdc`**:
        *   **Contenido**: Codificar las convenciones de nomenclatura para archivos (`snake_case.dart`), clases (`PascalCase`), variables (`camelCase`) y los sufijos de clase obligatorios (`*Screen`, `*Widget`, `*Provider`, `*Service`).
        *   **Estilo**: Forzar la adherencia a `Effective Dart` y el uso de `///` para la documentación DartDoc.

### Fase 2: Gestión de Estado con Provider

*   **Fuente Principal**: `02_GESTION_DE_ESTADO_Y_FLUJO_DE_DATOS.md`
*   **Acciones**:
    1.  **Revisar/Actualizar `205-gestion-estado-provider.mdc`**:
        *   **Contenido**: Detallar el uso preferente de los tipos de `Provider` (`ChangeNotifierProvider`, `FutureProvider`, etc.) y sus casos de uso.
        *   **Flujo de Datos**: Incluir un ejemplo del flujo de datos canónico: Interacción del usuario en `Widget` -> Llama a método en `Provider` -> `Provider` usa un `Service` -> `Provider` actualiza estado y notifica `listeners`.
        *   **Buenas Prácticas**: Añadir reglas para fomentar la cohesión y la responsabilidad única en los `Providers`, evitando que se conviertan en clases monolíticas.

### Fase 3: Capa de Datos y Seguridad del Cliente

*   **Fuente Principal**: `03_COMUNICACION_API_Y_SEGURIDAD_CLIENTE.md`
*   **Acciones**:
    1.  **Crear Nueva Regla `230-capa-servicios-http.mdc`**:
        *   **Propósito**: Estandarizar la comunicación con el backend.
        *   **Contenido**: Definir la capa de `Services` como Repositorios que abstraen las llamadas a la API. Establecer el uso de la librería `http`. Implementar un patrón `try-catch` estandarizado para el manejo de errores. Referenciar el interceptor `auth_interceptor.dart` como mecanismo para la inyección automática de tokens.
    2.  **Crear Nueva Regla `410-seguridad-cliente-flutter.mdc`**:
        *   **Propósito**: Establecer guías de seguridad en el lado del cliente.
        *   **Contenido**: Obligar el uso de `flutter_secure_storage` para cualquier dato sensible, especialmente tokens JWT. Guiar sobre la implementación de autenticación biométrica con `local_auth`.

### Fase 4: Funcionalidades Críticas y Calidad

*   **Fuentes Principales**: `04_FUNCIONALIDADES_CRITICAS.md`, `05_ESTRATEGIAS_DE_CALIDAD_Y_PRUEBAS.md`
*   **Acciones**:
    1.  **Crear Nueva Regla `310-componente-firma-electronica.mdc`**:
        *   **Propósito**: Guiar el desarrollo y mantenimiento del componente de firma.
        *   **Contenido**: Mencionar las librerías clave (`pointycastle`, `asn1lib`) y establecer como regla crítica que las claves privadas NUNCA deben ser almacenadas de forma persistente en el dispositivo.
    2.  **Crear Nueva Regla `601-estrategia-pruebas-flutter.mdc`**:
        *   **Propósito**: Fomentar una cultura de calidad y testing.
        *   **Contenido**: Describir la pirámide de pruebas del proyecto. Dar guías para escribir pruebas unitarias (`providers`, `services`), de widgets y de integración. Especificar el uso de `flutter_test` y `mockito` para mocking. Referenciar la importancia del archivo `analysis_options.yaml` y la necesidad de mantener un código sin advertencias del linter.

## 4. Resultado Esperado

Al finalizar la ejecución de este plan, el directorio `.cursor/rules/` contendrá un conjunto de reglas actualizado, bien organizado y específico para el desarrollo frontend con Flutter. Esto permitirá al asistente de IA operar con máxima eficiencia y alineación con la arquitectura y estándares de calidad del proyecto. 