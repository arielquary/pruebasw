---
document_id: "TEC-FMV-FRONT-001"
title: "Diseño Técnico Frontend: Auditoría de Implementación del MVP Existente"
project_name: "Factura Móvil App (Frontend)"
feature_us_ref: ".raise/docs/mvp.md"
version: "1.0"
date: "2024-07-26"
author: "RAISE Tech Lead"
related_docs:
  - ".raise/docs/analisis_implementacion_mvp.md"
status: "Final"
---

# Diseño Técnico Frontend: Auditoría de Implementación del MVP Existente

**Reglas de Cursor Relevantes:**
- `@rules/201-arquitectura-frontend-flutter.mdc`
- `@rules/205-gestion-estado-provider.mdc`
- `@rules/230-capa-servicios-http.mdc`
- `@rules/411-seguridad-cliente-flutter.mdc`
- `@rules/601-estrategia-pruebas-flutter.mdc`
- `@rules/220-convenciones-nomenclatura-dart.mdc`

## 1. Visión General y Objetivo
El objetivo de este documento es registrar y analizar la arquitectura y la implementación actual del Producto Mínimo Viable (MVP) de la aplicación Factura Móvil. Sirve como una auditoría técnica para entender el estado del código base, verificar el cumplimiento de las reglas de arquitectura y documentar cómo se implementaron las funcionalidades descritas en `.raise/docs/mvp.md`.

## 2. Solución Propuesta
La implementación existente sigue un enfoque de arquitectura por capas, en total conformidad con la regla `@rules/201-arquitectura-frontend-flutter.mdc`. La estructura de directorios principal en `lib/` demuestra una clara separación de responsabilidades:
- **`screens`**: Contiene los widgets que representan pantallas completas.
- **`providers`**: Gestiona el estado de la aplicación utilizando el patrón Provider.
- **`services`**: Encapsula la comunicación con el backend (API REST).
- **`models`**: Define las estructuras de datos (DTOs) utilizadas en la aplicación.
- **`widgets`**: Almacena componentes de UI reutilizables.
- **`helpers`**: Centraliza lógica de utilidad común (validaciones, constantes, etc.).

## 3. Arquitectura y Desglose de Componentes (Flutter)

*   **Pantallas (`/lib/screens/`):**
    *   `pantalla_autenticacion.dart`: Implementa el login con RFC y contraseña. Maneja la lógica de autenticación biométrica.
    *   `pantalla_inicio.dart`: Pantalla principal que contiene el `drawer` (menú lateral) y el `body` donde se muestran otras pantallas.
    *   `pantalla_clientes_frecuentes.dart`: Muestra la lista de clientes y permite las operaciones CRUD (Crear, Leer, Actualizar, Borrar).
    *   `pantalla_agregar_cliente_frecuente.dart`: Formulario para crear o editar un cliente.
    *   `pantalla_agregar_factura.dart`: Formulario principal y complejo para la creación y edición de facturas y plantillas. Orquesta múltiples sub-componentes y proveedores.
    *   `pantalla_filtros_busqueda.dart`: Proporciona la UI para buscar facturas por folio (UUID) o por rango de fechas.
    *   `pantalla_resultado_factura.dart`: Muestra los resultados de la búsqueda de facturas con paginación y opciones de descarga (XML/PDF).
    *   `pantalla_plantillas_factura.dart`: Gestiona la lista de plantillas, permitiendo su uso, edición y eliminación.
    *   `pantalla_generar_codigo_qr.dart`: Genera y muestra un código QR con la información fiscal del usuario autenticado.
    *   `pantalla_acerca.dart`: Muestra información de la app, incluyendo versión, términos y condiciones, y políticas de privacidad.

*   **Widgets Reutilizables (`/lib/widgets/`):**
    *   `menu_lateral.dart`: Menú de navegación principal de la aplicación.
    *   `menu_flotante.dart`: Menú de acciones rápidas (Speed Dial).
    *   `combo_box_busqueda.dart`: Componente genérico y reutilizable para seleccionar ítems de un catálogo con funcionalidad de búsqueda.
    *   `boton_accion.dart`: Botón estandarizado para acciones principales.
    *   `alerta.dart`: Widget para mostrar diálogos de alerta de manera consistente.
    *   `cargando.dart`: Indicador de progreso reutilizable.

*   **Proveedores de Estado (`/lib/providers/`):**
    *   `proveedor_autenticacion.dart`: Gestiona el estado de la sesión del usuario, los datos del perfil y la lógica de autenticación (contraseña y biométricos).
    *   `proveedor_factura.dart`: Orquesta el estado completo de la factura que se está creando/editando. Contiene la lógica de negocio y validaciones del CFDI.
    *   `proveedor_plantilla.dart`: Administra la lista de plantillas de factura, su selección, guardado y eliminación.
    *   `proveedor_cliente_frecuente.dart`: Maneja el estado y la lista de los clientes frecuentes.

*   **Servicios (`/lib/services/`):**
    *   `servicio_autenticacion.dart`: Gestiona las llamadas a la API para login, logout, refresco de token y obtención de datos del perfil de usuario.
    *   `servicio_consulta_factura.dart`: Maneja la comunicación con el backend para buscar facturas y descargar sus archivos XML y PDF.
    *   `servicio_comprobante.dart`: Orquesta las llamadas a la API para el proceso de validación y timbrado de un nuevo CFDI.
    *   `servicio_frecuentes.dart`: Se comunica con la API para el CRUD de clientes frecuentes.
    *   `servicio_plantilla_factura.dart`: Interactúa con los endpoints del backend para el CRUD de plantillas.

