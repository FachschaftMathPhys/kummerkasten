
FROM phusion/passenger-customizable
LABEL vendor="Fachschaft MathPhys"
MAINTAINER Henrik Reinstädtler <henrik@mathphys.fsk.uni-heidelberg.de>
RUN /pd_build/ruby-2.3.3.sh
RUN /pd_build/redis.sh

# Enable the Redis service.
RUN rm -f /etc/service/redis/down
RUN apt-get update && apt-get install -qq -y --no-install-recommends \
build-essential  nodejs npm libpq-dev wget git cron

ENV HOME /root

# Use baseimage-docker's init process.
CMD ["/bin/bash","-c","/sbin/my_init | tee /home/app/kummerkasten/log/stdout.log"]
#update nodejs
RUN npm cache clean -f
RUN npm install -g n
RUN n 8
RUN npm install -g bower
RUN npm install -g ember-cli
ENV INSTALL_PATH /home/app/kummerkasten

#Ordner erstellen und wechseln
RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH

#Gemfile kopieren
COPY Gemfile  ./
#bundles installieren
RUN gem install bundler
RUN DEBUG_RESOLVER=1 bundler install --binstubs --verbose
#und den rest kopieren
COPY . .
ENV RAILS_ENV production
RUN RAILS_ENV=production PRODUCTION_DATABASE_ADAPTER="postgresql" bundle exec rake assets:precompile
RUN bash gem install whenever
RUN rm -rf /kummerkasten/tmp/pids && bundle exec whenever --update-crontab
RUN rm -f /etc/service/nginx/down
ADD webapp.conf /etc/nginx/sites-enabled/webapp.conf
ADD postgres-env.conf /etc/nginx/main.d/postgres-env.conf
# Queue classic für mails
RUN mkdir -p /etc/service/queue_classic
ADD queue_classic.sh /etc/service/queue_classic/run
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
