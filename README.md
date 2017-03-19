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

Server performances are measured by using the [Siege](https://www.joedog.org/)

# Build

To build the Ada servers, you must have built and installed the following:

* ASF           (https://github.com/stcarrez/ada-asf)
* AWS      (http://libre.adacore.com/libre/tools/aws/)
* EWS      (http://embed-web-srvr.sourceforge.net/)
* Simple Components (http://www.dmitry-kazakov.de/ada/components.htm)

Then build with:

```
  cd aws && gprbuild -Paws_benchmark -p
  cd asf && gprbuild -Pasf_benchmark -p
  cd ews && gprbuild -Pews_benchmark -p
  cd simple_components && gprbuild -Pcomponents_benchmark -p
```

# Linux Network Stack settings

Siege makes an intensive use of network connections which results in exhaustion of
TCP/IP port to connect to the server.  This is due to the TCP TIME_WAIT that prevents
the TCP/IP port to be re-used for future connections.  To avoid such exhaustion,
you should setup the network stack on both the server host and the client host where
siege is executed.  You will do this with:

```
  sudo sysctl -w net.ipv4.tcp_tw_recycle=1
  sudo sysctl -w net.ipv4.tcp_tw_reuse=1
```

# Running the benchmark

Start the server that you want to benchmark, for example:

```
  aws/bin/aws_rest_api
```

In another window (or best on another computer), run the Siege benchmark:

```
  sh run-load-test.sh ada-aws http://localhost:8080/api
```

(change *localhost* to the IP address of the server if necessary).

Results are produced in the *results* directory and you can plot them
by using [Gnuplot](http://www.gnuplot.info/).

