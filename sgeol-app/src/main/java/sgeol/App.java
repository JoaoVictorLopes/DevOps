package sgeol;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import io.prometheus.client.Counter;
import io.prometheus.client.exporter.HTTPServer;
import io.prometheus.client.spring.web.EnablePrometheusTiming;
import io.prometheus.client.spring.web.PrometheusTimeMethod;

/**
 * Hello world!
 *
 */
@SpringBootApplication
@RestController
@EnablePrometheusTiming
public class App
{
    static final Counter counter = Counter.build().name("sgeol_http_requests_total").help("Total de solicitações HTTP do SGeoL.").register();

    public static void main( String[] args )
    {
        SpringApplication.run(App.class, args);
        try {
          HTTPServer server = new HTTPServer(9200);
        }
        catch (Exception e) {
          System.out.println("Falhou!");
        }
    }

    @GetMapping("/")
    @PrometheusTimeMethod(name = "sgeol_http_request_seconds", help = "Duração em segundos da solicitação HTTP do SGeoL.")
    public String index(@RequestParam(value = "name", defaultValue = "World") String name) {
        counter.inc();
        return String.format("Hello %s!", name);
    }
}
