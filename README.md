# Micronaut Zipkin #

Test application for Micronaut and GraalVM that uses:

- `HelloWorld` controller that returns `Hello ${name}` as a String.
- Zipkin for Distributed Tracing.

```
curl localhost:8080/hello/Micronaut
curl http://localhost:9411/zipkin/api/v2/spans\?serviceName\=zipkin-graal
```
