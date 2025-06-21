# Plan Detallado para la Creación de Reglas de Cursor para `factura-movil`

## 1. Introducción y Objetivo

Este documento presenta un plan de trabajo detallado para la creación de un conjunto de reglas de Cursor (`.cursor/rules/*.mdc`) para el proyecto `factura-movil`. El objetivo es codificar las convenciones, patrones arquitectónicos y buenas prácticas identificadas en la documentación de arquitectura del proyecto.

Este proceso sigue los principios de RaiSE, utilizando un enfoque estructurado y por fases para asegurar que el asistente de IA genere código consistente, de alta calidad y alineado con los estándares del proyecto.

## 2. Estructura y Convenciones de las Reglas

Las reglas se crearán siguiendo una estructura modular y categorizada, inspirada en las mejores prácticas observadas. Se utilizará la siguiente convención de nomenclatura y numeración para gestionar el orden y la precedencia:

*   **`0xx-`**: Reglas Generales y Metodológicas.
*   **`1xx-`**: Reglas de Backend (Java, Spring Boot, Microservicios).
*   **`2xx-`**: Reglas de Frontend (Flutter, Dart).
*   **`3xx-`**: Reglas de Persistencia y Datos (PostgreSQL, JPA).
*   **`4xx-`**: Reglas de Seguridad y Autenticación.
*   **`5xx-`**: Reglas de Despliegue y Operaciones (DevOps).
*   **`9xx-`**: Meta-Reglas (gestión y precedencia).

Cada regla se definirá en su propio archivo `.mdc` con el frontmatter adecuado (`name`, `description`, `globs`, `priority`, `category`, `tags`).

## 3. Plan de Implementación por Fases

A continuación se presenta la checklist de reglas a crear, organizada en fases.

### Fase 1: Fundamentos y Reglas de Backend

Esta fase se centra en establecer las reglas fundamentales del proyecto y la capa de backend, que es la más compleja.

- [ ] **Crear `001-convenciones-generales.mdc`**:
    - **Propósito**: Definir convenciones de nomenclatura generales, principios SOLID, DRY, y buenas prácticas de calidad de código (comentarios, complejidad).
    - **Fuentes**: `07-CONVENCIONES-Y-BUENAS-PRACTICAS.md`.
    - **Globs**: `["**/*.java", "**/*.dart"]`

- [ ] **Crear `101-arquitectura-backend-springboot.mdc`**:
    - **Propósito**: Establecer las reglas para la estructura de proyectos Spring Boot, el uso de capas (repository, service, web.rest) y la configuración (`application.yml`).
    - **Fuentes**: `02-ARQUITECTURA-BACKEND-MICROSERVICIOS.md`.
    - **Globs**: `["944-*/pom.xml", "944-*/src/**/*.java"]`

- [ ] **Crear `105-patron-api-gateway-zuul.mdc`**:
    - **Propósito**: Reglas específicas para el desarrollo en el API Gateway (`944-ZuulFacMovil`), incluyendo la creación de filtros.
    - **Fuentes**: `02-ARQUITECTURA-BACKEND-MICROSERVICIOS.md`, `05-SEGURIDAD-Y-AUTENTICACION.md`.
    - **Globs**: `["944-ZuulFacMovil/src/**/*.java"]`

- [ ] **Crear `110-desarrollo-rest-controllers.mdc`**:
    - **Propósito**: Definir cómo crear controladores REST (`*Resource.java`), el uso obligatorio de DTOs y el manejo de respuestas HTTP.
    - **Fuentes**: `07-CONVENCIONES-Y-BUENAS-PRACTICAS.md`, `02-ARQUITECTURA-BACKEND-MICROSERVICIOS.md`.
    - **Globs**: `["944-*/src/main/java/com/sat/facmovil/web/rest/*.java"]`

- [ ] **Crear `111-uso-dtos.mdc`**:
    - **Propósito**: Reforzar la regla de que las entidades de dominio no deben exponerse en la capa de API, y establecer convenciones para los DTOs.
    - **Fuentes**: `07-CONVENCIONES-Y-BUENAS-PRACTICAS.md`.
    - **Globs**: `["944-*/src/main/java/com/sat/facmovil/service/dto/*.java"]`

- [ ] **Crear `120-capa-de-servicio.mdc`**:
    - **Propósito**: Guías para la implementación de la lógica de negocio en las clases `*Service.java`.
    - **Fuentes**: `02-ARQUITECTURA-BACKEND-MICROSERVICIOS.md`.
    - **Globs**: `["944-*/src/main/java/com/sat/facmovil/service/*.java"]`

- [ ] **Crear `130-manejo-excepciones-backend.mdc`**:
    - **Propósito**: Corregir la mala práctica observada de capturar `Exception` genéricas. Establecer el estándar para usar excepciones específicas y crear excepciones personalizadas si es necesario.
    - **Fuentes**: `07-CONVENCIONES-Y-BUENAS-PRACTICAS.md`.
    - **Globs**: `["**/*.java"]`

### Fase 2: Reglas de Persistencia y Frontend

Esta fase aborda la interacción con la base de datos y la arquitectura de la aplicación móvil.

- [ ] **Crear `201-arquitectura-frontend-flutter.mdc`**:
    - **Propósito**: Definir la estructura de directorios (`screens`, `widgets`, `providers`, `services`) y el uso de la navegación por rutas.
    - **Fuentes**: `03-ARQUITECTURA-FRONTEND-FLUTTER.md`.
    - **Globs**: `["944-Factura_Movil_Front/lib/**/*.dart"]`

