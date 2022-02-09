FROM centos:latest
MAINTAINER sanjay.dahiya332@gmail.com
FROM registry.access.redhat.com/rhel7/rhel AS builder
RUN yum install unzip
ADD myfile.zip /dist
RUN cd /dist && unzip myfile.zip && rm myfile.zip

FROM registry.access.redhat.com/rhel7/rhel
COPY --from=builder /dist/ /target
RUN yum install -y httpd \ 
zip \
unzip
ADD https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip /var/www/html/
WORKDIR /var/www/html
RUN unzip photogenic.zip
RUN cp -rvf photogenic/* .
RUN rm -rf photogenic photogenic.zip 
CMD ["/usr/sbin/httpd", "-D",  "FOREGROUND"]
EXPOSE 80
