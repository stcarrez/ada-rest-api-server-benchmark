# Ada REST API Server Benchmark

[![License](http://img.shields.io/badge/license-APACHE2-blue.svg)](LICENSE)

Are you wondering which web container to use for your next web application?
Which language are you using? Java or Ada ?

This project compares several Ada servers and you can compare the results
against several Java containers such as: Tomcat, Jetty, Grizzly or Undertow.

The project implements the same REST API as the
[java-rest-api-web-container-benchmark](https://github.com/arcadius/java-rest-api-web-container-benchmark)
which compares several Java web containers.  The REST API is the same for each
server (Java or Ada) and it returns the following json result:

  {"greeting":"Hello World!"}

Server performances are measured by using the
[Apache Benchmark](https://httpd.apache.org/docs/2.2/programs/ab.html)



