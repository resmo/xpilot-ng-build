FROM docker.io/debian:12 AS build
RUN apt update && apt install -y git make gcc libexpat1-dev xserver-xorg-dev zlib1g-dev
WORKDIR /repo
RUN git clone --depth 1 https://github.com/kekyo/xpilot-ng.git .
RUN ./configure --disable-sdl-client
RUN make
RUN make install
