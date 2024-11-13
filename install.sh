#!/bin/bash
sudo apt-get update
sudo apt-get install -y docker.io docker-compose git
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER
newgrp docker
docker run hello-world