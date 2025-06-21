---
document_id: "TEC-FMV-FRONT-003"
title: "Diagramas de Arquitectura Detallados: Análisis MVP Existente"
project_name: "Factura Móvil App (Frontend)"
feature_us_ref: ".raise/docs/analisis_implementacion_mvp.md"
version: "1.0"
date: "2024-07-26"
author: "RAISE Tech Lead - Claude"
status: "Final"
---
# Diagramas de Arquitectura Detallados: MVP de Factura Móvil

Este documento contiene diagramas técnicos detallados basados en los hallazgos del análisis de implementación del MVP. Los diagramas Mermaid siguen estrictamente las reglas de `@aaa-generacion-mermaid.mdc`.

## 1. Arquitectura General del Sistema (Mermaid)

Este diagrama muestra la arquitectura por capas y las relaciones entre los componentes principales identificados en la auditoría.

```mermaid
graph TB
    subgraph "Frontend Flutter App"
        subgraph "UI Layer"
            A["PantallaAutenticacion"]
            B["PantallaInicio"]
            C["PantallaAgregarFactura"]
            D["PantallaClientesFrecuentes"]
            E["PantallaPlantillasFactura"]
            F["MenuLateral"]
            G["MenuFlotante"]
        end
      
        subgraph "State Management (Provider)"
            H["ProveedorAutenticacion"]
            I["ProveedorFactura"]
            J["ProveedorClienteFrecuente"]
            K["ProveedorPlantilla"]
        end
      
        subgraph "Services Layer"
            L["ServicioAutenticacion"]
            M["ServicioComprobante"]
            N["ServicioConsultaFactura"]
            O["ServicioFrecuentes"]
            P["ServicioPlantillaFactura"]
        end
      
        subgraph "Models & Helpers"
            Q["ModeloFactura"]
            R["ModeloClienteFrecuente"]
            S["UtilidadValidaciones"]
            T["UtilidadMensajes"]
        end
    end
  
    subgraph "External Systems"
        U["Backend API REST"]
        V["Flutter Secure Storage"]
        W["Local Auth (Biometrics)"]
    end
  
    A --> H
    B --> F
    B --> G
    C --> I
    D --> J
    E --> K
  
    H --> L
    I --> M
    I --> N
    J --> O
    K --> P
  
    I --> Q
    J --> R
  
    L --> U
    M --> U
    N --> U
    O --> U
    P --> U
  
    L --> V
    H --> W
```

## 2. Flujo de Autenticación Completo (Mermaid)

Diagrama de secuencia que muestra el flujo completo de autenticación, incluyendo biometría y manejo de errores.

```mermaid
sequenceDiagram
    participant Usuario
    participant PantallaAuth as "PantallaAutenticacion"
    participant ProvAuth as "ProveedorAutenticacion"
    participant ServAuth as "ServicioAutenticacion"
    participant SecureStorage as "Secure Storage"
    participant LocalAuth as "Local Auth"
    participant API as "Backend API"

    Usuario->>PantallaAuth: "Abre la aplicación"
    activate PantallaAuth
  
    PantallaAuth->>ProvAuth: "getDatosUsuario()"
    activate ProvAuth
  
    ProvAuth->>ServAuth: "getRFCUsuario()"
    activate ServAuth
    ServAuth->>SecureStorage: "Lee RFC guardado"
    SecureStorage-->>ServAuth: "RFC o vacío"
    ServAuth-->>ProvAuth: "RFC encontrado"
    deactivate ServAuth
  
    alt "RFC existe y biometría disponible"
        ProvAuth->>LocalAuth: "checarDisponibilidadBiometricos()"
        LocalAuth-->>ProvAuth: "true"
        ProvAuth-->>PantallaAuth: "Mostrar UI biométrica"
        PantallaAuth-->>Usuario: "Opción de login biométrico"
      
        Usuario->>PantallaAuth: "Usa biometría"
        PantallaAuth->>ProvAuth: "verificarBiometricos()"
        ProvAuth->>LocalAuth: "authenticate()"
        LocalAuth-->>ProvAuth: "Autenticación exitosa"
      
        ProvAuth->>ServAuth: "iniciarSesion(rfc, pass, true)"
        activate ServAuth
        ServAuth->>API: "POST /api/zuul/auth/nam/token"
        API-->>ServAuth: "Token de acceso"
        ServAuth-->>ProvAuth: "Login exitoso"
        deactivate ServAuth
      
        ProvAuth-->>PantallaAuth: "Navegar a inicio"
    else "RFC no existe o usuario prefiere contraseña"
        ProvAuth-->>PantallaAuth: "Mostrar formulario login"
        PantallaAuth-->>Usuario: "Campos RFC y contraseña"
      
        Usuario->>PantallaAuth: "Ingresa credenciales"
        PantallaAuth->>ProvAuth: "iniciarSesion()"
        ProvAuth->>ServAuth: "iniciarSesion(rfc, pass, false)"
        activate ServAuth
        ServAuth->>API: "POST /api/zuul/auth/nam/token"
      
        alt "Credenciales válidas"
            API-->>ServAuth: "Token de acceso"
            ServAuth->>SecureStorage: "Guarda token y datos"
            ServAuth-->>ProvAuth: "Login exitoso"
            ProvAuth-->>PantallaAuth: "Navegar a inicio"
        else "Credenciales inválidas"
            API-->>ServAuth: "Error 401"
            ServAuth-->>ProvAuth: "Error de autenticación"
            ProvAuth-->>PantallaAuth: "Mostrar error"
            PantallaAuth-->>Usuario: "Mensaje de error"
        end
        deactivate ServAuth
    end
  
    deactivate ProvAuth
    deactivate PantallaAuth
```

