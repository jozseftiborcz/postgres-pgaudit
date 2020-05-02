FROM postgres:12-alpine
RUN apk update && \
  apk add \
    curl \
    gcc \
    make \
    libc-dev \
    openssl-dev \
    clang \
    llvm && \
  mkdir -p /tmp/pgaudit && \
  cd /tmp/pgaudit && \
  curl -L https://github.com/pgaudit/pgaudit/archive/1.4.0.tar.gz | tar xz --strip 1 && \
  make -C /tmp/pgaudit/ install USE_PGXS=1 && \
  apk del curl gcc make libc-dev openssl-dev clang llvm

COPY pgaudit-docker-entrypoint.sh /usr/local/bin/
COPY init.sql /docker-entrypoint-initdb.d/

ENTRYPOINT ["pgaudit-docker-entrypoint.sh"]
CMD ["postgres"]
