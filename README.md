# Factura SAT Móvil

Aplicación móvil desarrollada en Flutter para la generación y administración de Comprobantes Fiscales Digitales por Internet (CFDI) en su versión 4.0, de acuerdo con las disposiciones del Servicio de Administración Tributaria (SAT) en México.

## 📜 Descripción de Funcionalidad

La aplicación permite a los contribuyentes gestionar su facturación de una manera ágil y desde su dispositivo móvil. Las principales funcionalidades incluyen:

- **Gestión de Facturas:** Crear, consultar, cancelar y descargar facturas (CFDI).
- **Catálogos:** Administración de catálogos para agilizar la captura de información:
  - **Clientes Frecuentes:** Guardar y gestionar los datos de los receptores de facturas.
  - **Productos y Servicios:** Registrar los productos o servicios que se comercializan.
- **Plantillas de Facturas:** Crear y utilizar plantillas para generar facturas recurrentes de forma rápida.
- **Complemento Carta Porte:** Soporte para la generación del Complemento Carta Porte, indispensable para el traslado de mercancías en territorio nacional.
- **Firma Electrónica:** Integración con los Certificados de Sello Digital (CSD) para el timbrado de los comprobantes.
- **Configuración Personalizada:** Permite configurar datos del emisor, regímenes fiscales, series, folios y más.

## 📁 Estructura de Carpetas

El proyecto está organizado siguiendo las convenciones de Flutter, separando la lógica, la interfaz de usuario y los datos.

```
fac_mov_app/
├── android/              # Archivos y configuración específicos de la plataforma Android.
├── ios/                  # Archivos y configuración específicos de la plataforma iOS.
├── lib/                  # Contiene todo el código fuente de la aplicación en Dart.
│   ├── componente_firma/ # Lógica y widgets para el proceso de firma electrónica.
│   ├── enums/            # Enumeraciones utilizadas en toda la aplicación.
│   ├── global/           # Configuraciones globales, como variables de ambiente.
│   ├── helpers/          # Clases de utilidad y funciones de apoyo.
│   ├── interceptors/     # Interceptores para las peticiones HTTP (ej. añadir tokens).
│   ├── models/           # Clases de modelo que representan la estructura de datos.
│   ├── providers/        # Lógica de manejo de estado utilizando el paquete Provider.
│   ├── router/           # Configuración de las rutas de navegación de la app.
│   ├── screens/          # Widgets que representan las diferentes pantallas de la app.
│   ├── services/         # Clases que gestionan la comunicación con APIs externas.
│   ├── themes/           # Definición del tema visual de la aplicación.
│   └── widgets/          # Widgets reutilizables en diferentes partes de la UI.
├── librerias/            # Bibliotecas locales o forks modificados para el proyecto.
├── assets/               # Archivos estáticos como imágenes, fuentes y otros recursos.
└── pubspec.yaml          # Define las dependencias y metadatos del proyecto.
```

## 🚀 Cómo Compilar y Ejecutar

Sigue estos pasos para poner en marcha el proyecto en tu entorno de desarrollo.

### Prerrequisitos

- Tener instalado el [SDK de Flutter](https://docs.flutter.dev/get-started/install).
- Un editor de código como [VS Code](https://code.visualstudio.com/) o [Android Studio](https://developer.android.com/studio).
- Un emulador de Android o un dispositivo físico conectado.

### Pasos

1.  **Clonar el repositorio:**
    ```bash
    git clone https://github.com/todobydevelop/facturamovilapp.git
    cd facturamovilapp
    ```

2.  **Instalar dependencias:**
    Ejecuta el siguiente comando para descargar todas las librerías necesarias.
    ```bash
    flutter pub get
    ```

3.  **Ejecutar la aplicación:**
    Lanza la aplicación en modo de depuración.
    ```bash
    flutter run
    ```

## 📦 Cómo Generar el APK

Para crear el archivo de instalación para Android (`.apk`), ejecuta el siguiente comando:

```bash
flutter build apk
```

Una vez finalizado el proceso, encontrarás el archivo `app-release.apk` en el siguiente directorio:

```
build/app/outputs/flutter-apk/app-release.apk
```

Este archivo está listo para ser instalado en un dispositivo Android.
