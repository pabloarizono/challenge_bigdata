##DOCKERFILE

FROM ubuntu:20.04

LABEL mainteiner="ap pabloarizono@gmail.com" 

# Establecer el locale
RUN apt-get update && apt-get install -y locales
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Agregar el repositorio de Python 3.6
RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa

# Instalar Python 3.6 y dependencias
RUN apt-get update && apt-get install -y \
    python3.6 \
    python3.6-dev \
    python3.6-distutils \
    python3-pip \
    openjdk-8-jdk \  
    wget \
    curl \
    git \
    && apt-get clean

# Establecer python3.6 como predeterminado
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 1

# Instalar pip para Python 3.6 ,no uso ensurepip por compatibilidad
RUN curl https://bootstrap.pypa.io/pip/3.6/get-pip.py -o get-pip.py && python3 get-pip.py && rm get-pip.py

# Instalar PySpark y Jupyter Notebook
RUN pip install pyspark==2.3.0 
RUN pip install notebook

COPY ./challenge.ipynb /

COPY ./requirements.txt /
RUN pip install -r /requirements.txt

EXPOSE 8888

# Comandos para  Jupyter
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--allow-root"]
