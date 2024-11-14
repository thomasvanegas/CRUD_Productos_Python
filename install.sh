#!/bin/bash
sudo apt-get update
sudo apt-get install -y docker.io docker-compose git
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER
sudo docker-compose up -d
RUN git clone https://github.com/thomasvanegas/CRUD_Productos_Python.git