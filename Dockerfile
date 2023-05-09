FROM traefik:latest as my-proxy
ADD ./traefik.yaml /etc/traefik/traefik.yaml
ADD ./routers.yaml /etc/traefik/routers/routers.yaml

FROM nginx:latest as my-gateway
ADD ./nginx.conf /etc/nginx/nginx.conf
