FROM oracle/graalvm-ce:1.0.0-rc13 as graalvm
COPY . /home/app/zipkin-graal
WORKDIR /home/app/zipkin-graal
RUN native-image --no-server -cp build/libs/zipkin-graal-*-all.jar

FROM frolvlad/alpine-glibc
EXPOSE 8080
COPY --from=graalvm /home/app/zipkin-graal .
ENTRYPOINT ["./zipkin-graal"]