## 3. Flujo de Generación de Factura (Mermaid)

Diagrama que detalla el proceso completo de creación y timbrado de una factura.

```mermaid
sequenceDiagram
    participant Usuario
    participant PantallaFactura as "PantallaAgregarFactura"
    participant ProvFactura as "ProveedorFactura"
    participant ServComprobante as "ServicioComprobante"
    participant PantallaFirma as "PantallaFirma"
    participant API as "Backend API"

    Usuario->>PantallaFactura: "Llena formulario de factura"
    activate PantallaFactura
  
    Usuario->>PantallaFactura: "Presiona 'Generar Factura'"
    PantallaFactura->>ProvFactura: "_firmarFactura()"
    activate ProvFactura
  
    ProvFactura->>ProvFactura: "Validar formulario"
  
    alt "Formulario válido"
        ProvFactura->>ServComprobante: "validaXml(modeloFactura)"
        activate ServComprobante
        ServComprobante->>API: "POST /genera-cfdi/v2/valida-xml"
      
        alt "Validación exitosa"
            API-->>ServComprobante: "Cadena original generada"
            ServComprobante-->>ProvFactura: "ValidacionXml exitosa"
            deactivate ServComprobante
          
            ProvFactura->>PantallaFactura: "Navegar a PantallaFirma"
            PantallaFactura->>PantallaFirma: "Mostrar UI de firma"
            activate PantallaFirma
          
            Usuario->>PantallaFirma: "Selecciona archivos .cer y .key"
            Usuario->>PantallaFirma: "Ingresa contraseña de clave privada"
            PantallaFirma->>PantallaFirma: "Genera firma digital"
            PantallaFirma-->>PantallaFactura: "Retorna ModeloFirma"
            deactivate PantallaFirma
          
            PantallaFactura->>ProvFactura: "Continuar con timbrado"
            ProvFactura->>ServComprobante: "timbrarXml(modeloFactura, modeloFirma)"
            activate ServComprobante
            ServComprobante->>API: "POST /genera-cfdi/v2/timbrarXml"
          
            alt "Timbrado exitoso"
                API-->>ServComprobante: "CFDI timbrado con UUID"
                ServComprobante-->>ProvFactura: "ResponseProcesarFactura exitosa"
                ProvFactura-->>PantallaFactura: "Mostrar diálogo de éxito"
                PantallaFactura-->>Usuario: "'Factura generada exitosamente'"
            else "Error en timbrado"
                API-->>ServComprobante: "Error del PAC"
                ServComprobante-->>ProvFactura: "Error de timbrado"
                ProvFactura-->>PantallaFactura: "Mostrar error"
                PantallaFactura-->>Usuario: "Mensaje de error específico"
            end
            deactivate ServComprobante
        else "Error en validación"
            API-->>ServComprobante: "Lista de errores de validación"
            ServComprobante-->>ProvFactura: "Errores de estructura CFDI"
            ProvFactura-->>PantallaFactura: "Mostrar errores"
            PantallaFactura-->>Usuario: "Lista de campos a corregir"
        end
    else "Formulario inválido"
        ProvFactura-->>PantallaFactura: "Errores de validación local"
        PantallaFactura-->>Usuario: "Resaltar campos con errores"
    end
  
    deactivate ProvFactura
    deactivate PantallaFactura
```

