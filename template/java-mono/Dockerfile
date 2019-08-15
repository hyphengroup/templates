FROM maven:3.6 as builder

# COPY function files and folders
COPY function/ ./

RUN mvn package

RUN mkdir /out
RUN find . -type f -name "*.jar" -exec cp {} /out \;

FROM openjdk:11-alpine

COPY --from=builder /out ./

CMD ["java", "-version"]