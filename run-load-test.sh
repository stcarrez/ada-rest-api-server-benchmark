#!/bin/sh
#
URL=http://localhost:8080/api
case $# in
  1)
        NAME=$1
        ;;

  2)
        NAME=$1
        URL=$2
        ;;

  *)
	echo "Usage: run-load-tests.sh result-name [URL]" 1>&2
        echo "Default URL is: $URL" 1>&2
	exit 2
	;;
esac

shift

mkdir -p results || exit 1
cd results || exit 1

REQ_TIME=10S

rm -f $NAME.csv $NAME.dat $NAME.log
echo "Running siege benchmark for $NAME" >> $NAME.log
date >> $NAME.log
for C in 1 2 3 4 5 6 7 8 9 10 15 20 25 30 35 40 45 50 ; do
   echo "Running benchmark with $C concurrent requests"
   siege -b -t$REQ_TIME -c$C $URL > result.log 2>&1
   T=`awk '/Transaction rate/ { print $3; }' result.log`
   echo "$C,$T" >> $NAME.csv
   echo "$C $T" >> $NAME.dat
   cat result.log >> $NAME.log
done
