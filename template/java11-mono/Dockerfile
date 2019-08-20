FROM maven:3.6 as builder
ARG MVN_OPTS

# COPY function files and folders
COPY function/ ./

RUN mvn package $MVN_OPTS

FROM openjdk:11-jre-slim
ARG JARFILE

ENTRYPOINT ["java", "-jar", "app.jar"]

COPY --from=builder $JARFILE ./app.jar