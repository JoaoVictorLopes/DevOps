package main

import (
	"fmt"
	"context"
	"bytes"
	"strings"
	"strconv"
	"os/exec"
	"github.com/docker/docker/client"
	//"github.com/docker/docker/api/types"
)

func main() {
	// Inicializar conexão com Docker Daemon.
	cli, warn := client.NewClientWithOpts(client.FromEnv)
	if (warn != nil) {
		panic(warn)
	}

	service_replicas := 1
	for {
		// Mostrar estatísticas do contêiner.
		precpu_stats, _ := cli.ContainerStatsOneShot(context.Background(), "geoserver_stack_geoserver.1.lu7ybiv7xiw38yl7itgow0mvg")
		precpu_stats_buffer := new(bytes.Buffer)
		precpu_stats_buffer.ReadFrom(precpu_stats.Body)
		precpu_stats_text := precpu_stats_buffer.String()
		//fmt.Println(precpu_stats_text)
		precpu_stats_array := strings.Split(precpu_stats_text, ":")
		//for index, value := range array {
		//	fmt.Println(index, value)
		//}
		//fmt.Println("precpu_stats.total_usage: " + strings.Split(precpu_stats_array[102], ",")[0])
		//fmt.Println("precpu_stats.system_cpu_usage: " + strings.Split(precpu_stats_array[106], ",")[0])
		//fmt.Println("precpu_stats.online_cpus: " + strings.Split(precpu_stats_array[107], ",")[0])

		cpu_stats, _ := cli.ContainerStatsOneShot(context.Background(), "geoserver_stack_geoserver.1.lu7ybiv7xiw38yl7itgow0mvg")
		cpu_stats_buffer := new(bytes.Buffer)
		cpu_stats_buffer.ReadFrom(cpu_stats.Body)
		cpu_stats_text := cpu_stats_buffer.String()
		//fmt.Println(cpu_stats_text)
		cpu_stats_array := strings.Split(cpu_stats_text, ":")
		//for index, value := range array {
		//	fmt.Println(index, value)
		//}
		//fmt.Println("cpu_stats.total_usage: " + strings.Split(cpu_stats_array[102], ",")[0])
		//fmt.Println("cpu_stats.system_cpu_usage: " + strings.Split(cpu_stats_array[106], ",")[0])
		//fmt.Println("cpu_stats.online_cpus: " + strings.Split(cpu_stats_array[107], ",")[0])

		// Calcular deltas.
		precpu_stats_total_usage, _ := strconv.ParseFloat(strings.Split(precpu_stats_array[102], ",")[0], 64)
		precpu_stats_system_cpu_usage, _ := strconv.ParseFloat(strings.Split(precpu_stats_array[106], ",")[0], 64)
		precpu_stats_online_cpus, _ := strconv.ParseFloat(strings.Split(precpu_stats_array[107], ",")[0], 64)
		cpu_stats_total_usage, _ := strconv.ParseFloat(strings.Split(cpu_stats_array[102], ",")[0], 64)
		cpu_stats_system_cpu_usage, _ := strconv.ParseFloat(strings.Split(cpu_stats_array[106], ",")[0], 64)
		//cpu_stats_online_cpus, _ := strconv.Atoi(strings.Split(cpu_stats_array[107], ",")[0])
		cpu_delta := cpu_stats_total_usage - precpu_stats_total_usage
		system_cpu_delta := cpu_stats_system_cpu_usage - precpu_stats_system_cpu_usage
		online_cpus := precpu_stats_online_cpus
		//fmt.Println("cpu_delta: " + strconv.Itoa(cpu_delta))
		//fmt.Println("system_cpu_delta: " + strconv.Itoa(system_cpu_delta))
		//fmt.Println("online_cpus: " + strconv.Itoa(online_cpus))

		// Calcular porcentagem.
		cpu_usage_percentage := ((cpu_delta / system_cpu_delta) * online_cpus) * 100
		//fmt.Println("cpu_usage_percentage: " + strconv.Itoa(cpu_usage_percentage) + "%")
		fmt.Printf("cpu_usage_percentage: %f\n", cpu_usage_percentage)
		fmt.Println("service_replicas: " + strconv.Itoa(service_replicas))

		if cpu_usage_percentage > 2 && service_replicas == 1 {
			fmt.Println("Scaling Up Activation!")
			exec.Command("docker", "service", "scale", "geoserver_stack_geoserver=2").Output()
			service_replicas = 2

		} else if cpu_usage_percentage < 1 && service_replicas == 2 {
			fmt.Println("Scaling Down Activation!")
			exec.Command("docker", "service", "scale", "geoserver_stack_geoserver=1").Output()
			service_replicas = 1
		}
	}
}
