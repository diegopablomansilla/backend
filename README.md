# GeoObject
Proyecto de implementacion de webservices REST para el sistema kuntur. 

## Configuración
Crear archivo de configuración en **/etc/nodejs-config/kuntur.json** con formato JSON.

Ejemplo:
>`{
>		"port" :8080,
>		"host" :"localhost", 
>		"pg":{
>			"user":"postgres",
>			"pass":"postgres",
>			"host":"localhost",
>			"db"  :"my_db",
>			"port":5432
>			}
>}`

Instalar modulos de Node dentro del proyecto

`$ npm install`

## Ejecutar
Ejecutar el proyecto mediante

`$ node server.js`

