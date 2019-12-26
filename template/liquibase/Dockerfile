ARG LIQUIBASE_FROM=docker.pkg.github.com/chriskolenko/liquibase/liquibase:0.1.0
FROM ${LIQUIBASE_FROM}

# COPY service files and folders
COPY service/ /liquibase/workspace

CMD ["liquibase ", "update"]