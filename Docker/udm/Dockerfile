FROM baza:latest

COPY --from=builder:latest /bin/open5gs-udmd /bin/open5gs-udmd
COPY --from=builder:latest /lib/x86_64-linux-gnu /lib
COPY setup.sh /root/setup.sh

#ENV UDM_ADDR=
#ENV UDM_PORT=
#ENV SCP_ADDR=
#ENV SCP_PORT=
#ENV NRF_ADDR=
#ENV NRF_PORT=

RUN chmod +x /root/setup.sh

CMD /root/setup.sh
