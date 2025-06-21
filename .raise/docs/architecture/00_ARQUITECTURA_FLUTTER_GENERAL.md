# 00: Arquitectura General de la Aplicación Móvil Factura SAT Móvil (facturamovilapp)

## 1. Visión General

La aplicación `Factura SAT Móvil` (`facturamovilapp`) es el componente de frontend central del sistema de facturación electrónica del SAT. Desarrollada en Flutter, su propósito principal es permitir a los contribuyentes generar, consultar y gestionar sus Comprobantes Fiscales Digitales por Internet (CFDI) desde dispositivos móviles. Esto incluye la capacidad de firmar digitalmente documentos utilizando Certificados de Sello Digital (CSD) almacenados de forma segura en el dispositivo, gestionar catálogos, y recibir notificaciones.

### Objetivos de Negocio Clave:
*   Facilitar la emisión de CFDI a contribuyentes móviles.
*   Proveer una interfaz intuitiva para la gestión de facturas.
*   Asegurar la validez y seguridad de las firmas digitales en los CFDI.
*   Mantener la compatibilidad con los esquemas de facturación electrónica del SAT.

## 2. Principios Arquitectónicos

La arquitectura de `facturamovilapp` se basa en los siguientes principios clave para asegurar mantenibilidad, escalabilidad y una experiencia de usuario robusta:

*   **Arquitectura por Capas:** Separación clara de responsabilidades en capas distintas: Presentación (UI), Lógica de Negocio/Estado, Servicios (interacción con API) y Datos (modelos).
*   **Gestión Reactiva de Estado (Provider):** Utilización de la librería `Provider` para manejar el estado de la aplicación de forma eficiente, permitiendo a los componentes de UI reaccionar de manera óptima a los cambios en los datos.
*   **Seguridad en el Cliente:** Implementación de mecanismos para el almacenamiento seguro de información sensible (como claves y tokens) y la realización de operaciones criptográficas complejas (como la firma de CSD) directamente en el dispositivo, minimizando la exposición de datos críticos en tránsito.
*   **Responsabilidades Claras por Módulo:** El código está organizado en módulos lógicos (ej. `screens`, `providers`, `services`, `models`), donde cada uno tiene un propósito bien definido y un acoplamiento bajo con otros módulos.
*   **Consistencia de Nomenclatura y Estilo:** Adherencia a convenciones de nombrado en español y guías de estilo de Dart/Flutter para mejorar la legibilidad y facilitar la colaboración.

## 3. Diagrama de Contexto del Sistema (C4 Nivel 1)

```mermaid
C4Context
    title Sistema Factura SAT Móvil (facturamovilapp) - Nivel 1: Contexto

    Person(user, "Contribuyente", "Usuario final que emite y consulta facturas.")

    System(facturaMovilApp, "Factura SAT Móvil App", "Aplicación móvil híbrida (Flutter) para emisión y consulta de CFDI.")

    System_Ext(apiGateway, "API Gateway (Zuul)", "Servicio de pasarela para microservicios de backend y seguridad JWT.")
    System_Ext(firebase, "Firebase (FCM)", "Servicio de mensajería en la nube para notificaciones push.")
    System_Ext(deviceServices, "Servicios del Dispositivo", "Capacidades nativas del móvil (almacenamiento seguro, biometría, cámara).")

    Rel(user, facturaMovilApp, "Utiliza", "HTTP/S")
    Rel(facturaMovilApp, apiGateway, "Consume APIs de", "HTTP/S (JWT)")
    Rel(facturaMovilApp, firebase, "Recibe Notificaciones de", "Push Notifications")
    Rel(facturaMovilApp, deviceServices, "Interactúa con", "Librerías Nativas")

    UpdateLayoutConfig({
        Direction: LR
    })
```

## 4. Glosario de Términos Clave

A continuación, se definen algunos términos fundamentales utilizados en el contexto de `facturamovilapp`:

*   **Provider:** Patrón y librería de Flutter para la gestión de estado y la inyección de dependencias. Permite compartir el estado a través del árbol de widgets y reconstruir eficientemente la UI ante cambios.
*   **Widget:** El bloque de construcción fundamental de una interfaz de usuario en Flutter. Pueden ser visuales (botones, texto) o no visuales (controladores de layout).
*   **Screen (Pantalla):** Un `Widget` de alto nivel que representa una vista completa de la interfaz de usuario de la aplicación, generalmente correspondiente a una "página" o "activity".
*   **Service (Servicio):** Una clase encargada de encapsular la lógica de comunicación con APIs externas o la interacción con fuentes de datos, actuando como una implementación del patrón `Repository`.
*   **Model (Modelo):** Clases que representan las estructuras de datos del dominio de la aplicación, generalmente mapeadas a las respuestas JSON de las APIs.
*   **CSD (Certificado de Sello Digital):** Archivos criptográficos (`.cer` y `.key`) emitidos por el SAT que permiten a los contribuyentes firmar digitalmente sus CFDI, garantizando su autenticidad e integridad.
*   **Firma Electrónica:** Proceso criptográfico mediante el cual se utiliza el CSD para generar un sello digital sobre un CFDI, validando su origen y asegurando que no ha sido alterado.
*   **API Gateway:** Un patrón de arquitectura de microservicios (implementado con Zuul en el backend) que actúa como un punto de entrada único para las peticiones de los clientes, manejando enrutamiento, seguridad, balanceo de carga, entre otros.
*   **JWT (JSON Web Token):** Un estándar abierto para la creación de tokens de acceso que permiten a un usuario autenticarse de forma segura en un sistema. Utilizado para la comunicación entre la app y el API Gateway.

## 5. Índice de Documentación

Para una comprensión más profunda de la arquitectura de `facturamovilapp`, consulte los siguientes documentos:

*   [`01_ESTRUCTURA_Y_CAPAS.md`](./01_ESTRUCTURA_Y_CAPAS.md)
*   [`02_GESTION_DE_ESTADO_Y_FLUJO_DE_DATOS.md`](./02_GESTION_DE_ESTADO_Y_FLUJO_DE_DATOS.md)
*   [`03_COMUNICACION_API_Y_SEGURIDAD_CLIENTE.md`](./03_COMUNICACION_API_Y_SEGURIDAD_CLIENTE.md)
*   [`04_FUNCIONALIDADES_CRITICAS.md`](./04_FUNCIONALIDADES_CRITICAS.md)
*   [`05_ESTRATEGIAS_DE_CALIDAD_Y_PRUEBAS.md`](./05_ESTRATEGIAS_DE_CALIDAD_Y_PRUEBAS.md)
*   [`06_CONVENCIONES_Y_GUIAS_DE_ESTILO.md`](./06_CONVENCIONES_Y_GUIAS_DE_ESTILO.md) 