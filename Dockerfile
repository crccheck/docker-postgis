# ## Postgresql 9.3 and Postgis 2.1
#
# A Postgresql 9.3 + Postgis 2.1 image that supports external volumes. Runs on
# port 5432.
#
# ### Example Usage
#
#     docker run -d -v ~/volumes/postgres/:/mnt/postgres/ postgis
#
# References:
# * http://docs.docker.io/en/latest/examples/postgresql_service/
# * https://github.com/orchardup/docker-postgresql/blob/master/Dockerfile
# * http://www.ubuntuupdates.org/ppa/postgresql

FROM ubuntu:precise
MAINTAINER Chris <c@crccheck.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y wget && apt-get clean

# put the data directory in a volume
# VOLUME ["/mnt/postgres/"]

# Add Postgres PPA
# --no-check-certificate workaround for:
#     "ERROR: cannot verify www.postgresql.org's certificate"
RUN wget --no-check-certificate --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" >> /etc/apt/sources.list.d/postgresql.list

# add universe
RUN echo "deb http://archive.ubuntu.com/ubuntu precise universe" >> /etc/apt/sources.list

RUN apt-get update
RUN apt-get install -y postgresql-9.3-postgis-2.1 postgresql-contrib-9.3 postgresql-9.3-plv8 && apt-get clean

# add configuration file(s)
ADD conf /etc/postgresql/9.3/main


ADD start.sh /
RUN sh /start.sh
# CMD ["sh", "/usr/local/bin/start.sh"]

# useful reference:
