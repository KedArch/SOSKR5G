FROM baza:latest

COPY open5gs /open5gs

WORKDIR /open5gs

RUN meson build --prefix=/ && ninja -C build && cd build && ninja install
