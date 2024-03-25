FROM nginx
MAINTAINER admin
COPY webapp/target/webapp.war /usr/share/nginx/html
EXPOSE 80