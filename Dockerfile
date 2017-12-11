FROM maven:3-jdk-8

ARG PROTO_VERSION=2.6.1

RUN     cd /tmp && apt-get update \
        && apt-get install -y autoconf libtool curl make g++ unzip wget \
        && curl -sL https://deb.nodesource.com/setup_6.x | bash - \
        && apt-get install -y nodejs \
        && wget https://github.com/google/protobuf/releases/download/v${PROTO_VERSION}/protobuf-${PROTO_VERSION}.zip \
        && unzip protobuf-${PROTO_VERSION}.zip \
        && cd /tmp/protobuf-${PROTO_VERSION} \
        && ./autogen.sh \
        && ./configure && make && make check && make install && ldconfig \
        && cd /tmp && rm -rf /tmp/protobuf-${PROTO_VERSION} && rm /tmp/protobuf-${PROTO_VERSION}.zip && rm -rf /var/lib/apt/lists/*

ENV LD_LIBRARY_PATH /usr/local/lib:${LD_LIBRARY_PATH}
