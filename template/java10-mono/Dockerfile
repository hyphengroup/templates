FROM maven:3.6-jdk-10 as builder
ARG MVN_OPTS

# COPY function files and folders
COPY function/ ./

RUN mvn package $MVN_OPTS

FROM openjdk:10.0.2-jre-slim
ARG JARFILE

# "-Dspring.profiles.active=env" needs to be replaced!
ENTRYPOINT ["/usr/bin/java", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-Dspring.profiles.active=env", "-Djava.security.egd=file:/dev/./urandom", "-jar", "app.jar"]

COPY --from=builder $JARFILE ./app.jar