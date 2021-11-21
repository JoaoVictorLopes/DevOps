package sgeol;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import io.prometheus.client.Counter;
import io.prometheus.client.exporter.HTTPServer;

/**
 * Hello world!
 *
 */
@SpringBootApplication
@RestController
public class App
{
    static final Counter requests = Counter.build().name("sgeol_requests_total").help("Sgeol total requests.").register();

    public static void main( String[] args )
    {
        SpringApplication.run(App.class, args);
        System.out.println( "Hello World!" );
        try {
          HTTPServer server = new HTTPServer(1234);
        }
        catch (Exception e) {
          System.out.println("Falhou!");
        }
    }

    @GetMapping("/")
    public String hello(@RequestParam(value = "name", defaultValue = "World") String name) {
        requests.inc();
        return String.format("Hello %s!", name);
    }
}
