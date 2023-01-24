FROM baza:latest

RUN add-apt-repository ppa:open5gs/latest && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends open5gs-smf && \
    apt-get clean
COPY setup.sh /root/setup.sh

#ENV SBI_ADDR=
#ENV PFCP_ADDR=
#ENV GTPC_ADDR=
#ENV GTPU_ADDR=
#ENV METRICS_ADDR=
#ENV SUBNET_ADDR=
#ENV DNS_ADDR=
#ENV SCP_ADDR=
#ENV UPF_ADDR=

RUN chmod +x /root/setup.sh

CMD /root/setup.sh
