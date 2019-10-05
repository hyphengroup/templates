ARG MAVEN_FROM=maven:3.6
FROM ${MAVEN_FROM} as builder
ARG MVN_OPTS

# COPY service files and folders
COPY service/ ./

RUN mvn package $MVN_OPTS

FROM openjdk:11-jre-slim
ARG JARFILE

ENTRYPOINT ["java", "-jar", "app.jar"]

COPY --from=builder $JARFILE ./app.jar