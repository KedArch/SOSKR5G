FROM baza:latest

RUN add-apt-repository ppa:open5gs/latest && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends open5gs-amf && \
    apt-get clean
COPY setup.sh /root/setup.sh

ENV SBI_ADDR=
ENV NGAP_ADDR=
ENV METRICS_ADDR=
ENV SCP_ADDR=
ENV MCC=001
ENV MNC=01
ENV NETWORK_NAME=
ENV NAME=

RUN chmod +x /root/setup.sh

CMD /root/setup.sh
