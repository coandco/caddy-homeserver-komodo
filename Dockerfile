ARG CADDY_VERSION=2.10.12
FROM caddy:${CADDY_VERSION}-builder AS builder

RUN XCADDY_DEBUG=1 xcaddy build \
    --with github.com/lucaslorentz/caddy-docker-proxy/v2 \
    --with github.com/mholt/caddy-dynamicdns \
    --with github.com/sablierapp/sablier/plugins/caddy \
    --with github.com/hslatman/caddy-crowdsec-bouncer/http \
    --with github.com/hslatman/caddy-crowdsec-bouncer/appsec \
    --with github.com/gsmlg-dev/caddy-admin-ui@main \
    --with github.com/pberkel/caddy-storage-redis \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/caddyserver/transform-encoder \
    --with github.com/mholt/caddy-ratelimit \
    --with github.com/mholt/caddy-l4 \
    --with github.com/WeidiDeng/caddy-cloudflare-ip \
    --with github.com/porech/caddy-maxmind-geolocation \
    --with github.com/hslatman/caddy-crowdsec-bouncer/layer4 \
    --with github.com/corazawaf/coraza-caddy/v2 \
    --with github.com/greenpau/caddy-security \
    --with github.com/hadi77ir/caddy-websockify
    --with github.com/mholt/caddy-l4

FROM caddy:${CADDY_VERSION}-alpine

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

CMD ["caddy", "docker-proxy"]

