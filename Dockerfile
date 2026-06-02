FROM node:20-alpine AS builder

WORKDIR /app

COPY app/package*.json ./
RUN npm install --legacy-peer-deps

COPY app/ .

RUN npm run build

FROM node:20-alpine AS runner

WORKDIR /app

RUN npm install -g serve

COPY --from=builder /app/build ./build

EXPOSE 3000

CMD ["serve", "-s", "build", "-l", "3000"]
