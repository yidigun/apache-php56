FROM centos:centos6.9
MAINTAINER dklee@yidigun.com

COPY local/ /usr/local/
RUN yum -y update && \
    yum -y install db4 openssl expat pcre gdbm mysql-libs sqlite libxml2 libcurl gd libxslt libvpx libicu gettext && \
    yum clean all && \
    echo '/usr/local/lib' >/etc/ld.so.conf.d/local.conf && \
    ln -s apache-httpd-2.4.34 /usr/local/apache-httpd-current && \
    ln -s php-5.6.37 /usr/local/php && \
    mkdir /var/log/httpd && \
    ldconfig

EXPOSE 80
EXPOSE 443
VOLUME /usr/local/apache/conf
VOLUME /usr/local/php/etc
VOLUME /var/log/httpd

CMD /usr/local/apache/bin/httpd -DFOREGROUND -d/usr/local/apache -f/usr/local/apache/conf/httpd.conf
