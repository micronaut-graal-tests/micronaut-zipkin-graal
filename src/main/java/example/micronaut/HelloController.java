package example.micronaut;

import io.micronaut.http.annotation.Controller;
import io.micronaut.http.annotation.Get;
import io.micronaut.tracing.annotation.NewSpan;
import io.micronaut.tracing.brave.BraveTracerConfiguration;

import java.net.URI;
import java.util.List;
import java.util.stream.Collectors;

@Controller("/")
public class HelloController {

    private final BraveTracerConfiguration.HttpClientSenderConfiguration httpClientSenderConfiguration;

    public HelloController(BraveTracerConfiguration.HttpClientSenderConfiguration httpClientSenderConfiguration) {
        this.httpClientSenderConfiguration = httpClientSenderConfiguration;
    }

    @NewSpan
    @Get("/hello/{name}")
    public String sayHi(String name) {
        return "Hello " + name;
    }

    @Get("/config")
    public List<String> config() {
        return httpClientSenderConfiguration.getBuilder().getServers()
                .stream()
                .map(URI::toString)
                .collect(Collectors.toList());
    }
}
