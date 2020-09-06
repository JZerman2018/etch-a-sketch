FROM ubuntu:latest

ENV
DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y &&\
    apt-get install apache2 -y

COPY . index.html /var/www/html/

EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]

# FROM nginx:alpine

# # Copy source code to working directory
# COPY index.html /usr/share/nginx/html

# # Expose port 80
# EXPOSE 80