FROM baza:latest

COPY --from=builder:latest /lib/x86_64-linux-gnu /lib
COPY --from=builder:latest /bin/open5gs-ausfd /bin/open5gs-ausfd
COPY setup.sh /root/setup.sh

#ENV AUSF_ADDR=
#ENV AUSF_PORT=
#ENV SCP_ADDR=
#ENV SCP_PORT=
#ENV NRF_ADDR=
#ENV NRF_PORT=
#ENV LOG_ADDR=
#ENV LOG_PORT=
#ENV USE_UDP=

RUN chmod +x /root/setup.sh

CMD /root/setup.sh
