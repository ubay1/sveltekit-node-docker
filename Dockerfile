FROM node:16.19.0-alpine3.16 AS build

WORKDIR /app
COPY package*.json .
RUN npm ci
COPY . .
RUN npm install nodemon -g
RUN npm run build

FROM node:16.19.0-alpine3.16 AS deploy-node
WORKDIR /app
RUN rm -rf ./*
COPY --from=build /app/build ./build
COPY --from=build /app/package.json .
COPY --from=build /app .
RUN npm ci --prod
# CMD ["npm","run", "dev:server"]


FROM node:16.19.0-alpine3.16 AS deploy-app
WORKDIR /app
COPY package*.json .
RUN npm install
COPY . .
RUN npm run build