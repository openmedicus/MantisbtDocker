FROM openmedicus/centos-lamp:latest
MAINTAINER Mikkel Kruse Johnsen <mikkel@xmedicus.com>

RUN echo 'date.timezone = "Europe/Copenhagen"' >> /etc/php.ini

#RUN sed -i -e "s/DirectoryIndex index\.html/DirectoryIndex index\.php index\.html/g" /etc/httpd/conf/httpd.conf

ADD mantisbt-2.2.0.tar.gz /
RUN mv mantisbt-2.2.0/* /var/www/html/ ; \
	chown -R apache:apache /var/www/html

