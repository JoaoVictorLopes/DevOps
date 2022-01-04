package sgeol;

// Spring Web.
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

// Prometheus.
import io.prometheus.client.Counter;
import io.prometheus.client.exporter.HTTPServer;
import io.prometheus.client.spring.web.EnablePrometheusTiming;
import io.prometheus.client.spring.web.PrometheusTimeMethod;

// Spring Data.
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Query;
import static org.springframework.data.mongodb.core.query.Criteria.where;

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
	// Spring Web.
        SpringApplication.run(App.class, args);

	// Prometheus.
        try {
          HTTPServer server = new HTTPServer(9200);
        }
        catch (Exception e) {
          System.out.println("Falhou!");
        }

	// Spring Data.
	MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017");
	MongoOperations mongoOperations = new MongoTemplate(mongoClient, "test");
	mongoOperations.insert(new Person("Joe", 34));
	System.out.println(mongoOperations.findOne(new Query(where("name").is("Joe")), Person.class));
	mongoOperations.dropCollection("person");
    }

    @GetMapping("/")
    @PrometheusTimeMethod(name = "sgeol_http_request_seconds", help = "Duração em segundos da solicitação HTTP do SGeoL.")
    public String index(@RequestParam(value = "name", defaultValue = "World") String name) {
	counter.inc();
        return String.format("Hello %s!", name);
    }
}
