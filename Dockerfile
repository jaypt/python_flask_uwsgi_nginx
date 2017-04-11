FROM python:2.7

MAINTAINER jaypt

RUN apt-get -yqq update
#RUN pip install ipython

COPY requirements.txt .
RUN pip install -r requirements.txt



#RUN apt-get -yqq install sudo
RUN apt-get -yqq install vim

#RUN pip install uwsgi

RUN apt-get -yqq install nginx
 

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

RUN apt-get -yqq install supervisor
RUN rm -rf /var/lib/apt/lists/*

#run nginx in fg
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

#remove default sites
#RUN rm /etc/nginx/sites-enabled/default
RUN mv /etc/nginx/sites-enabled/default /tmp/default-nginx-sites


#copy conf for nginx, uwsgi, supervisor
COPY nginx.conf /etc/nginx/conf.d/
COPY uwsgi.ini /etc/uwsgi/
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80

COPY ./app /app
WORKDIR /app

CMD ["/usr/bin/supervisord"]


