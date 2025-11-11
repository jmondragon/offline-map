# ────────────────────────────────────────────────────────────────
# 1️⃣  Build the Vite / TS app
# ────────────────────────────────────────────────────────────────
FROM node:20-alpine AS builder

WORKDIR /app

# Install dependencies first – keeps the layer cache healthy
COPY package.json package-lock.json ./
RUN npm ci

# Copy source, build
COPY . .
RUN npm run build

FROM nginx:alpine

COPY --from=builder /app/dist /usr/share/nginx/html

VOLUME [ "/usr/share/nginx/html/tiles" ]

