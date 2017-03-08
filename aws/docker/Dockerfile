FROM ciceron/gnat:latest

MAINTAINER Stephane Carrez <Stephane.Carrez@gmail.com>

RUN mkdir -p /usr/src \
   && cd /usr/src \
   && git clone https://github.com/stcarrez/ada-rest-server-benchmark.git ada-rest-server-benchmark \
   && cd ada-rest-server-benchmark/aws \
   && gnatmake -p -Paws_benchmark

WORKDIR /usr/src/ada-rest-server-benchmark/aws

