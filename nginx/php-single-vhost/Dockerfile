FROM nginx:1.17
COPY default.template /etc/nginx/conf.d/default.template
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]