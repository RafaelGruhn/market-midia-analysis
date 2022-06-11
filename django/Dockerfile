FROM python:3.8.0-slim as builder

RUN apt-get update

RUN apt-get -y install vim postgresql-client make libpq-dev python3-dev  gcc


ARG MODE
COPY ["core_proj/requirements/", "docker/build.sh", "/tmp/"]
RUN sh /tmp/build.sh /tmp/

FROM builder AS core_proj
RUN mkdir /code
WORKDIR /code
ADD . /code
EXPOSE 8000
STOPSIGNAL SIGINT
