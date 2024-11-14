FROM ubuntu:22.04
WORKDIR /var/www/html/
RUN apt-get update && apt-get install -y python3 python3-pip apache2 git
RUN rm index.html
WORKDIR /app
RUN git clone https://github.com/thomasvanegas/CRUD_Productos_Python.git
RUN pip3 install -r requirements.txt
RUN mv ./CRUD_Productos_Python/* .