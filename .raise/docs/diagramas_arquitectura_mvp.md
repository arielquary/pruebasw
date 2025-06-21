---
document_id: "TEC-FMV-FRONT-002"
title: "Diagramas de Arquitectura y Flujo: Implementación del MVP"
project_name: "Factura Móvil App (Frontend)"
feature_us_ref: ".raise/docs/auditoria_mvp_existente.md"
version: "1.0"
date: "2024-07-26"
author: "RAISE Tech Lead"
status: "Final"
---

# Diagramas de Arquitectura: MVP de Factura Móvil

Este documento contiene una serie de diagramas generados con PlantUML y Mermaid que visualizan la arquitectura y los flujos de datos de la implementación actual del MVP, basándose en los hallazgos del documento de auditoría `.raise/docs/auditoria_mvp_existente.md`.

## 1. Diagrama de Componentes de Alto Nivel (PlantUML)

Este diagrama ilustra la arquitectura por capas de la aplicación, mostrando cómo los componentes principales interactúan entre sí, desde la interfaz de usuario hasta el backend.

```plantuml
@startuml
!theme spacelab

package "Factura Móvil App (Flutter)" {
  !define ICONURL https://raw.githubusercontent.com/tupadr3/plantuml-icon-font-sprites/v2.4.0
  !includeurl ICONURL/common.puml
  !includeurl ICONURL/devicons/flutter.puml
  !includeurl ICONURL/devicons/database.puml
  !includeurl ICONURL/font-awesome-5/server.puml
  !includeurl ICONURL/font-awesome-5/user_lock.puml

  rectangle "UI (Screens & Widgets)" as UI <<DEV_FLUTTER>>
  rectangle "State Management (Providers)" as Providers
  rectangle "Business Logic (Services)" as Services
  rectangle "Data Models" as Models

  UI --> Providers : "Observa y llama a métodos"
  Providers ..> Models : "Gestiona estado de"
  Providers --> Services : "Delega lógica de negocio"
  Services ..> Models : "Usa como DTOs"
}

cloud "Backend API" as Backend <<FA5_SERVER>>
database "Secure Storage" as SecureStorage <<DEV_DATABASE>>
actor "Usuario" as User

User -> UI : "Interactúa"
Services -> Backend : "Llamadas HTTP (REST)"
Services -> SecureStorage : "Guarda/Lee Tokens"

@enduml
```

---

## 2. Diagrama de Secuencia: Generación y Timbrado de Factura (PlantUML)

Este diagrama detalla el flujo de interacciones dinámicas que ocurren cuando un usuario genera y timbra una nueva factura. Muestra la orquestación entre la UI, los proveedores, los servicios y el backend.

```plantuml
@startuml
!theme materia
autonumber

actor Usuario

box "Frontend (Flutter)" #LightBlue
  participant "PantallaAgregarFactura" as Pantalla
  participant "ProveedorFactura" as Provider
  participant "ServicioComprobante" as Service
  participant "PantallaFirma" as FirmaUI
end box

participant "Backend API" as API

Usuario -> Pantalla: Presiona "Generar Factura"
Pantalla -> Provider: Llama a `firmarFactura()`
Provider -> Service: Llama a `validaXml(modelo)`
Service -> API: `POST /genera-cfdi/v2/valida-xml`
API --> Service: Retorna `(cadenaOriginal)`
Service --> Provider: Retorna `(cadenaOriginal)`
Provider --> Pantalla: Navega a la pantalla de firma

Pantalla -> FirmaUI: Muestra UI para firma
Usuario -> FirmaUI: Ingresa .key, .cer, contraseña
FirmaUI --> Pantalla: Retorna `(firma, certificado)`

Pantalla -> Provider: Continúa proceso con la firma
Provider -> Service: Llama a `timbrarXml(modeloConFirma)`
Service -> API: `POST /genera-cfdi/v2/timbrarXml`
API --> Service: Retorna `(CFDI Timbrado)`
Service --> Provider: Retorna `(CFDI Timbrado)`
Provider --> Pantalla: Muestra diálogo de éxito
Pantalla --> Usuario: Notifica "Factura generada"

@enduml
```

---

## 3. Diagrama de Clases: Modelos de Datos Principales (PlantUML)

Este diagrama muestra la estructura de los modelos de datos más importantes de la aplicación y sus relaciones.

```plantuml
@startuml
!theme plain

class ModeloFactura {
  + cliente: ModeloClienteFrecuente
  + conceptos: List<ModeloConcepto>
  + informacionPago: ModeloInformacionPago
  + fechaEmision: DateTime
  + tipoComprobante: TipoComprobanteEnum
}

class ModeloClienteFrecuente {
  + rfc: String
  + nombre: String
  + cp: String
  + correo: String
  + claveRegimen: String
  + claveUsoFactura: String
}

class ModeloConcepto {
  + descripcion: String
  + valorUnitario: Decimal
  + importe: Decimal
  + claveProdServ: String
  + traslados: List<ModeloImpuesto>
  + retenciones: List<ModeloImpuesto>
}

class ModeloImpuesto {
    + base: Decimal
    + impuesto: String
    + tipoFactor: String
    + tasaOCuota: String
    + importe: String
}

ModeloFactura "1" *-- "1" ModeloClienteFrecuente
ModeloFactura "1" *-- "*" ModeloConcepto
ModeloConcepto "1" *-- "*" ModeloImpuesto

@enduml
```

---

## 4. Diagrama de Flujo: Autenticación de Usuario (Mermaid)

Este diagrama de flujo describe el proceso de decisión que sigue la aplicación para autenticar a un usuario, incluyendo la opción de biometría.

```mermaid
graph TD
    A[Inicio en PantallaAutenticacion] --> B{¿Hay RFC guardado?};
    B -- Sí --> C{¿Biometría habilitada y configurada?};
    B -- No --> D[Mostrar formulario RFC + Contraseña];

    C -- Sí --> E[Mostrar UI de Login Biométrico];
    C -- No --> F[Mostrar formulario con RFC y Contraseña];

    E --> G{Usuario elige usar contraseña?};
    G -- Sí --> F;
    G -- No --> H[Pide autenticación biométrica];

    H --> I{¿Autenticación exitosa?};
    I -- Sí --> K[Login automático con credenciales guardadas];
    I -- No --> E;
    
    F --> J[Usuario ingresa Contraseña y presiona Login];
    D --> J;

    K --> L{¿Login en backend exitoso?};
    J --> L;

    L -- Sí --> M[Navegar a PantallaInicio];
    L -- No --> N[Mostrar error de credenciales];
    N --> F;
``` 