FROM ghcr.io/cirruslabs/flutter:3.41.3 AS build

WORKDIR /app

COPY . .

RUN flutter pub get && \
    flutter build web --release

FROM nginx:alpine

COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