## 4. Gestión de Estado con Provider (Mermaid)

Diagrama que ilustra cómo fluye el estado en la aplicación usando el patrón Provider.

```mermaid
graph TD
    subgraph "UI Components"
        A["Widget Consumer"]
        B["Widget Selector"]
        C["Widget Builder"]
    end
  
    subgraph "Provider Layer"
        D["ChangeNotifier Provider"]
        E["Estado Interno"]
        F["Métodos Públicos"]
        G["notifyListeners()"]
    end
  
    subgraph "Service Layer"
        H["HTTP Service"]
        I["Local Storage"]
    end
  
    A -->|"context.watch<Provider>()"| D
    B -->|"context.select<Provider>()"| D
    C -->|"context.read<Provider>().method()"| F
  
    F --> E
    F --> H
    F --> I
  
    E --> G
    G -->|"Rebuilds UI"| A
    G -->|"Rebuilds UI"| B
    G -->|"Rebuilds UI"| C
  
    H -->|"API Response"| F
    I -->|"Stored Data"| F
```

## 5. Arquitectura de Servicios y API (PlantUML)

Diagrama que muestra la organización de servicios y su comunicación con el backend.

```plantuml
@startuml
!theme cerulean-outline

package "Frontend Services" {
  class ServicioAutenticacion {
    +iniciarSesion(rfc, password, biometrico)
    +cerrarSesion()
    +refrescarToken()
    +getDatosUsuario()
    -_keyToken: String
    -_keyRefreshToken: String
  }
  
  class ServicioComprobante {
    +validaXml(ModeloFactura)
    +validaCertificado(ModeloFactura, ModeloFirma)
    +timbrarXml(ModeloFactura, ModeloFirma)
    +getUuidCartaPorte()
    -_buildComprobante()
  }
  
  class ServicioConsultaFactura {
    +consultarCfdi(RequestConsultaCfdi, FacturaEnum)
    +descargarCfdi(RequestDescargaCfdi, TipoDescargaEnum)
    +crearArchivoDesdeCadena(String, TipoDescargaEnum)
  }
  
  class ServicioFrecuentes {
    +obtenerFrecuentes()
    +guardaClienteFrecuente(Receptor)
    +validaClienteFrecuente(Receptor)
    +borrarClienteFrecuente(String)
  }
}

package "Backend API Endpoints" {
  interface AuthAPI {
    POST /api/zuul/auth/nam/token
    POST /api/zuul/auth/nam/logout
    POST /api/zuul/auth/nam/refresh/token
  }
  
  interface FacturaAPI {
    POST /genera-cfdi/v2/valida-xml
    POST /genera-cfdi/v2/timbrarXml
    POST /facturas/consultaCfdi
    POST /ri/obtenerPdf
    POST /ri/obtenerXml
  }
  
  interface ClientesAPI {
    GET /frecuentes
    POST /frecuentes
    DELETE /frecuentes/{id}
  }
}

ServicioAutenticacion --> AuthAPI
ServicioComprobante --> FacturaAPI
ServicioConsultaFactura --> FacturaAPI
ServicioFrecuentes --> ClientesAPI

@enduml
```

## 6. Modelo de Datos Completo (PlantUML)

Diagrama de clases que muestra la estructura completa de los modelos principales y sus relaciones.

