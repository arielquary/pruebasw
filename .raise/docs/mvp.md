> ARG:
> MVP1 - Emisión facturas ingreso y consultas.
> Factura Móvil
> Epic
> 2848
> Created by PEDRO LOPEZ BERNAL
> 06 Jan 2022 19:23
> PEDRO LOPEZ BERNAL
> 🎯 Yo COMO contribuyente QUIERO contar con una aplicación nativa para dispositivos móviles para la generación de Comprobante Fiscal Digital por Internet (CFDI)  PARA facilitarme el cumplimiento de mis obligaciones fiscales en relación a la emisión de facturas, así como ayudarme a conocer mis facturas emitidas o recibidas y mis datos fiscales.

💎CRITERIOS DE ACEPTACIÓN 💎

Debe funcionar para todos los contribuyentes, ya sean personas físicas o morales. El acceso será mediante RFC y contraseña de los servicios del SAT.

La aplicación debe permitir al contribuyente consultar dos opciones de menú. Un Menú Principal y un Menú Flotante con las opciones de uso más frecuentes.

El Menú principal incluirá las siguientes opciones: 1. Facturas 2. Clientes frecuentes 3. Ayuda 4. Acerca de

El Menú flotante incluirá la opción: 5. Mostrar QR 6. Generar factura 7. Agregar cliente 8. Cerrar sesión

La aplicación cuenta con una opción que permite terminar la sesión. Adicionalmente tras un periodo de inactividad (Definido por las prácticas de seguridad del SAT) la aplicación debe cerrar la sesión en automático.

La aplicación debe contar con una opción para gestionar a los clientes favoritos. Permitirá agregar un máximo de 15 clientes y se deberá poder editar la información de los mismos, así como eliminar clientes de la lista, en caso de requerirse. Los datos que se almacenarán de cada cliente favorito serán los siguientes: 1. RFC (alfanumérico y solo letras mayúsculas). 2. Nombre/ Denominación o Razón social (campo obligatorio/ alfanumérico). 3. Código Postal (solo debe permitir 5 caracteres). 4. Uso de la factura; Para el caso de la clave S01 “Sin efectos fiscales” solo se podrá usar para los siguientes casos:  a. Factura Global. b. En el caso de que se emita un CFDI a un residente en el extranjero con RFC genérico.  5. Correo electrónico. Las validaciones a realizar son:

El RFC debe estar en la L_RFC.

El nombre o Razón social debe coincidir con el registrado en la L_RFC.

El C.P. debe coincidir con el registrado en la L_RFC.

Se debe consultar la L_RFC más reciente.

Permitirá el uso de los RFC genéricos.

Público en general: XAXX010101000

Cuando se utilice el RFC de público en general, se deberá incorporar un check box con la leyenda y tooltip “Es una factura global”, para indicar que se emite una factura global, y en caso de que sea se deberá incorporar el nodo y los atributos de la información global.

Permitirá facturar con el RFC para Extranjero: XEXX010101000.

Permitirá la lectura del código QR del receptor, con la finalidad de obtener y guardar la información.

Debe permitir la administración por parte del contribuyente sobre los catálogos favoritos de los siguientes rubros:

Regímenes (selección o modificación de favoritos)

Productos y servicios (Conforme actividades económicas)

Clave Unidad

Moneda

Forma de pago

Uso de CFDI

Cuenta Predial

La aplicación generará un código QR con la información que contiene la Cédula de Identificación Fiscal y el correo electrónico. • Nombre • RFC • Código Postal • Correo electrónico Este código QR podrá ser leído por otro dispositivo que tenga instalada la app de factura móvil, con la finalidad de poblar la información del cliente (receptor) en la factura.

La aplicación deberá permitir generar plantillas de facturas, con la finalidad de que el contribuyente pueda facturar con mayor rapidez.

