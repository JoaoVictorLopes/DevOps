# Importar bibliotecas.
import docker

# Inicializar conexão com Docker Daemon.
docker_client = docker.from_env()
api_client = docker.APIClient(base_url="unix://var/run/docker.sock")

# Recuperar objetos de interação.
#swarm = client.swarm.join(remote_addrs=["10.7.41.146:2377"], join_token="SWMTKN-1-3ayrgp3iqoyjfucisfjs89q3p8vgddhpxrh05dsjosdi8s40if-ctv6e90zlk4ej9b6nf42zbz5o")
container = docker_client.containers.get("geoserver_stack_geoserver.1.2zjqmhfk86oftu5sb6mbudf2n")
service = docker_client.services.get("geoserver_stack_geoserver")

# Repetir monitoramento e ativação.
count = 1
while (True):
	cpu_stats_text = container.stats(stream=False)
	cpu_stats_array = str(cpu_stats_text).split(":")

	# Mostrar estatísticas com linhas numeradas.
	#index = 0
	#for value in cpu_stats_array:
	#	index = index + 1
	#	print(str(index) + " - " + value, end="\n")

	# Mostrar estatísticas específicas.
	#print("cpu_stats.total_usage: " + array[102].split(",")[0].lstrip())
	#print("cpu_stats.system_cpu_usage: " + array[106].split(",")[0].lstrip())
	#print("cpu_stats.online_cpus: " + array[107].split(",")[0].lstrip())

	#print("precpu_stats.total_usage: " + array[114].split(",")[0].lstrip())
	#print("precpu_stats.system_cpu_usage: " + array[118].split(",")[0].lstrip())
	#print("precpu_stats.online_cpus: " + array[119].split(",")[0].lstrip())

	# Calcular deltas.
	cpu_delta = int(cpu_stats_array[21].split(",")[0].lstrip()) - int(cpu_stats_array[32].split(",")[0].lstrip())
	system_cpu_delta = int(cpu_stats_array[24].split(",")[0].lstrip()) - int(cpu_stats_array[35].split(",")[0].lstrip())
	online_cpus = int(cpu_stats_array[25].split(",")[0].lstrip())

	#print("cpu_delta: " + str(cpu_delta))
	#print("system_cpu_delta: " + str(system_cpu_delta))
	#print("online_cpus: " + str(online_cpus))

	# Calcular porcentagem.
	cpu_usage_percentage = cpu_delta / system_cpu_delta
	cpu_usage_percentage = cpu_usage_percentage * online_cpus
	cpu_usage_percentage = cpu_usage_percentage * 100
	print("cpu_usage_percentage: " + str(cpu_usage_percentage) + "%")

	inspect_service_text = api_client.inspect_service(service="geoserver_stack_geoserver")
	inspect_service_array = str(inspect_service_text).split(":")

	# Mostrar inspeções com linhas numeradas.
	#index = 0
	#for value in inspect_service_array:
	#	index = index + 1
	#	print(str(index) + " - " + value)

	service_replicas = int(inspect_service_array[39].split(",")[0].lstrip()[0])
	print("service_replicas: " + str(service_replicas))

	if (cpu_usage_percentage > 5 and service_replicas == 1):
		print("Scaling Up Activation!")
		service.scale(2)
		service.reload()
	elif (cpu_usage_percentage < 1 and service_replicas == 2):
		print("Scaling Down Activation!")
		service.scale(1)
		service.reload()

	count = count + 1
