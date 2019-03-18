./gradlew assemble
native-image --no-server --class-path build/libs/zipkin-graal-0.1-all.jar
