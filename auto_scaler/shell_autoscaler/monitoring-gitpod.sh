# Arithmetic Expression: $((expression))
# Command Substitution: $(command) or `command`

count=0

while [ true ]
do
	# Collecting Metrics.
	sudo curl --unix-socket /var/run/docker.sock "http://localhost/v1.40/containers/{dockercomposefiles_web_1}/stats?stream=false&one-shot=true" > ./statistics/stats.txt
	cut -d ":" -f 22 ./statistics/stats.txt 1> ./statistics/precpu_total_usage.txt
	cut -d "," -f 1 ./statistics/precpu_total_usage.txt 1> ./statistics/precpu_total_usage2.txt

	cut -d ":" -f 25 ./statistics/stats.txt 1> ./statistics/presystem_cpu_usage.txt
	cut -d "," -f 1 ./statistics/presystem_cpu_usage.txt 1> ./statistics/presystem_cpu_usage2.txt

	cut -d ":" -f 26 ./statistics/stats.txt 1> ./statistics/preonline_cpus.txt
	cut -d "," -f 1 ./statistics/preonline_cpus.txt 1> ./statistics/preonline_cpus2.txt

	sudo curl --unix-socket /var/run/docker.sock "http://localhost/v1.40/containers/{dockercomposefiles_web_1}/stats?stream=false&one-shot=true" > ./statistics/stats2.txt
	cut -d ":" -f 22 ./statistics/stats2.txt 1> ./statistics/cpu_total_usage.txt
	cut -d "," -f 1 ./statistics/cpu_total_usage.txt 1> ./statistics/cpu_total_usage2.txt

	cut -d ":" -f 25 ./statistics/stats2.txt 1> ./statistics/system_cpu_usage.txt
	cut -d "," -f 1 ./statistics/system_cpu_usage.txt 1> ./statistics/system_cpu_usage2.txt

	cut -d ":" -f 26 ./statistics/stats2.txt 1> ./statistics/online_cpus.txt
	cut -d "," -f 1 ./statistics/online_cpus.txt 1> ./statistics/online_cpus2.txt

	# Assigning Metrics.
	precpu_total_usage=$(cat ./statistics/precpu_total_usage2.txt)
	cpu_total_usage=$(cat ./statistics/cpu_total_usage2.txt)
	presystem_cpu_usage=$(cat ./statistics/presystem_cpu_usage2.txt)
	system_cpu_usage=$(cat ./statistics/system_cpu_usage2.txt)
	online_cpus=$(cat ./statistics/online_cpus2.txt)

	echo "\n\nMétricas de CPU:\n"
	echo "Uso Total: $precpu_total_usage / $cpu_total_usage"
	echo "Uso do Sistema: $presystem_cpu_usage / $system_cpu_usage"
	echo "Número de CPUS: $online_cpus"

	# Calculating Metrics.
	cpu_delta=$(echo "scale=1; $cpu_total_usage - $precpu_total_usage" | bc)
	system_cpu_delta=$(echo "scale=1; $system_cpu_usage - $presystem_cpu_usage" | bc)
	number_cpus=$online_cpus

	echo "CPU Delta: $cpu_delta"
	echo "System CPU Delta: $system_cpu_delta"
	echo "Número de CPUS: $number_cpus"

	# CPU Usage Percentage.
	percentage=$(echo "scale=1; $cpu_delta / $system_cpu_delta" | bc)
	percentage=$(echo "scale=1; $percentage * $number_cpus" | bc)
	percentage=$(echo "scale=1; $percentage * 100.0" | bc)

	echo "CPU Usage Percentage: $percentage"

	# Comparing Metrics.
	percentage=$(echo "$percentage / 2 * 2" | bc)

	if [ $percentage -gt 100 ]
	then
		sudo docker-compose --file dockercomposefiles/docker-compose.yml scale web=2
		sleep 5m
	fi

	if [ $percentage -lt 100 ]
	then
		sudo docker-compose --file dockercomposefiles/docker-compose.yml scale web=1
	fi

	count=`expr $count + 1`
done
