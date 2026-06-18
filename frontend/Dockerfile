FROM ghcr.io/cirruslabs/flutter:3.41.3 AS build

WORKDIR /app

# Base URL the **browser** uses for API calls (baked in at build time, not overridable at nginx run).
# Local compose: default http://localhost:8000 (host ports 8000/8080).
# Remote: set the same in .env and `docker compose build frontend` (e.g. http://SERVER_IP:8000 or https://api.example.com).
ARG BACKEND_BASE_URL=http://localhost:8000

COPY . .

RUN flutter pub get && \
    flutter build web --release --dart-define=BACKEND_BASE_URL=${BACKEND_BASE_URL}

FROM nginx:alpine

COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
