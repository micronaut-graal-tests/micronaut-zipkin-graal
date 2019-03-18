./gradlew assemble
native-image --no-server --class-path build/libs/zipkin-graal-*.jar
