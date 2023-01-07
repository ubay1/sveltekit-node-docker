FROM node:16.19-alpine3.16 as build-stage
WORKDIR /app
COPY package.json package-lock.json ./
COPY ./ .
RUN npm run build

FROM node:16.19.0-alpine3.16
USER node:node
WORKDIR /app
COPY --from=builder --chown=node:node /app/build ./build
COPY --from=builder --chown=node:node /app/node_modules ./node_modules
COPY --chown=node:node package.json .
CMD ["node","build"]