# Resolucion de Challenge para Gran Data

## Descripción
En este proyecto se resuelven 3 consignas practicas de desarrollo y codigo y 3 preguntas generales

## Instrucciones para Ejecutar el Proyecto
- Clonar el Repositorio o descomprimir rar, luego levantar la imagen de docker y esperar aplica el siguiente comando en la consola : 

    docker-compose up --build  

- Una vez terminado de instalar las dependencias y cuando la sesion de Ubunto este activa dirigete al link que figura en la consola para poder ingresar al servicio de Jupyter Notebook que te redireccionara al Explorador por el puerto 8888 . Una vez dentro dirigete a la ruta : 127.0.0.1:8888/notebooks/challenge.ipynb

- Ya dentro del file: challenge.ipynb, inicialmente ejecuta solo la primera celda para confirmar el requisito tecnico principal :
        Versión de Python : !python3 --version

        Versión de PySpark  import pyspark
                            print(pyspark.__version__)

Tiene que tener el siguiente ouput : Python 3.6 y Pyspark 3.2

Si es asi, ya puedes ejecutar el resto de celdas o todo el notebook completamente. 
Una vez terminado debes tener como salida en cada selda lo siguiente :


## Paso 1: Monto Total a Facturar
El monto total a facturar por el proveedor por SMS es: **$X,XXX.XX**.

## Paso 2: Dataset Generado
El dataset con los 100 clientes con mayor facturación ha sido generado y guardado en formato Parquet. La ruta a los archivos:
- [max_billing.parquet](datasets/output/max_billing) 

## Paso 3: Histograma de Llamadas por Hora
El histograma de llamadas por hora se generó y guardó como una imagen en formato PNG. La ruta al grafico es la siguiente:
![Histograma](datasets/output/histograma_llamadas.png)


- Una vez terminada la  ultima celda y guardado el grafico ,la sesion se Spark se cerrara, pero el servicio de jupyter sigue activo, para terminarlo, se debera volver a la consola del servicio y precionar Ctrol + C , y luego ejecutar el comando  :
             docker-compose down


             


