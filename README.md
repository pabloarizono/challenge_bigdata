# Resolucion de Challenge para Gran Data

## Descripción
En este proyecto se resuelven 3 consignas practicas de desarrollo y codigo y tres items con preguntas generales :



## Instrucciones para Ejecutar el Proyecto
- Clonar el Repositorio o descomprimir el archivo rar en una carpera, luego en la terminal situarte en el path donde hayas descomprimido o bajado los archivos.
El siguiente paso es levantar la imagen de docker , para eso ejecuta el comando que te dejo acontinuacion, tener en cuenta que este paso es el que mas demora presenta recomiendo esperar y estar atento a la terminal por si arroja algun error : 

         docker-compose up --build  

- Una vez terminado de instalar las dependencias y cuando la sesion de Ubunto este activa dirigete al link que figura en la terminal, para asi poder ingresar al servicio de Jupyter Notebook que te redireccionara al Explorador por el puerto 8888 . Una vez dentro dirigete a la ruta : 127.0.0.1:8888/notebooks/challenge.ipynb

- Ya dentro del file: challenge.ipynb, inicialmente ejecuta solo la primera celda para confirmar el requisito tecnico principal y que la configuracion original no ha sufrido ningun cambio:

        !python3 --version

        import pyspark
        print(pyspark.__version__)

Tiene que tener el siguiente ouput : Python 3.6 y Pyspark 3.2

Si es asi, ya puedes ejecutar el resto de celdas una a una, o todo el notebook completamente con run all. 
Una vez terminada la ejecucion debes tener como salida en cada celda lo siguiente :



## Item 1.1: Monto Total a Facturar
El monto total a facturar por el proveedor por SMS es: **$ 140757.0**.





## Item 1.2: Generar y exportar Dataset 
El dataset con los 100 clientes con mayor facturación ha sido generado y guardado en formato Parquet. La ruta a los archivos:
- [max_billing.parquet](datasets/output/max_billing) 





## Item 1.3: Histograma de Llamadas por Horas
El histograma de llamadas por hora se generó y guardó como una imagen en formato PNG. La ruta al grafico es la siguiente: (click en la imagen)



![Histograma](datasets/output/histograma_llamadas.png)


- Una vez terminada la  ultima celda y guardado el grafico ,la sesion se Spark se cerrara, pero el servicio de jupyter sigue activo, para terminarlo, se debera volver a la consola del servicio y precionar Ctrl + C , y luego ejecutar el comando  :

        
                docker-compose down






##                                         Respuestas a Preguntas generales:

## Item 2.1 :


### ¿Cómo priorizaría los procesos productivos sobre los procesos de análisis exploratorios?

- Si de mi dependiera la priorizacion, mi diseño seria el siguiente :
Inicialmente administraria los recursos para cada uno de los ambientes que existan (ej: Dev ,Staging, Prod) priorizando a los productivos obviamente, luego dejando una reserva global de nodos,cpu y memoria (cuestion de costos) para utilizar en ambientes productivos o de desarrollo de alta demanda ,y de ahi a cada  sub area o equipo le asignaria  recursos  y limites para analisis explotarios segun las necesidades, tipo de desarrollo o volumen de datos que procesen. 
Complementaria con limites de sesiones por equipo y softwares de monitoreo y alertas.
Y para los ambientes productivos o de ejecución automatizada aplicaria colas escalonadas por horario de menor demanda o prioridad de negocio.

### ¿Qué estrategia utilizaría para administrar la ejecución de los procesos productivos durante el día?

-  La estrategia que implentaria estaria basada principalmente en la prioridad y urgencia del negocio y luego segun la administracion de recursos:  ejecutar los procesos productivos  de mayor demanda de recursos bajo  un metodo de ejecucion escalonada y en horarios de menor demanda en desarrollo (ej: por la noche) , pero si por cuestiones tecnicas no se pudiera , implementaria una ejecucion por lotes (si el pipeline lo permite).  
En caso de que ninguna de las anteriores sea viable, recurriría a la optimización del código y de los procesos , para eliminar redundancias o ineficiencias.

### ¿Qué herramientas de scheduling conoce para tal fin?

-  En azure , Synapse pipeline y Dara Factory  , en linux Cron jobs y en entornos como hadoop , Airflow , en gcp Google Cloud Composer y en AWS . awsGlue


## Item 2.2:


### Existe una tabla del Data Lake con alta transaccionalidad, que es actualizada diariamente con un gran volumen de datos. Consultas que cruzan información con esta tabla ven afectada su performance en tiempos de respuesta. Según su criterio, ¿cuáles serían las posibles causas de este problema? Dada la respuesta anterior, qué sugeriría para solucionarlo

- El problema podria tener varias causas, podria ser una mala eleccion en el motor de base de datos, tambien podria ser el formato de almacenamiento (csv , json) ,  tambien la forma en que se actualiza/ingesta dicha tabla transaccional(mismo horario que en el que se consulta) y a su vez la alta cantidad de consultas de datos innecesarios o con falta de indexacion .
La solucion que propondría seria coincidente con las posibles causas antes mencionadas, empezaria elegiendo un motor de base datos para gran volumen de datos , impondria versionado de datos si se permite(particionamiento) o aplicaria formatos columnar (parquet) o de compatacion.(Delta lake o Spark) 
Cambiaria el tipo y metodo de ingesta a hs menos demandantes, tambien implementaria metodos de planificacion y concurrencia para la tabla transaccional
Y plantearia al equipo una campaña de capacitacion para la optimizacion de consultas. 


## Item 2.3 :

### Imagine un clúster Hadoop de 3 nodos, con 50 GB de memoria y 12 cores por nodo. Necesita ejecutar un proceso de Spark que utilizará la mitad de los recursos del clúster, dejando la otra mitad disponible para otros jobs que se lanzarán posteriormente. ¿Qué configuraciones en la sesión de Spark implementaría para garantizar que la mitad del clúster esté disponible para los jobs restantes? Proporcione detalles sobre la asignación de recursos, configuraciones de Spark, y cualquier otra configuración relevante.


- Analisis :

Detalles del cluster :

                3 nodos.
                50 GB de memoria por nodo.
                12 cores (CPU) por nodo.

Recursos totales :

                Memoria total: 3 x 50gb = 150gb
                Nucleos total: 3 x 12cores = 36cores.


Se solicita utilizar la mitad de recursos en el proceso Spark :

                150gb/2 = 75gb
                36cores/2  = 18cores


Configuracion de Spark :

        - Un ejecutor por nodo (se utilizara la mitad)
        - Memoria : 25gb por ejecutor (75gb/3)   
        - Nucleos por ejecutor : 6  (18/3)    
        - Overhead : no solicita
        - Driver : no solicita

Implementacion en Spark :  


        spark = SparkSession.builder \
                .appName("Proceso Spark - consigna 2.3") \
                .config("spark.executor.instances", 3) \
                .config("spark.executor.memory", "25g") \
                .config("spark.executor.cores", 6) \
                .getOrCreate()

                

![SparkSet_consigna2.3] (datasets/SparkSet_consigna2.3.ipynb)

