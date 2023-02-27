FROM baza:latest

COPY --from=builder:latest /bin/open5gs-pcfd /bin/open5gs-pcfd
COPY --from=builder:latest /lib/x86_64-linux-gnu /lib
COPY setup.sh /root/setup.sh

#ENV DB_URI=
#ENV PCF_ADDR=
#ENV PCF_PORT=
#ENV METRIC_ADDR=
#ENV METRIC_PORT=
#ENV SCP_ADDR=
#ENV SCP_PORT=
#ENV NRF_ADDR=
#ENV NRF_PORT=

RUN chmod +x /root/setup.sh

CMD /root/setup.sh