La aplicación deberá permitir consultar facturas vigentes emitidas, recibidas. Se debe poder filtrar por el tipo de consulta la cual puede ser por periodo (Sólo ejercicio fiscal y el último mes del ejercicio inmediato anterior) o en su caso, por la combinación de emisor y receptor; o bien, folio (UUID). La aplicación debe permitir mostrar el resultado de la búsqueda en una relación de las mismas, a efecto de que el contribuyente seleccione la(s) factura(s) de su interés, de las cuales podrá descargar o compartir los archivos XML, PDF.

> ARG:
> Se requiere que el contribuyente pueda consultar la opción “Acerca de”, que permita, conocer la información relacionada con: • La versión de la app. • Los Términos y condiciones. y • Las políticas de privacidad.

La aplicación debe de tener una opción que ayude al contribuyente con el uso de la aplicación móvil. Se sugiere que pueda ser del carácter “?”que se muestren mensajes de orientación y facilitar el llenado de la factura.

Al dar clic en el botón “Generar Factura”, la aplicación debe identificar si existen plantillas almacenadas y en su caso mostrar un pop up con la pregunta “¿Deseas utilizar una plantilla?” con las opciones “Sí” y “No”; en caso afirmativo, la aplicación debe mostrar el listado de plantillas, en caso contrario se debe poder emitir una factura de ingreso con las siguientes consideraciones.

Datos del Receptor. La aplicación debe contar con la funcionalidad para leer el QR  que se genera dentro de la aplicación a efecto de que con ello comience el proceso de emisión del CFDI; es decir, se abrirá la pantalla del llenado del CFDI y la información del receptor se poblará en automático. Asimismo, dará la posibilidad de incluir un nuevo RFC en caso de que sea diferente a los frecuentes. En caso de que en el proceso de emisión no se haya comenzado con la lectura del QR de la CIF, los clientes almacenados deberán desplegarse en el campo del RFC del receptor con el fin de que el emisor seleccione el que corresponda y los campos se poblaran en automático.

Datos Generales. En automático se poblarán los datos del emisor.

Conceptos. Se mostrará un apartado para la selección de los conceptos, que incluirá catálogos reducidos y que el emisor podrá realizar una selección de favoritos  para facilitar su selección al momento de generar su factura.  Una vez seleccionado el concepto, se capturará la cantidad y se calcularán los importes (subtotal y total) e impuestos de conformidad con la Matriz de Impuestos por Producto (MIP). Permitirá incluir productos o servicios, costos e impuestos en caso de que decida adicionar un nuevo concepto que no había configurado previamente o no esté considerado dentro de la MIP

Complementos La app en esta versión del producto no incluirá complementos.

Guardar. La aplicación permitirá almacenar una factura sin timbrar o bien, como una plantilla.

Timbrar Factura Una vez que el contribuyente haya concluido la captura del comprobante, la aplicación permitirá el sellado conforme al anexo 20 de la RMF de acuerdo a lo siguiente: • Generar el XML conforme al anexo 20 para su envío al servicio de timbrado. • Recibir del servicio de timbrado, el timbre correspondiente y agregándolo al XML de la factura; el timbrado puede ser realizado con certificado del contribuyente. • Generar la representación impresa del comprobante.

Descargar o compartir Al finalizar los pasos previos, se brindará la opción para compartir tanto el XML como el PDF, por los mecanismos que permita el dispositivo móvil.

Se deberán cumplir las siguientes CONSIDERACIONES GENERALES: • La aplicación permitirá la identificación de las facturas que fueron emitidas por la app Factura Móvil. • El contribuyente deberá poder cambiar de dispositivo y consultar la información de manera transparente. • La aplicación debe contar con un diseño responsivo (considerando rotación del dispositivo), donde se muestre proporcionalmente al tamaño del dispositivo que se encuentre instalada. • Debe considerarse la definición de la interfaz de usuario, con la finalidad de mejorar la experiencia de usuario tomando como base los estándares y lineamientos gráficos Institucionales para aplicativos móviles, que definan en conjunto con el área de Comunicación Institucional. • Se debe considerar el desarrollo de la app para dispositivos móviles con sistema operativo Android, así como IOS en sus versiones más recientes.
