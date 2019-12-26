ARG LIQUIBASE_FROM=chriskolenko/liquibase:0.1.2
FROM ${LIQUIBASE_FROM}

ENV LIQUIBASE_CHANGELOG=/liquibase/workspace/changelog.xml

# COPY service files and folders
COPY service/ /liquibase/workspace

CMD ["liquibase", "update"]