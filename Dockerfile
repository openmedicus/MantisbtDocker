FROM openmedicus/centos-lamp:7.1
MAINTAINER Mikkel Kruse Johnsen <mikkel@xmedicus.com>

RUN echo $'\n\ndate.timezone = "Europe/Copenhagen"' >> /etc/php.ini
RUN echo $'upload_max_filesize = 20M' >> /etc/php.ini

#RUN sed -i -e "s/DirectoryIndex index\.html/DirectoryIndex index\.php index\.html/g" /etc/httpd/conf/httpd.conf

ADD mantisbt-2.24.3.tar.gz /
RUN mv mantisbt-2.24.3/* /var/www/html/

ADD parsedown-master.zip /
RUN unzip parsedown-master.zip
RUN mv parsedown-master /var/www/html/library/parsedown

RUN chown -R apache:apache /var/www/html

