FROM baza:latest

RUN apt-get install -y iptables
COPY --from=builder:latest /bin/open5gs-upfd /bin/open5gs-upfd
COPY --from=builder:latest /lib/x86_64-linux-gnu /lib
COPY setup.sh /root/setup.sh

#ENV PFCP_ADDR=
#ENV GTPU_ADDR=
#ENV SUBNET_ADDR=
#ENV METRICS_ADDR=
#ENV METRICS_PORT=
#ENV SMF_ADDR=

RUN chmod +x /root/setup.sh

CMD /root/setup.sh
