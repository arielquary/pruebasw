# Plan de Documentación de Arquitectura para `facturamovilapp`

## 1. Propósito y Audiencia

**Propósito**: Crear y mantener una base de conocimiento arquitectónico viva y precisa para la aplicación `facturamovilapp`. Esta documentación es la "única fuente de verdad" (`single source of truth`) sobre la estructura, patrones y convenciones del frontend. Su objetivo principal es habilitar un desarrollo ágil, consistente y de alta calidad, tanto para desarrolladores humanos como para agentes de IA avanzados. Este "corpus" documental es la base para que los agentes IA puedan analizar, diseñar, implementar y refactorizar código de manera autónoma y alineada con la arquitectura existente.

**Audiencia Principal**:
*   **Agentes de IA (Gemini 2.5 Pro y Futuros)**: La audiencia primaria. La documentación debe ser estructurada, detallada y explícita para maximizar su comprensión y utilidad en tareas de generación y análisis de código.
*   **Desarrolladores (Nuevos y Existentes)**: Para entender rápidamente la arquitectura, seguir los patrones establecidos y contribuir eficazmente al proyecto.
*   **Arquitectos de Software**: Para evaluar la salud de la arquitectura, identificar deuda técnica y tomar decisiones estratégicas sobre su evolución.
*   **Equipo de QA**: Para entender los flujos de la aplicación y diseñar planes de prueba más efectivos.

## 2. Proceso de Mantenimiento y Ejecución Regular

Esta no es una documentación estática. Se mantendrá viva a través de un proceso continuo:
1.  **Actualización como Parte del "Definition of Done" (DoD)**: Cualquier nueva funcionalidad, cambio en la arquitectura (ej. refactorización de un `provider`) o adición de una dependencia significativa debe incluir la actualización de la documentación correspondiente como parte de sus criterios de aceptación.
2.  **Revisión Arquitectónica Periódica**: Se ejecutará un análisis completo de la arquitectura de forma trimestral, utilizando agentes IA para comparar el estado actual del código con la documentación existente y generar un reporte de desviaciones y sugerencias de actualización.
3.  **Onboarding y Feedback**: La documentación será la pieza central del proceso de `onboarding`. El feedback de los nuevos desarrolladores se utilizará para mejorar la claridad y completitud de los documentos.

## 3. Estructura de la Documentación

La documentación se organizará en una serie de archivos Markdown dentro de `.raise/docs/architecture/`, diseñados para ser consumidos tanto por humanos como por máquinas.

```
facturamovilapp/
└── .raise/
    └── docs/
        └── architecture/
            ├── 00_ARQUITECTURA_FLUTTER_GENERAL.md
            ├── 01_ESTRUCTURA_Y_CAPAS.md
            ├── 02_GESTION_DE_ESTADO_Y_FLUJO_DE_DATOS.md
            ├── 03_COMUNICACION_API_Y_SEGURIDAD_CLIENTE.md
            ├── 04_FUNCIONALIDADES_CRITICAS.md
            ├── 05_ESTRATEGIAS_DE_CALIDAD_Y_PRUEBAS.md
            └── 06_CONVENCIONES_Y_GUIAS_DE_ESTILO.md
```

---

## 4. Contenido Detallado por Documento

### 4.1. `00_ARQUITECTURA_FLUTTER_GENERAL.md`
*Punto de partida para entender el "qué" y el "porqué".*

*   **Visión General**: Describe el propósito de la app `Factura SAT Móvil` y sus objetivos de negocio.
*   **Principios Arquitectónicos**: Detalla los pilares del diseño: `Provider` para estado, arquitectura por capas, seguridad en el cliente, y responsabilidades claras.
*   **Diagrama de Contexto (C4 Nivel 1)**: Diagrama (Mermaid.js) mostrando la app, el usuario (Contribuyente), y los sistemas con los que interactúa (API Gateway, Firebase, Servicios del Dispositivo).
*   **Glosario de Términos**: Definiciones de `Provider`, `Widget`, `Screen`, `Service`, `CSD`, `Firma`, etc.
*   **Índice de Documentación**: Enlaces al resto de los documentos.

### 4.2. `01_ESTRUCTURA_Y_CAPAS.md`
*El mapa del código base.*

*   **Diagrama de Capas**: Un diagrama mostrando la separación entre Presentación, Lógica de Negocio/Estado, Servicios y Datos.
*   **Análisis del Directorio `lib/`**: Descripción detallada de la responsabilidad de cada directorio principal:
    *   `screens`: Pantallas completas, organizadas por feature.
    *   `widgets`: Componentes de UI reutilizables y genéricos.
    *   `providers`: Lógica de estado y de negocio.
    *   `services`: Abstracción de las llamadas a la API. Actúan como Repositorios.
    *   `models`: Clases de datos (DTOs del cliente).
    *   `helpers`: Funciones de utilidad sin estado.
    *   `router`: Configuración centralizada de la navegación.
    *   `themes`: Estilos y temas visuales.
*   **Patrón de Anti-patrón `librerias/`**: Una sección dedicada a explicar por qué existe este directorio, los riesgos que implica (mantenibilidad, seguridad) y el plan para eliminarlo.

