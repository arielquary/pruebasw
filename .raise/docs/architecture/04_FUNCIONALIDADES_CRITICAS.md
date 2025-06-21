# 04: Funcionalidades Críticas de la Aplicación Móvil Factura SAT Móvil (facturamovilapp)

Este documento se enfoca en las funcionalidades más complejas, sensibles o de alto impacto de `facturamovilapp`, analizando su implementación y los riesgos asociados. Estas funcionalidades son cruciales para el negocio y requieren una comprensión detallada.

## 1. Componente de Firma Electrónica (`componente_firma`)

El componente de firma electrónica es una de las funcionalidades más críticas y complejas de la aplicación, ya que permite a los contribuyentes firmar digitalmente sus Comprobantes Fiscales Digitales por Internet (CFDI) directamente desde el dispositivo móvil. Esto implica el manejo de Certificados de Sello Digital (CSD) y la realización de operaciones criptográficas de alto nivel.

*   **Propósito:** Generar una firma digital (sello digital) sobre la cadena original de un CFDI utilizando la clave privada del CSD del contribuyente, garantizando la autenticidad e integridad del documento fiscal.

*   **Ubicación Principal de la Lógica:** La lógica central se encuentra en el directorio `lib/componente_firma/`, con los archivos clave siendo:
    *   `utileria_firma.dart`: Contiene las funciones de utilidad para el procesamiento de certificados (obtención de RFC, número de serie), la desencriptación de claves privadas (manejo de PKCS#8) y la firma RSA de la cadena original.
    *   `servicio_firma.dart`: Expone la funcionalidad de validación del estatus del certificado ante el backend. Si bien el nombre sugiere un servicio, la lógica de firma se delega a `utileria_firma`.
    *   `proveedor_firma.dart`: Actúa como el `ChangeNotifier` que expone el estado y los métodos de firma a la capa de UI.
    *   `pantalla_firma.dart`: La interfaz de usuario donde el usuario interactúa para seleccionar el certificado, ingresar la contraseña y realizar la firma.

*   **Librerías Criptográficas Clave (Vendoreadas):**
    *   `pointycastle`: Una biblioteca criptográfica de Dart que proporciona implementaciones de algoritmos como RSA, DES, hashing (SHA, MD5), y manejo de ASN.1. Es fundamental para las operaciones de firma.
    *   `asn1lib`: Utilizada para parsear y construir estructuras de datos ASN.1, esenciales en el manejo de certificados X.509 y claves privadas PKCS#8.
    *   `basic_utils`: Una colección de utilidades Dart que incluye funciones para manejar certificados X.509, claves RSA y operaciones de criptografía. Es una capa de abstracción sobre `pointycastle` y `asn1lib`.

*   **Flujo Conceptual de Firma de Cadena Original (`firmarCadenaOriginal`):**
    1.  **Recepción de CSD:** El usuario selecciona su archivo `.cer` y `.key` (clave privada) y proporciona la contraseña de la clave privada.
    2.  **Extracción de Información del Certificado:** `utileria_firma.obtenerRFC` extrae el RFC y el número de serie del certificado X.509. Se valida que sea un CSD y no una FIEL.
    3.  **Desencriptación de Clave Privada:** La clave privada (`.key`) es típicamente un archivo PKCS#8 cifrado. `utileria_firma._obtenerInfoPkcs8` y `utileria_firma._desencriptar` se encargan de descifrar la clave privada usando la contraseña proporcionada y `dart_des`.
    4.  **Verificación de Correspondencia:** Se valida que la clave privada corresponda al certificado (`llavePublica.modulus == llavePrivada.modulus`).
    5.  **Preparación de Cadena Original:** La aplicación recibe una "cadena original" (un string específico generado por el SAT) que contiene placeholders para el número de serie del certificado. `utileria_firma.firmarCadenaOriginal` reemplaza estos placeholders con el número de serie real.
    6.  **Firma RSA:** La cadena original modificada es firmada utilizando el algoritmo RSA y la clave privada descifrada (`basic_util.CryptoUtils.rsaSign`).
    7.  **Codificación Base64:** La firma binaria resultante se codifica en Base64.
    8.  **Verificación Interna:** Opcionalmente, se realiza una verificación de la firma (`basic_util.CryptoUtils.rsaVerify`) para asegurar su validez antes de enviarla al backend.

*   **Riesgos de Seguridad y Mantenimiento:**
    *   **Vendoring de Librerías Criptográficas:** El uso de versiones modificadas localmente de `pointycastle` y `basic_utils` (ver `01_ESTRUCTURA_Y_CAPAS.md`) es un riesgo crítico. No reciben actualizaciones automáticas de seguridad, lo que puede dejar la aplicación vulnerable a exploits si se descubren fallos en las versiones usadas.
    *   **Manejo de Claves Privadas:** Aunque el almacenamiento final del CSD puede ser temporal, la lógica de manejo de las claves privadas en el cliente es compleja y cualquier error podría comprometer la seguridad de las credenciales del contribuyente.

## 2. Escáner de Códigos QR/Barras (`flutter_barcode_scanner`)

La aplicación incluye una funcionalidad para escanear códigos QR y códigos de barras, previsiblemente para la lectura rápida de datos de CFDI o productos.

*   **Librería Utilizada:** `flutter_barcode_scanner`.
*   **Modificación Local:** Como se detalla en `pubspec.yaml`, esta librería ha sido modificada localmente (vendoreada) para "leer certificados con letra Ñ". Esto implica que la versión utilizada no es la oficial y que cualquier mejora o parche de seguridad de la librería original no se integra automáticamente, con los mismos riesgos de mantenimiento y seguridad que las librerías criptográficas.
*   **Uso:** La funcionalidad se expone a través de métodos estáticos en la clase `FlutterBarcodeScanner` que interactúan con los canales de métodos (`MethodChannel`) nativos del dispositivo.

## 3. Notificaciones Push (Firebase Cloud Messaging - FCM)

La aplicación utiliza Firebase Cloud Messaging (FCM) para enviar y recibir notificaciones push, lo que es fundamental para la comunicación en tiempo real con el usuario, como alertas sobre el estatus de facturas o avisos importantes.

*   **Configuración:** La inicialización de Firebase y la configuración de los `handlers` para las notificaciones se realiza en `lib/services/push_notifications_service.dart`.
*   **Librerías Clave:** `firebase_core` (para la inicialización de Firebase) y `firebase_messaging` (para la gestión de mensajes push).
*   **Manejo de Mensajes:**
    *   **`_backgroundHandler`:** Procesa mensajes cuando la aplicación está en segundo plano o terminada.
    *   **`_onMessageHandler`:** Maneja mensajes cuando la aplicación está en primer plano (abierta y activa).
    *   **`_onMessageOpenApp`:** Gestiona el evento cuando el usuario toca una notificación para abrir la aplicación.
    *   **Flujo de Datos:** Las notificaciones entrantes parecen extraer un campo `'folio'` de los datos del mensaje y lo añaden a un `StreamController` (`_messageStream`) para su posterior procesamiento en la UI.
*   **Permisos:** Se solicita explícitamente el permiso para mostrar notificaciones al usuario (`messaging.requestPermission`).
*   **Token de Notificación:** La aplicación obtiene el token de registro del dispositivo (`tokenNotificacion`) para permitir que el backend dirija las notificaciones a usuarios específicos. 