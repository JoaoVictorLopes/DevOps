count=0
users=$1
loops=$2

while [ $count -lt $users ]
do
	nohup sh loop-generator.sh $loops &
	echo "PID: $!"
	count=`expr $count + 1`
done
