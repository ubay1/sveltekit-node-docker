FROM node:16.19-alpine3.16 AS builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
RUN npm run build && npm prune --production

# Second stage removes src files and reduces the size.
FROM node:16.19-alpine3.16
USER node:node
WORKDIR /app
COPY --from=builder --chown=node:node /app/build ./build
COPY --from=builder --chown=node:node /app/server.js ./server.js
COPY --from=builder --chown=node:node /app/node_modules ./node_modules
COPY --chown=node:node package.json .
ENV PORT 3000
ENV PUBLIC_BASE_URL=/api/v1
ENV PUBLIC_BASE_API_URL=https://sehatindonesiaku-api-dev.dto.kemkes.go.id
ENV PUBLIC_BACKFILL_API_URL=https://backfill-asik-dev.dto.kemkes.go.id
ENV PUBLIC_ENV=development
ENV PUBLIC_ILP_API_URL=https://api-ilp-dev.dto.kemkes.go.id
ENV PUBLIC_ILP_API_TOKEN=2vFZvr6V7n1IImiio0Fk1nGIBo4In41iSovMGib3cuqjiVIFWCR580cFYXiACrI3o6KAgublg48pWVaXCHoeifhCKB23k1eel85mz7BW8yD4VUpJ7R8nCoxX3UH5Lonl
ENV PUBLIC_CAPTCHA_API_URL=https://dev-captcha-api.dto.kemkes.go.id
ENV PUBLIC_CAPTCHA_CLIENT_ID=d1794f35-1390-4dcf-bb6f-dc32a4ad4ed3
ENV PUBLIC_GRAFIK_WHO_API_URL=https://services.playground-unicef.id
EXPOSE 3000
CMD ["npm","run","start"]
