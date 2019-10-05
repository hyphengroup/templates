ARG MAVEN_FROM=maven:3.6-jdk-10
FROM ${MAVEN_FROM} as builder
ARG MVN_OPTS

# COPY service files and folders
COPY service/ ./

RUN mvn package $MVN_OPTS

FROM openjdk:10.0.2-jre-slim
ARG JARFILE

# "-Dspring.profiles.active=env" needs to be replaced!
ENTRYPOINT ["/usr/bin/java", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-Dspring.profiles.active=env", "-Djava.security.egd=file:/dev/./urandom", "-jar", "app.jar"]

COPY --from=builder $JARFILE ./app.jar