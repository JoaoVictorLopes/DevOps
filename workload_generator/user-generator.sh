count=0
users=$1
loops=$2

startuptime=$(date +%T)

while [ $count -lt $users ]
do
	sh loop-generator.sh $loops &
	echo "PID: $!"
	count=`expr $count + 1`
done

finishtime=$(date +%T)

echo "Users: $users\nLoops: $loops\nStartup Time: $startuptime\nFinish Time: $finishtime\n" >> $users_$loops.log
cat $users_$loops.log
