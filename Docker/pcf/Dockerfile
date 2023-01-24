FROM baza:latest

RUN add-apt-repository ppa:open5gs/latest && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends open5gs-pcf && \
    apt-get clean
COPY setup.sh /root/setup.sh

#ENV DB_URI=
#ENV SBI_ADDR=
#ENV METRIC_ADDR=
#ENV SCP_ADDR=

RUN chmod +x /root/setup.sh

CMD /root/setup.sh
