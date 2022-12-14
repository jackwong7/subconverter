#build
FROM node:12-alpine as build

WORKDIR /app

RUN apk add --no-cache wget git \
    && git clone https://github.com/CareyWang/sub-web \
    && cd sub-web \
    && yarn install \
    && yarn build

#nginx
FROM nginx:1.16-alpine
COPY --from=build /app/sub-web/dist /usr/share/nginx/html

#sub service
ADD . /var/dev/
WORKDIR /var/dev/
RUN chmod 777 ./docker-entrypoint.sh \
    && wget https://github.com/tindy2013/subconverter/releases/download/v0.7.2/subconverter_aarch64.tar.gz \
    && tar -zxvf subconverter_aarch64.tar.gz && rm subconverter_aarch64.tar.gz


EXPOSE 80
ENTRYPOINT ["./docker-entrypoint.sh"]