package sgeol;

// Spring Web.
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

// Spring Data.
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.domain.Sort;
import java.util.List;

// Prometheus.
import io.prometheus.client.Counter;
import io.prometheus.client.Histogram;
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
    static final Histogram histogram = Histogram.build().name("sgeol_operation_response_time").help("Tempo de resposta da operação do SGeoL.").register();

    public static void main( String[] args )
    {
	// Spring Web.
        SpringApplication.run(App.class, args);

	// Spring Data.
	MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017");
	MongoOperations mongoOperations = new MongoTemplate(mongoClient, "test");

	mongoOperations.insert(new Person("Mateus", 1));
	mongoOperations.insert(new Person("Marcos", 2));
	mongoOperations.insert(new Person("Lucas", 3));
	mongoOperations.insert(new Person("João", 4));

	//mongoOperations.dropCollection("person");

	// Prometheus.
        try {
          HTTPServer server = new HTTPServer(9200);
        }
        catch (Exception e) {
          System.out.println("Exporter Failed: " + e);
        }

	while (true) {
		Query query = new Query();
		Sort sort = Sort.by(Sort.Direction.DESC, "_id");
		List<Person> list = mongoOperations.find(query.with(sort).limit(1), Person.class);
		System.out.println(list.get(0).getName());
		histogram.observe(list.get(0).getAge());

		try {
			Thread.sleep(15000);
		}
		catch (Exception e) {
			System.out.println("Interval Failed: " + e);
		}
	}
    }

    @GetMapping("/")
    @PrometheusTimeMethod(name = "sgeol_http_request_seconds", help = "Duração em segundos da solicitação HTTP do SGeoL.")
    public String index(@RequestParam(value = "name", defaultValue = "World") String name) {
	counter.inc();
        return String.format("Hello %s!", name);
    }
}