*   **Modelos de Datos (`/lib/models/`):**
    *   `modelo_factura.dart`: Modelo principal que representa una factura completa con todos sus componentes (cliente, conceptos, impuestos, etc.).
    *   `modelo_cliente_frecuente.dart`: Representa los datos de un cliente.
    *   `modelo_plantilla_factura.dart`: Representa una plantilla de factura.
    *   `modelo_datos_usuario.dart`: Contiene la información del perfil del usuario autenticado.

## 4. Interacción con Backend y Contratos de API

*   **Endpoint:** `[POST] /api/zuul/auth/nam/token`
    *   **Servicio Frontend:** `ServicioAutenticacion`
    *   **Método:** `iniciarSesion()`
*   **Endpoint:** `[POST] /api/zuul/auth/nam/logout`
    *   **Servicio Frontend:** `ServicioAutenticacion`
    *   **Método:** `cerrarSesion()`
*   **Endpoint:** `[POST] /api/zuul/auth/nam/refresh/token`
    *   **Servicio Frontend:** `ServicioAutenticacion`
    *   **Método:** `refrescarToken()`
*   **Endpoint:** `[POST] facturas/consultaCfdi`
    *   **Servicio Frontend:** `ServicioConsultaFactura`
    *   **Método:** `consultarCfdi()`
*   **Endpoint:** `[POST] ri/obtenerPdf` y `ri/obtenerXml`
    *   **Servicio Frontend:** `ServicioConsultaFactura`
    *   **Método:** `descargarCfdi()`
*   **Endpoint:** `[POST] genera-cfdi/v2/valida-xml`
    *   **Servicio Frontend:** `ServicioComprobante`
    *   **Método:** `validaXml()`
*   **Endpoint:** `[POST] genera-cfdi/v2/timbrarXml`
    *   **Servicio Frontend:** `ServicioComprobante`
    *   **Método:** `timbrarXml()`
*   **Interceptor:**
    *   `lib/interceptors/auth_interceptor.dart`: Existe y su función es inyectar el token de autenticación (`Bearer token`) en las cabeceras de las solicitudes a la API y manejar la lógica de refresco de token de forma transparente.

## 5. Gestión de Estado (Provider)
El flujo de datos sigue el patrón estándar de Provider:
1.  La **UI** (ej. un botón en `pantalla_agregar_factura.dart`) invoca un método de un proveedor (ej. `context.read<ProveedorFactura>().timbrarFactura()`).
2.  El método en el **Provider** actualiza su estado (ej. `isLoading = true`), llama al **Service** correspondiente (ej. `ServicioComprobante.timbrarXml()`).
3.  El **Service** realiza la llamada HTTP.
4.  Al recibir la respuesta, el **Provider** actualiza su estado con los nuevos datos o un mensaje de error (ej. `isLoading = false`, `timbradoExitoso = true`) y llama a `notifyListeners()`.
5.  La **UI**, que está escuchando los cambios con `context.watch<ProveedorFactura>()`, se reconstruye para reflejar el nuevo estado (ej. mostrando un diálogo de éxito).

## 6. Persistencia y Modelo de Datos Local
*   **flutter_secure_storage**: Se utiliza intensivamente en `servicio_autenticacion.dart` para guardar de forma segura el token de acceso, el token de refresco y las credenciales del usuario cuando se habilita la autenticación biométrica.
*   **shared_preferences**: No se detectó un uso significativo en los flujos principales del MVP.

## 7. Estrategia de Manejo de Errores
*   **Captura de Errores:** Los `services` encapsulan las llamadas HTTP en bloques `try-catch`. Capturan excepciones de red (`SocketException`) y errores de la API.
*   **Notificación al Usuario:** Los errores capturados se propagan hacia los `providers`, que a su vez utilizan un `ServicioNotificacion.mostrarSnackBar` centralizado para mostrar mensajes de error consistentes al usuario en la parte inferior de la pantalla.

## 8. Estrategia de Pruebas
No se encontrÃ³ un directorio `test/` en el proyecto, lo que indica una **ausencia de pruebas automatizadas** (unitarias, de widget y de integraciÃ³n).

## 9. Resumen de Brechas y Hallazgos

*   **Funcionalidades del MVP Implementadas Correctamente:**
    - Autenticación de usuario (con contraseña y biométricos).
    - Gestión completa (CRUD) de Clientes Frecuentes.
    - Gestión completa (CRUD) de Plantillas de Factura.
    - Generación de Factura de Ingreso, incluyendo el flujo de validación, firma y timbrado.
    - Consulta de facturas emitidas por rango de fechas y folio (UUID).
    - Descarga de representaciones XML y PDF de facturas consultadas.
    - Generación de código QR para compartir datos fiscales.
*   **Funcionalidades con Desviaciones:**
    - Ninguna desviación significativa fue encontrada. La implementación es fiel a los requisitos del MVP.
*   **Funcionalidades Faltantes:**
    - Ninguna funcionalidad del MVP está ausente.
*   **Deuda Técnica o Puntos de Mejora Identificados:**
    - **Ausencia total de pruebas automatizadas:** Este es el principal punto de mejora. La falta de un conjunto de pruebas aumenta el riesgo de regresiones al introducir nuevas funcionalidades o refactorizar el código existente. Se recomienda encarecidamente la creación de una estrategia de pruebas siguiendo `@rules/601-estrategia-pruebas-flutter.mdc`. 