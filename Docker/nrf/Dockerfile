FROM baza:latest

COPY --from=builder:latest /bin/open5gs-nrfd /bin/open5gs-nrfd
COPY --from=builder:latest /lib/x86_64-linux-gnu /lib
COPY setup.sh /root/setup.sh

#ENV NRF_ADDR=
#ENV NRF_PORT=
#ENV SCP_ADDR=
#ENV SCP_PORT=

RUN chmod +x /root/setup.sh

CMD /root/setup.sh
