FROM baza:latest

COPY --from=builder:latest /lib/x86_64-linux-gnu /lib
COPY --from=builder:latest /bin/open5gs-nssfd /bin/open5gs-nssfd
COPY setup.sh /root/setup.sh

#ENV NSSF_ADDR=
#ENV NSSF_PORT=
#ENV NSI_ADDR=
#ENV NSI_PORT=
#ENV SCP_ADDR=
#ENV SCP_ADDR=
#ENV NRF_PORT=
#ENV NRF_PORT=
#ENV LOG_ADDR=
#ENV LOG_PORT=
#ENV USE_UDP=

RUN chmod +x /root/setup.sh

CMD /root/setup.sh
