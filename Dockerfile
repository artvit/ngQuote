FROM node AS builder
COPY . /build
WORKDIR /build
RUN npm ci
RUN npm run build -- --prod

FROM nginx
COPY --from=builder /build/dist /www
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD nginx -g 'daemon off;'
