./gradlew assemble
docker build . -t zipkin-graal
docker run --network host zipkin-graal
