# 06: Convenciones y Guías de Estilo en Factura SAT Móvil (facturamovilapp)

Este documento establece las convenciones de nomenclatura, las guías de estilo de codificación y las mejores prácticas para el manejo de dependencias y errores en la aplicación `facturamovilapp`. Adherirse a estas directrices es fundamental para mantener la consistencia, legibilidad y mantenibilidad del código, facilitando la colaboración humana y la comprensión por parte de agentes de IA.

## 1. Convenciones de Nomenclatura

La consistencia en la nomenclatura es clave para la legibilidad del código. Se siguen las convenciones estándar de Dart/Flutter, junto con algunas específicas del proyecto:

*   **Archivos (`.dart`):** Utilizar `snake_case` (todo en minúsculas, palabras separadas por guiones bajos).
    *   Ejemplos: `proveedor_autenticacion.dart`, `pantalla_agregar_factura.dart`, `utileria_http.dart`.

*   **Clases, Enums, Typedefs:** Utilizar `PascalCase` (cada palabra comienza con mayúscula, sin separadores).
    *   Ejemplos: `ServicioAutenticacion`, `ModeloFirma`, `ScanMode`.

*   **Variables, Constantes Locales, Parámetros, Métodos y Funciones:** Utilizar `camelCase` (la primera palabra en minúsculas, las siguientes con mayúscula inicial).
    *   Ejemplos: `iniciarSesion`, `tokenNotificacion`, `_messageStream`.

*   **Constantes Globales/Estáticas (`static const`):** Utilizar `camelCase` con la primera letra en minúscula para aquellas que son internas o no están expuestas como públicas fuera de su ámbito inmediato. Para las que son de naturaleza global y pública, `PascalCase` o incluso `UPPER_SNAKE_CASE` puede ser usado si la visibilidad es muy amplia, aunque `camelCase` es preferido en Flutter para consistencia.
    *   Ejemplos: `baseUrlZuul` (en `Ambiente`), `_keyToken` (constante privada en `ServicioAutenticacion`).

*   **Sufijos de Clases (Guía de Propósito):**
    *   `*Screen`: Para clases que representan pantallas completas de la UI (ej., `PantallaAgregarFactura`).
    *   `*Widget`: Para componentes de UI reutilizables (ej., `BotonAccion`, `ComboBoxBusqueda`).
    *   `*Provider`: Para clases que extienden `ChangeNotifier` y gestionan el estado (ej., `ProveedorFactura`, `ProveedorAutenticacion`).
    *   `*Service`: Para clases que encapsulan la lógica de comunicación con APIs o servicios externos (ej., `ServicioComprobante`, `ServicioCatalogos`).
    *   `*Model`: Para clases que representan estructuras de datos (ej., `ModeloFactura`, `ModeloConcepto`).
    *   `*Util / *Utileria`: Para clases que contienen funciones de utilidad (ej., `UtileriaHttp`, `UtileriaFirma`).

## 2. Guía de Estilo de Codificación

