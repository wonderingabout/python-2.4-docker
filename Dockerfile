# Build a small Docker image containing CPython 2.4.6.
# This is meant for legacy Python 2.4 syntax/compile checks, not modern Python development.

FROM debian:bookworm-slim AS build

ARG PYTHON_VERSION=2.4.6

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        ca-certificates \
        curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp/python-build

RUN curl -fsSLO "https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz" \
    && tar -xzf "Python-${PYTHON_VERSION}.tgz" \
    && cd "Python-${PYTHON_VERSION}" \
    && ./configure --prefix="/opt/python-${PYTHON_VERSION}" CFLAGS="-O2 -fcommon" \
    && make -j"$(nproc)" \
    && make install

FROM debian:bookworm-slim

ARG PYTHON_VERSION=2.4.6

COPY --from=build "/opt/python-${PYTHON_VERSION}" "/opt/python-${PYTHON_VERSION}"

RUN ln -s "/opt/python-${PYTHON_VERSION}/bin/python" /usr/local/bin/python \
    && ln -s "/opt/python-${PYTHON_VERSION}/bin/python" /usr/local/bin/python2.4

CMD ["python", "-V"]
