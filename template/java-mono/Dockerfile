FROM maven:3.6 as builder

ARG MVN_OPTS

# COPY function files and folders
COPY function/ ./

RUN mvn package $MVN_OPTS

RUN mkdir /out
RUN find . -type f -name "*.jar" -exec cp {} /out \;

FROM openjdk:11-alpine

ARG JARFILE

COPY --from=builder /out/$JARFILE ./app.jar

CMD ["java", "app.jar"]