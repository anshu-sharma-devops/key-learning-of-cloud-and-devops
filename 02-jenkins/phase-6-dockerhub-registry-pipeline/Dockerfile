FROM nginx:alpine

LABEL maintainer="Anshu Sharma"
LABEL project="Jenkins Phase 6 Docker Hub Registry Pipeline"

COPY app/index.html /usr/share/nginx/html/index.html

EXPOSE 80

HEALTHCHECK --interval=10s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --quiet --tries=1 --spider http://localhost/ || exit 1