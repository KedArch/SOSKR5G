FROM baza:latest

COPY --from=builder:latest /bin/open5gs-amfd /bin/open5gs-amfd
COPY --from=builder:latest /lib/x86_64-linux-gnu /lib
COPY setup.sh /root/setup.sh

#ENV AMF_ADDR=
#ENV AMF_PORT=
#ENV NGAP_ADDR=
#ENV METRICS_ADDR=
#ENV METRICS_PORT=
#ENV MCC=001
#ENV MNC=01
#ENV REGION=2
#ENV SET=1
#ENV NETWORK_NAME=
#ENV SCP_ADDR=
#ENV SCP_PORT=
#ENV NRF_ADDR=
#ENV NRF_PORT=

RUN chmod +x /root/setup.sh

CMD /root/setup.sh
