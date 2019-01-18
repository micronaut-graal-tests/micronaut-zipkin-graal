FROM oracle/graalvm-ce:1.0.0-rc8
EXPOSE 8080
COPY build/libs/*-all.jar zipkin-graal.jar
ADD . build
RUN java -cp zipkin-graal.jar io.micronaut.graal.reflect.GraalClassLoadingAnalyzer 
RUN native-image --no-server \
             --class-path zipkin-graal.jar \
             -H:ReflectionConfigurationFiles=build/reflect.json \
             -H:EnableURLProtocols=http \
             -H:IncludeResources="logback.xml|application.yml|META-INF/services/*.*" \
             -H:Name=zipkin-graal \
             -H:Class=zipkin.graal.Application \
             -H:+ReportUnsupportedElementsAtRuntime \
             -H:+AllowVMInspection \
             -H:-UseServiceLoaderFeature \
             --rerun-class-initialization-at-runtime='sun.security.jca.JCAUtil$CachedSecureRandomHolder,javax.net.ssl.SSLContext' \
             --delay-class-initialization-to-runtime=io.netty.handler.codec.http.HttpObjectEncoder,io.netty.handler.codec.http.websocketx.WebSocket00FrameEncoder,io.netty.handler.ssl.util.ThreadLocalInsecureRandom,com.sun.jndi.dns.DnsClient
ENTRYPOINT ["./zipkin-graal"]