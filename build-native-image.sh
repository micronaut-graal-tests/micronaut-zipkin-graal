./gradlew assemble
native-image --no-fallback --class-path build/libs/zipkin-graal-*-all.jar
