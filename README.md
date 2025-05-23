# Entrega-Caso-2-BD

Integrantes:
- Brendan Ramírez Campos
- Victor Andrés Fung Chiong
- Giovanni Esquivel Cortés
- Andrés Baldi Mora

## Archivos

Diseño Actualizado de la base de datos: [DIagramadelabasefinal.pdf](./DIagramadelabasefinal.pdf)<br>

Script de Creación de la BD:
-Archivo .SQL: [ScriptCreación.sql](./ScriptCreacion.sql)<br>

Script de Llenado de la BD:
-Archivo .SQL: [Poblacion.sql](./Poblacion.sql)<br>

Consultas T-SQL y Misceláneas:
-Archivo .SQL: [ConsultasMiscelaneas.sql](./ConsultasMiscelaneas.sql)<br>

Factores de Seguridad:
Pequeña documentación: [SeguridadBases.pdf](./SeguridadBases.pdf)<br>

Migracion SSIS (para la creacion de tablas nuevas, para migrar en tablas ya hechas se uso pandas)
- Pequeña documentación: [MigracionTablasNuevas.pdf](./Migraciontablasnuevas.pdf)<br>


## Consultas solicitadas


<details>

<summary>
	Lista de entidades
</summary>

<br>

- Personas  
- Usuarios  
	- Contraseña  
	- Habilitado  
	- Compañías (Opcional)  
- Información de contacto del usuario   
	- Tipo (correo, teléfono, fax)  
	- Última actualización  
- Países  
- States  
	- Código Postal  
	- Posición geográfica  
- Ciudades  
- Tipo de usuario de la conexión (usuario, compañía)  
- Módulos  
	- Nombre  
	- Lenguaje  
- Suscripciones  
	- Precio
  - Planes 
	- Detalles
  - Restricciones (Lugar y tiempo)
	- Características  
		- Nombre  
		- Límites
    - Promociones
- Pagos registrados   
- Fecha de expiración  
- Monto  
- Habilitado  
- Moneda utilizada  
- Tipo servicio  
- Servicios de Pago  
- Vinculación de redeem 
	- QR
	- Tiempo de expiración  
- Métodos de Pago  
- Pagos  
	- Medio  
	- Monto  
	- Moneda Utilizada  
	- Ritmo de Conversión  
	- Fecha 
- Compañías  
- Roles (compañía, usuarios)  
- Permisos  
- Subscripciones  
- Moneda  
- Símbolos  
- Alias  
- Nombre  
- Símbolo  
- Conversiones  
	- Fecha  
	- Es la actual  
	- Monto de cambio  
- Historial (captura detalles del servicio entre otros datos además de la frecuencia y algún tipo de preferencia)  
- Logs  
	- Tipo  
	- Referencias 1 y 2  
	- Valores de la referencia  
	- Fuente  
	- Severidad  
- Media (fotos
	- Tipo  
		- Nombre  
		- Reproductor  
	- Archivos  
		- URL (para fotos y videos)  
		- Borrado  
		- Usuario perteneciente  
		- Fecha de generación   
- Idioma  
- Traduccion  
- Slangs  
- Nombre    
- Contratos con instituciones asociadas
 - Beneficios
  - Tipos
 - Limites
 - Renovaciones
 - Direccion
 - Obligaciones

</details>

<details>
	<summary>
		Lista de entidades mongodb
	</summary>

<br>

- _id

- clienteId

- nombre

- descripcion

- precioMensual

- beneficios (array of strings)

- categoria

- marketing (object)

	- mensajePrincipal

	- publicoObjetivo (array of strings)

	- canales (array of strings)

- media (array of objects)

	- tipo

	- url

	- descripcion

- paquete (string, name of the package)

- calificacion (number)

- comentario

- fecha

- resaltado (boolean)

- respuestas (array of objects)

	- nombre

	- fecha

	- comentario

- canalContacto

- infoContacto

- fechaContacto

- motivoContacto

- agenteAsignado

- estado

- notas

- fechaRecepcion

- detalle

- canalRecepcion

- infoRecepcion

- accionesTomadas (array of strings)

- fechaResolucion

- agenteResponsable

- satisfaccionCliente

- fechaCreacion

- historial (array of objects)

	- fecha

	- accion

</details>




   


