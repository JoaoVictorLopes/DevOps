package sgeol;

// Spring Web.
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.context.ConfigurableApplicationContext;

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

/**
 * Hello world!
 *
 */
@SpringBootApplication
@RestController
public class App
{
    static final Counter counter = Counter.build().name("sgeol_http_requests_total").help("Total de solicitações HTTP do SGeoL.").register();
    static final Histogram histogramAuthenticationTime = Histogram.build().name("sgeol_geographic_operation_authentication_time").help("Tempo de autenticação da operação geográfica do SGeoL.").register();
    static final Histogram histogramAuthorizationTime = Histogram.build().name("sgeol_geographic_operation_authorization_time").help("Tempo de autorização da operação geográfica do SGeoL.").register();
    static final Histogram histogramRequestTime = Histogram.build().name("sgeol_geographic_operation_request_time").help("Tempo de solicitação da operação geográfica do SGeoL.").register();

    public static void main( String[] args )
    {
	// Spring Web.
        ConfigurableApplicationContext context = SpringApplication.run(App.class, args);

	// Spring Data.
        String host = context.getEnvironment().getProperty("spring.data.mongodb.host");
        String port = context.getEnvironment().getProperty("spring.data.mongodb.port");
        String database = context.getEnvironment().getProperty("spring.data.mongodb.database");
	MongoClient mongoClient = MongoClients.create("mongodb://" + host + ":" + port);
	MongoOperations mongoOperations = new MongoTemplate(mongoClient, database);

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
		List<AccessLog> list = mongoOperations.find(query.with(sort).limit(1), AccessLog.class);
		System.out.println(list.get(0).getLayer());
		histogramAuthenticationTime.observe(list.get(0).getAuthenticationTimeProcess());
		histogramAuthorizationTime.observe(list.get(0).getAuthorizationTimeProcess());
		histogramRequestTime.observe(list.get(0).getRequestTimeProcess());

		try {
			Thread.sleep(15000);
		}
		catch (Exception e) {
			System.out.println("Interval Failed: " + e);
		}
	}
    }

    @GetMapping("/")
    public String index(@RequestParam(value = "name", defaultValue = "World") String name) {
	counter.inc();
        return String.format("Hello %s!", name);
    }
}
