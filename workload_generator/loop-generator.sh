count=0
loops=$1

while [ $count -lt $loops ]
do
	curl 127.0.0.1:8181/geoserver
	count=`expr $count + 1`
done
