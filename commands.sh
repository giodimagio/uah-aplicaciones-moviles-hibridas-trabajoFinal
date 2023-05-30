#!/bin/bash

#################### Comandos usados en el proyecto ####################

# ------------------ Desarrollo ------------------ #

    ## Ionic - Comandos

        ### Instalar Ionic CLI globalmente
        npm install -g @ionic/cli

        ### Crear un nuevo proyecto Ionic en blanco con Vue y Capacitor
        ionic start uah-aplicaciones-moviles-hibridas-trabajoFinal blank --type=vue --capacitor

        ### Instalar dependencias
        npm install

        ### Levantar el servidor de desarrollo
        ionic serve

        ### Agregar la parte nativa de Android
        ionic capacitor add android

        ### Compilar la parte web de la aplicación
        npm run build