### 4.3. `02_GESTION_DE_ESTADO_Y_FLUJO_DE_DATOS.md`
*El corazón de la lógica reactiva de la app.*

*   **Patrón de Gestión de Estado: `Provider`**:
    *   Explicación de por qué se eligió `Provider`.
    *   Tipos de `Provider` utilizados (`ChangeNotifierProvider`, `FutureProvider`, etc.) y cuándo usar cada uno.
*   **Diagrama de Flujo de Datos**: Un diagrama de secuencia (Mermaid.js) mostrando un flujo típico:
    1.  Usuario interactúa con un `Widget` en una `Screen`.
    2.  Se llama a una función en el `Provider` correspondiente.
    3.  El `Provider` llama a un `Service` para obtener/enviar datos.
    4.  El `Service` realiza la llamada HTTP.
    5.  El `Provider` actualiza su estado con la respuesta.
    6.  Se notifica a los `listeners` (widgets) que reconstruyan su UI.
*   **Guía para la Creación de `Providers`**: Reglas para evitar la proliferación excesiva de providers, sugiriendo cohesión y responsabilidad única.

### 4.4. `03_COMUNICACION_API_Y_SEGURIDAD_CLIENTE.md`
*Cómo la app habla con el mundo y se protege.*

*   **Contrato con el Backend**:
    *   URL del API Gateway.
    *   Versión de la API.
    *   Estructura general de las respuestas (JSON, formato de errores).
*   **Flujo de Autenticación JWT**:
    *   Diagrama de secuencia del login y obtención del token.
    *   Almacenamiento seguro del token usando `flutter_secure_storage`.
*   **Manejo de Peticiones**:
    *   Uso de la librería `http`.
    *   Rol del `auth_interceptor.dart` para inyectar automáticamente el `Bearer Token`.
*   **Seguridad en el Cliente**:
    *   Uso de `local_auth` para biometría.
    *   Análisis de la ofuscación de código (R8/ProGuard en Android).

### 4.5. `04_FUNCIONALIDADES_CRITICAS.md`
*Documentación profunda de las partes más complejas y riesgosas.*

*   **Componente de Firma Electrónica (`componente_firma`)**:
    *   **Propósito**: Generar la firma del CFDI en el dispositivo del cliente.
    *   **Librerías Clave**: `pointycastle`, `asn1lib`, `basic_utils`. Explicar el rol de cada una.
    *   **Diagrama de Flujo**: Pasos detallados desde que el usuario selecciona su CSD hasta que se genera la cadena de firma.
    *   **Manejo de Claves**: Cómo y dónde se cargan las claves privadas. Garantizar que nunca se almacenan de forma persistente.
*   **Escáner de Códigos QR/Barras**:
    *   Librería utilizada (`flutter_barcode_scanner`).
    *   Motivo de la modificación local (si aplica, como el caso de la "Ñ").
*   **Notificaciones Push (Firebase)**:
    *   Configuración en `main.dart`.
    *   Rol de `push_notifications_service.dart`.
    *   Tipos de notificaciones y cómo se manejan al ser recibidas (en foreground y background).

### 4.6. `05_ESTRATEGIAS_DE_CALIDAD_Y_PRUEBAS.md`
*El plan para asegurar que el software funciona y es mantenible.*

*   **Visión de Pruebas**: Describe la pirámide de pruebas objetivo para el proyecto.
*   **Estrategia de Pruebas Unitarias**:
    *   **Frameworks**: `flutter_test`.
    *   **Objetivo**: Probar la lógica en `providers`, `services` y `helpers` de forma aislada.
    *   **Mocking**: Uso de `mockito` o similar para mockear dependencias (ej. `http.Client`).
*   **Estrategia de Pruebas de Widgets**:
    *   **Objetivo**: Probar componentes de UI (`widgets`) de forma aislada.
*   **Estrategia de Pruebas de Integración**:
    *   **Objetivo**: Probar flujos completos de features (ej. login, llenado y vista previa de una factura).
*   **Análisis Estático y Linting**:
    *   Configuración del `analysis_options.yaml`.
    *   Reglas de linter personalizadas o importantes.
*   **Logging**:
    *   Estrategia de logging para desarrollo (`debugPrint`) y producción (integración con un servicio como Crashlytics/Sentry).

### 4.7. `06_CONVENCIONES_Y_GUIAS_DE_ESTILO.md`
*El "libro de estilo" para codificar.*

*   **Convenciones de Nomenclatura**:
    *   Archivos: `snake_case.dart`.
    *   Clases, Enums, Typedefs: `PascalCase`.
    *   Variables, constantes, métodos: `camelCase`.
    *   Sufijos: `*Screen`, `*Widget`, `*Provider`, `*Service`, `*Model`.
*   **Guía de Estilo**: Adherencia a los principios de [Effective Dart](https://dart.dev/guides/language/effective-dart).
*   **Gestión de Dependencias (`pubspec.yaml`)**:
    *   Proceso para agregar una nueva dependencia.
    *   Prohibición explícita de añadir nuevas dependencias locales en `librerias/`.
*   **Manejo de Errores**: Patrón `try-catch` en la capa de servicios y cómo propagar los errores a la UI para mostrarlos al usuario.
*   **Comentarios y Documentación de Código**: Estándar para comentarios (usar `///` para DartDoc). 