- [ ] **Crear `205-gestion-estado-provider.mdc`**:
    - **Propósito**: Establecer las buenas prácticas para el uso del patrón `Provider` para la gestión de estado.
    - **Fuentes**: `03-ARQUITECTURA-FRONTEND-FLUTTER.md`.
    - **Globs**: `["944-Factura_Movil_Front/lib/providers/**/*.dart"]`

- [ ] **Crear `210-comunicacion-backend-http.mdc`**:
    - **Propósito**: Guías para el uso de servicios (`*service.dart`) y el interceptor de autenticación para comunicarse con el API Gateway.
    - **Fuentes**: `03-ARQUITECTURA-FRONTEND-FLUTTER.md`.
    - **Globs**: `["944-Factura_Movil_Front/lib/services/**/*.dart", "944-Factura_Movil_Front/lib/interceptors/**/*.dart"]`

- [ ] **Crear `220-convenciones-nomenclatura-dart.mdc`**:
    - **Propósito**: Definir las convenciones de nomenclatura específicas para Dart (`snake_case` para archivos, `PascalCase` para clases, etc.).
    - **Fuentes**: `07-CONVENCIONES-Y-BUENAS-PRACTICAS.md`.
    - **Globs**: `["944-Factura_Movil_Front/lib/**/*.dart"]`

- [ ] **Crear `301-acceso-datos-jpa.mdc`**:
    - **Propósito**: Reglas para la capa de persistencia, incluyendo la creación de entidades de dominio (`domain`) y repositorios Spring Data JPA (`*Repository.java`).
    - **Fuentes**: `04-PERSISTENCIA-Y-DATOS.md`.
    - **Globs**: `["944-*/src/main/java/com/sat/facmovil/domain/*.java", "944-*/src/main/java/com/sat/facmovil/repository/*.java"]`

- [ ] **Crear `310-migraciones-bd-sql.mdc`**:
    - **Propósito**: Definir el proceso manual de creación de scripts de migración SQL, incluyendo la convención de nomenclatura (`psql_fm_object_...`, `rb_...`) y la necesidad de crear un script de rollback para cada cambio.
    - **Fuentes**: `04-PERSISTENCIA-Y-DATOS.md`.
    - **Globs**: `["944-ZuulFacMovil/base_de_datos/factura_movil/*.sql"]`

### Fase 3: Reglas Avanzadas (Seguridad, DevOps y Meta-Reglas)

- [ ] **Crear `401-seguridad-jwt-backend.mdc`**:
    - **Propósito**: Reglas para la configuración de seguridad en el API Gateway y los microservicios, el manejo de JWT y la definición de `AuthoritiesConstants`.
    - **Fuentes**: `05-SEGURIDAD-Y-AUTENTICACION.md`.
    - **Globs**: `["944-ZuulFacMovil/src/main/java/com/sat/facmovil/security/**/*.java"]`

- [ ] **Crear `410-integracion-idc-soap.mdc`**:
    - **Propósito**: Guías para interactuar con el servicio SOAP del IdC, incluyendo la configuración de `SoapConfiguration` y el uso del cliente.
    - **Fuentes**: `01-CONTEXTO-E-INTEGRACIONES.md`, `02-ARQUITECTURA-BACKEND-MICROSERVICIOS.md`.
    - **Globs**: `["944-Factura_Movil_Backend/src/main/java/com/sat/facmovil/idc/**/*.java", "944-Factura_Movil_Backend/src/main/java/com/sat/facmovil/configuration/SoapConfiguration.java"]`

- [ ] **Crear `501-despliegue-docker.mdc`**:
    - **Propósito**: Establecer las buenas prácticas para escribir y mantener los `Dockerfile` de cada microservicio.
    - **Fuentes**: `06-DESPLIEGUE-Y-OPERACIONES.md`.
    - **Globs**: `["944-*/codigo/Dockerfile"]`

- [ ] **Crear `502-orquestacion-kubernetes.mdc`**:
    - **Propósito**: Guías para la creación y mantenimiento de los archivos de despliegue de Kubernetes/OpenShift (`deploy-*.yaml`, `service-*.yaml`, `route-*.yaml`).
    - **Fuentes**: `06-DESPLIEGUE-Y-OPERACIONES.md`.
    - **Globs**: `["944-*/codigo/yamls/*.yaml"]`

- [ ] **Crear `910-gestion-de-reglas.mdc`**:
    - **Propósito**: Meta-regla que describe cómo se deben gestionar las reglas de este proyecto, similar a la del proyecto `raise-jf-ai-common`.
    - **Fuentes**: `raise-jf-ai-common/.cursor/rules/910-rule-management.mdc`.
    - **Globs**: `[".cursor/rules/**/*.mdc"]`, `alwaysApply: true`

- [ ] **Crear `920-precedencia-de-reglas.mdc`**:
    - **Propósito**: Meta-regla que define la jerarquía y resolución de conflictos entre reglas.
    - **Fuentes**: `raise-jf-ai-common/.cursor/rules/920-rule-precedence.mdc`.
    - **Globs**: `[".cursor/rules/**/*.mdc"]`, `alwaysApply: true`

## 4. Próximos Pasos

Una vez aprobado este plan, se procederá con la Fase 1, creando cada una de las reglas especificadas en un `commit` separado para facilitar la revisión y el seguimiento. 