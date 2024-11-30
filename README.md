# Mi Reclamo

Proyecto creado para la asignatura Computación Móvil de la Universidad Tecnológica Metropolitana.

## COMPUTACION MOVIL
**Docente**: Sebastian Salazar Molina.

**Seccion**: 301 - EFE68500.

**Fecha**: 30/11/2024.


## Integrantes

- Tomas Lillo Silva
- Gabriel González Núñez


## Descripción de la Aplicación para Gestión de Reclamos

Esta aplicación móvil esta desarrollada en Flutter con la version 3.24.3,
está diseñada para gestionar y resolver los reclamos, sugerencias e información generados por los estudiantes de la Universidad Tecnológica Metropolitana - UTEM a traves de solicitudes llamadas **tickets**.
A través de la Oficina de Información, Reclamos y Sugerencias - OIRS.
La aplicación interactúa directamente con la API de OIRS UTEM para gestionar los **tickets** de información, reclamos y sugerencias.

### Funcionalidades de la Aplicación

- **Ver los Tickets**: Acceder a una lista de los tickets registrados y visualizarlos de manera detallada.
- **Responder el estado de los Tickets**: Modificar el estado de un Ticket en funcion al trabajo que se realiza para el reclamo, sugerencia o comentario.
- **Responder los Tickets**: Los estudiantes pueden responder a las consultas o comentarios adicionales relacionados con sus tickets.

# Guia de instalacion

## Requisitos
Asegúrate de tener los siguientes requisitos previos instalados en tu máquina:
- **Flutter SDK**: Debes tener Flutter instalado con la version minima de `dart: 3.5.1`.
- **Android Studio**: Para emular o ejecutar la aplicación en dispositivos Android, necesitas tener Android Studio instalado.
- **Git**: Debes tener Git instalado para clonar el repositorio.

## Clonar el repositorio

La version final que sera desplegada a produccion se encuentra en la rama `Mi-Reclamo` de este repositorio.

````

git clone -b Mi-Reclamo https://github.com/XhrdTLS/MiReclamo.git

````

## Instalar dependencias
Una vez clonado el proyecto se necesita instalar las dependencias de Flutter.
Esto se hace navegando a la carpeta `app` mediante el terminal y corriendo el comando `flutter pub get`.

````
cd MiReclamo/app

flutter pub get
````

## Correr la aplicación
Para correr la aplicación se necesita tener un emulador de Android o un dispositivo físico conectado.
Una vez que se tenga el emulador o dispositivo conectado se puede correr la aplicación con el comando `flutter run` desde la ubicacion anterior `MiReclamo/app`.

````
flutter run
````