La aplicación debe adherirse a las directrices de [Effective Dart](https://dart.dev/guides/language/effective-dart), que proporciona un conjunto integral de recomendaciones para escribir código Dart limpio, consistente y eficiente.

*   **Formato de Código:** Se recomienda el uso de herramientas de formateo automático como `dart format` o la funcionalidad de formateo del IDE (ej., `Format Document` en VS Code) para asegurar la consistencia del espaciado, indentación y saltos de línea.
*   **Uso de `const` y `final`:** Preferir `const` para valores que son constantes en tiempo de compilación y `final` para variables que se asignan una sola vez en tiempo de ejecución. Esto mejora el rendimiento y la inmutabilidad.
*   **Encapsulamiento:** Utilizar `_` (guion bajo) como prefijo para miembros privados (clases, variables, métodos) dentro de una librería (archivo `.dart`).
*   **Funciones Cortas y Enfocadas:** Los métodos y funciones deben ser concisos y tener una única responsabilidad bien definida (Principio de Responsabilidad Única).
*   **Evitar Comentarios Obvios:** Los comentarios deben explicar el "por qué" de una decisión, no el "qué" de una línea de código que es autoexplicativa.
*   **Análisis Estático (`Linter`):** El código debe cumplir con el conjunto de reglas `package:flutter_lints/flutter.yaml`, que viene por defecto en el archivo `analysis_options.yaml`. No se deben introducir advertencias (`warnings` o `lints`) en el código.

## 3. Gestión de Dependencias, Assets y Navegación

### 3.1. Dependencias (`pubspec.yaml`)
*   **Proceso para Agregar/Actualizar Dependencias:**
    1.  Siempre consultar `pub.dev` para obtener la última versión estable de un paquete.
    2.  Añadir la dependencia en la sección `dependencies` o `dev_dependencies` de `pubspec.yaml`.
    3.  Ejecutar `flutter pub get` para descargar el paquete y actualizar `pubspec.lock`.
    4.  Si se actualiza una dependencia, se debe verificar que no haya cambios significativos (`breaking changes`) y, si los hay, adaptar el código y actualizar la documentación si es necesario.
*   **Prohibición de "Vendoring" (`librerias/`):**
    *   Queda estrictamente prohibido añadir nuevas dependencias copiadas localmente al directorio `librerias/`.
    *   Las dependencias existentes en `librerias/` deben ser migradas a un fork oficial de Git o a versiones de `pub.dev` tan pronto como sea posible.

### 3.2. Gestión de Assets (Imágenes y Fuentes)
*   **Estructura de Directorios:**
    *   Todas las imágenes deben residir en el directorio `assets/images/`.
    *   Otros assets (como fuentes, si se añaden) deben estar en un subdirectorio descriptivo (ej. `assets/fonts/`).
*   **Declaración en `pubspec.yaml`:** Los assets deben declararse a nivel de directorio en el `pubspec.yaml` para incluir todos los archivos dentro de él (ej. `assets/images/`).
*   **Acceso a Assets:** El acceso a los assets se realiza mediante su ruta completa como un String (ej. `Image.asset('assets/images/logo.png')`). No se utiliza generación de código para los assets.

### 3.3. Navegación y Rutas
*   **Estrategia de Enrutamiento:** Se utiliza el enrutador estándar de Flutter (`Navigator 1.0`).
*   **Definición de Rutas:**
    *   Cada pantalla (`Screen`) debe definir su nombre de ruta como una constante estática: `static const String rutaInicial = 'NombreDeLaRuta';`.
    *   Todas las rutas se registran en un `Map<String, Widget Function(BuildContext)>` centralizado en `lib/router/rutas_aplicacion.dart` a través del método `obtenerRutas()`.
*   **Navegación:**
    *   Para rutas simples sin argumentos, se debe usar `Navigator.pushNamed(context, PantallaX.rutaInicial);`.
    *   Para rutas que requieren argumentos, se debe usar el callback `onGenerateRoute` en `rutas_aplicacion.dart`, y la navegación se realiza con `Navigator.pushNamed(context, PantallaY.rutaInicial, arguments: misArgumentos);`.

## 4. Estilos Visuales y Textos

### 4.1. Sistema de Temas (Theming)
*   **Patrón de Estilos:** La aplicación NO utiliza el sistema `Theme.of(context)` de forma extensiva. En su lugar, se centralizan los estilos en la clase `lib/themes/tema_principal.dart`.
*   **Uso:** Todos los colores, `TextStyle`, `ButtonStyle` y otros elementos de estilo deben ser consumidos como constantes estáticas desde la clase `TemaPrincipal`.
    ```dart
    // CORRECTO
    Text(
      'Mi Título',
      style: TemaPrincipal.estiloTitulo,
    )

    // INCORRECTO
    Text(
      'Mi Título',
      style: TextStyle(fontSize: 19, color: Colors.white),
    )
    ```

### 4.2. Internacionalización (i18n) y Textos
*   **Estrategia de Textos:** La aplicación NO utiliza un sistema formal de internacionalización. Todos los textos visibles para el usuario están "hardcodeados" en español.
*   **Uso:** Todos los mensajes, etiquetas de botones, títulos y otros textos estáticos deben ser definidos como constantes `static const String` en la clase `lib/helpers/utileria_mensajes.dart` y ser consumidos desde allí.
    ```dart
    // CORRECTO
    Text(UtileriaMensajes.guardadoExitoso)

    // INCORRECTO
    Text('Se guardó correctamente la información.')
    ```

## 5. Manejo de Errores

La aplicación debe manejar los errores de manera robusta y proporcionar feedback claro al usuario.

*   **Captura de Excepciones:** Utilizar bloques `try-catch` para manejar excepciones esperadas, especialmente en operaciones asíncronas (llamadas a la API, acceso a almacenamiento).
    *   **Evitar `catch (e)` genérico:** Siempre que sea posible, capturar excepciones específicas (ej., `SocketException` para problemas de red, excepciones personalizadas para errores de negocio). Evitar `catch (e)` sin un `on` específico, ya que puede ocultar errores inesperados.
*   **Propagación de Errores:** Los errores de la capa de `services` deben ser propagados a la capa de `providers`, que luego los manejará para actualizar el estado y mostrar mensajes de error apropiados en la UI (a menudo utilizando `ServicioNotificacion.mostrarSnackBar` con un mensaje de `UtileriaMensajes`).
*   **Feedback al Usuario:** Utilizar `SnackBar` (vía `ServicioNotificacion`) o `AlertDialog` para informar al usuario sobre errores de manera comprensible y no intrusiva.
*   **Logging de Errores:** Asegurar que los errores críticos sean registrados adecuadamente utilizando la estrategia de logging definida en `05_ESTRATEGIAS_DE_CALIDAD_Y_PRUEBAS.md` para facilitar el diagnóstico en producción.

## 6. Comentarios y Documentación de Código

*   **DartDoc (`///`):** Utilizar `///` (triple barra) para documentar clases, métodos, funciones y propiedades públicas. Esto genera documentación legible que es accesible desde el IDE y puede ser compilada a HTML.
*   **Comentarios de Implementación (`//` y `/* */`):** Utilizar para explicar lógica compleja, justificar decisiones de diseño no obvias, o marcar TODOs/FIXMEs.
*   **Consistencia:** Mantener una consistencia en el estilo y la verbosidad de los comentarios en todo el proyecto.

--- 