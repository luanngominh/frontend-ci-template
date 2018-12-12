FROM tiangolo/node-frontend:10 as build-stage

WORKDIR /app
COPY ./ /app
RUN npm run build


FROM nginx:alpine

WORKDIR /var/www/build
COPY --from=build-stage /app/build/ .
COPY deploy/default /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]


