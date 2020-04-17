FROM nginx
USER root
RUN apt-get update && apt-get install python3-pip -y
RUN pip3 install awscli --upgrade
COPY docker/entrypoint.sh /
RUN chmod +x /entrypoint.sh
COPY silent-check-sso.html /usr/share/nginx/html
COPY ./default.template /etc/nginx/conf.d/default.template
CMD ["nginx", "-g", "daemon off;"]
