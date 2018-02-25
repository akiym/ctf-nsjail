FROM ubuntu:16.04

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        bison \
        ca-certificates \
        flex \
        g++ \
        gcc \
        git \
        libprotobuf-dev \
        libprotobuf9v5 \
        make \
        pkg-config \
        protobuf-compiler \
    && git clone --depth=1 --branch=2.5 https://github.com/google/nsjail.git /nsjail \
    && cd /nsjail \
    && make \
    && mv /nsjail/nsjail /usr/sbin \
    && apt-get remove --purge -y \
        bison \
        ca-certificates \
        flex \
        g++ \
        gcc \
        git \
        libprotobuf-dev \
        make \
        pkg-config \
        protobuf-compiler \
        $(apt-mark showauto) \
    && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* /nsjail

CMD ["/usr/sbin/nsjail", "-Mo", "--user", "31337", "--group", "31337", "--chroot", "/", "--", "/bin/sh"]
