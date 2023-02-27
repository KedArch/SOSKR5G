FROM baza:latest

COPY --from=builder:latest /bin/open5gs-smfd /bin/open5gs-smfd
COPY --from=builder:latest /lib/x86_64-linux-gnu /lib
COPY setup.sh /root/setup.sh

#ENV SMF_ADDR=
#ENV SMF_PORT=
#ENV PFCP_ADDR=
#ENV GTPC_ADDR=
#ENV GTPU_ADDR=
#ENV METRICS_ADDR=
#ENV METRICS_PORT=
#ENV SUBNET_ADDR=
#ENV DNS_ADDR=
#ENV SCP_ADDR=
#ENV SCP_PORT=
#ENV NRF_ADDR=
#ENV NRF_PORT=
#ENV UPF_ADDR=

RUN chmod +x /root/setup.sh

CMD /root/setup.sh
