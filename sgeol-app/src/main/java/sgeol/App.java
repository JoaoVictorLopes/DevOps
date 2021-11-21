package sgeol;

import io.prometheus.client.Counter;

/**
 * Hello world!
 *
 */
public class App
{
    static final Counter requests = Counter.build().name("sgeol_requests_total").help("Sgeol total requests.").register();
    public static void main( String[] args )
    {
        System.out.println( "Hello World!" );
        requests.inc();
    }
}
