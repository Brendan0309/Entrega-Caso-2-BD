# Entrega-Caso-2-BD

Nombre de los integrantes

-Brendan Ramírez Campos

<hr>

Diseño Actualizado de la base de datos: [DIagramadelabasefinal.pdf](./DIagramadelabasefinal.pdf)<br>


Script de Creación de la base de datos:
-Archivo .SQL:[ScriptCreación.sql](./ScriptCreación.sql)<br>


Script para llenar la base de datos:
-Archivo .SQL: 	[Poblacion.sql](./Poblacion.sql)<br>

Script para las consultas:
-Arhivo .SQL:

<hr>

# Consultas solicitadas


<hr>

#Lista de entidades

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
	- nombre  
	- lenguaje  
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

<hr>
#Seguridad de la base
Pequeña documentación: [Seguridad Bases.pdf](./SeguridadBases.pdf)<br>



<hr>
#Migracion SSIS (para la creacion de tablas nuevas, para migrar en tablas ya hechas se uso pandas)
Pequeña documentación: 



   


