# README - Geo API

## Introducción

Este proyecto backend es una API desarrollada en Ruby on Rails que permite obtener y persistir datos sismológicos desde el sitio USGS (United States Geological Survey). La API proporciona endpoints para acceder a la información de eventos sismológicos y crear comentarios asociados a cada evento.

Además, se ha implementado una tarea (Task) que se encarga de obtener periódicamente los datos sismológicos desde el feed "Past 30 days" de USGS y persistirlos en la base de datos del proyecto.

## Instrucciones de ejecución

### Requisitos previos

- Ruby (versión 3.2.3)
- Ruby on Rails (versión 7.1.3)

### Pasos para ejecutar el proyecto

1. Clonar el repositorio:

```bash
git clone [<URL_DEL_REPOSITORIO>](https://github.com/ElHurta/geo-api)
```

2. Navegar al directorio del proyecto:

```bash
cd geo-api
```

3. Instalar las dependencias:

```bash
bundle install
```

4. Ejecutar las migraciones:
    
```bash
rails db:migrate
```

5. Iniciar el servidor:

```bash
rails server
```
La API estará disponible en http://localhost:3000.

## Ejecutar la Task
La Task se encarga de obtener y persistir los datos sismológicos desde el feed "Past 30 days" de USGS. Para ejecutar la Task, sigue estos pasos:

1. Abre una nueva terminal y navega al directorio del proyecto.
2. Ejecuta el siguiente comando:

```bash
rails fetch_earthquakes:fetch
```

Esto iniciará la Task y comenzará a obtener los datos sismológicos desde USGS. Los datos se persistirán en la base de datos del proyecto. La Task se puede programar para que se ejecute periódicamente utilizando alguna herramienta de programación de tareas, como cron o whenever.

## Endpoints de la API
La API proporciona los siguientes endpoints:

* GET /api/v1/features: Obtiene una lista de eventos sismológicos con paginación y filtros.
* GET /api/v1/features/:id: Obtiene los detalles de un evento sismológico específico.
* POST /api/v1/features/:id/comments: Crea un comentario asociado a un evento sismológico.