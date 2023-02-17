FROM baza:latest

RUN add-apt-repository ppa:open5gs/latest && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends open5gs-upf && \
    apt-get clean
COPY setup.sh /root/setup.sh

#ENV PFCP_ADDR=
#ENV GTPU_ADDR=
#ENV SUBNET_ADDR=
#ENV METRICS_ADDR=
#ENV METRICS_PORT=
#ENV SMF_ADDR=

RUN chmod +x /root/setup.sh

CMD /root/setup.sh