```plantuml
@startuml
!theme aws-orange

class ModeloFactura {
  +fechaEmision: DateTime
  +horaEmision: TimeOfDay
  +tipoComprobante: TipoComprobanteEnum
  +esFacturaGlobal: bool
  +cliente: ModeloClienteFrecuente?
  +conceptos: List<ModeloConcepto>
  +informacionPago: ModeloInformacionPago
  +regimenFiscal: ModeloCatalogo?
  +lugarExpedicion: ModeloCatalogo?
  +listaImpuestosFactura: List<ModeloImpuestoFactura>
}

class ModeloClienteFrecuente {
  +rfc: String?
  +nombre: String?
  +tipoPersona: int
  +cp: String?
  +correo: String?
  +regimen: String?
  +claveRegimen: String?
  +usoFactura: String?
  +claveUsoFactura: String?
}

class ModeloConcepto {
  +concepto: String?
  +descConcepto: String?
  +unidad: String?
  +descUnidad: String?
  +cantidad: Decimal
  +valorUnitario: Decimal
  +importe: Decimal
  +descuento: Decimal
  +objetoImpuesto: ModeloCatalogo?
  +traslados: List<ModeloImpuesto>
  +retenciones: List<ModeloImpuesto>
  +esCuentaTercero: bool
}

class ModeloInformacionPago {
  +metodoPago: ModeloCatalogo?
  +formaPago: ModeloCatalogo?
  +condicionesPago: String?
  +moneda: ModeloCatalogo?
  +tipoCambio: String?
}

class ModeloImpuesto {
  +base: Decimal
  +impuesto: String?
  +tipoFactor: String?
  +tasaOCuota: String?
  +importe: String?
}

class ModeloCatalogo {
  +clave: String?
  +descripcion: String?
  +vigenciaDesde: String?
  +vigenciaHasta: String?
}

class ModeloDatosUsuario {
  +rfc: String
  +nombreCompleto: String
  +tipoPersona: String
  +puedeFacturar: bool
  +regimenes: List<Regimen>
  +codigosPostales: List<CodigoPostal>
  +correoElectronico: String?
}

ModeloFactura "1" *-- "0..1" ModeloClienteFrecuente
ModeloFactura "1" *-- "*" ModeloConcepto
ModeloFactura "1" *-- "1" ModeloInformacionPago
ModeloConcepto "1" *-- "*" ModeloImpuesto
ModeloInformacionPago "1" *-- "0..1" ModeloCatalogo

@enduml
```

## 7. Flujo de Navegación de la Aplicación (Mermaid)

Diagrama que muestra las rutas y la navegación entre pantallas principales.

```mermaid
graph TD
    A["PantallaAutenticacion"] -->|"Login exitoso"| B["PantallaInicio"]
  
    B --> C["MenuLateral"]
    B --> D["MenuFlotante"]
  
    C -->|"Consultas"| E["PantallaFiltrosBusqueda"]
    C -->|"Clientes frecuentes"| F["PantallaClientesFrecuentes"]
    C -->|"Ayuda"| G["PantallaAyuda"]
    C -->|"Acerca de"| H["PantallaAcerca"]
    C -->|"Cerrar sesión"| A
  
    D -->|"Mostrar QR"| I["PantallaGenerarCodigoQR"]
    D -->|"Generar factura"| J["PantallaAgregarFactura"]
    D -->|"Agregar cliente"| K["PantallaAgregarClienteFrecuente"]
  
    E -->|"Buscar"| L["PantallaResultadoFactura"]
  
    F -->|"Agregar"| K
    F -->|"Editar"| M["PantallaEditarClienteFrecuente"]
  
    J -->|"Seleccionar plantilla"| N["PantallaPlantillasFactura"]
    J -->|"Firmar"| O["PantallaFirma"]
  
    K -->|"Guardar"| F
    M -->|"Actualizar"| F
  
    L -->|"Descargar PDF/XML"| P["Sistema de archivos local"]
```

## 8. Manejo de Errores y Estados de Carga (Mermaid)

Diagrama que ilustra cómo se manejan los diferentes estados de la aplicación.

```mermaid
stateDiagram-v2
    [*] --> Inicial
  
    Inicial --> Cargando : Usuario inicia acción
    Cargando --> Exitoso : Operación completada
    Cargando --> Error : Fallo en operación
  
    Exitoso --> [*] : Mostrar resultado
    Error --> Inicial : Usuario reintenta
  
    state Cargando {
        [*] --> MostrandoSpinner
        MostrandoSpinner --> LlamandoAPI
        LlamandoAPI --> ProcesandoRespuesta
        ProcesandoRespuesta --> [*]
    }
  
    state Error {
        [*] --> TipoError
        TipoError --> ErrorRed : Sin conexión
        TipoError --> ErrorValidacion : Datos inválidos
        TipoError --> ErrorServidor : Error interno
    
        ErrorRed --> [*] : SnackBar mostrado
        ErrorValidacion --> [*] : Campos resaltados
        ErrorServidor --> [*] : SnackBar mostrado
    }
```
