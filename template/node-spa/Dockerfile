ARG NODE_FROM=node:lts
FROM ${NODE_FROM} as builder

COPY service/package.json service/package-lock.json ./
RUN npm install

# COPY service files and folders
COPY service/ ./

ENV NODE_ENV=production
RUN npm run build

FROM node:lts

RUN npm install -g serve

# COPY service files and folders
COPY --from=builder build/ ./build

CMD ["serve", "-s", "-l", "80", "build"]