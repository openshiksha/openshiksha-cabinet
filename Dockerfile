FROM nginx:1.14

# Env vars
ENV WORKDIR /usr/src/app
ENV USER root

WORKDIR ${WORKDIR}

COPY . .

# Setup nginx conf
RUN devops/compile-nginx.sh all openshiksha-cabinet

RUN echo "include ${WORKDIR}/devops/nginx.compiled.conf;" > /etc/nginx/nginx.conf

EXPOSE 9878