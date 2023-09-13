#!/usr/bin/env bash
git clone https://github.com/KedArch/open5gs
git -C open5gs checkout v2.6.0
for I in baza builder amf ausf bsf nrf nssf pcf scp smf udm udr upf; do
  docker build --tag 192.168.39.1:5000/$I:${1:-latest} $I
  docker image push 192.168.39.1:5000/$I:${1:-latest}
done
docker build --tag 192.168.39.1:5000/webui:${1:-latest} -f open5gs/docker/webui/Dockerfile open5gs
docker image push 192.168.39.1:5000/webui:${1:-latest}
