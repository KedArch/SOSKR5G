FROM baza:latest

RUN add-apt-repository ppa:open5gs/latest && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends open5gs-nssf && \
    apt-get clean
COPY setup.sh /root/setup.sh

#ENV NSSF_ADDR=
#ENV NSSF_PORT=
#ENV NSI_ADDR=
#ENV NSI_PORT=
#ENV SCP_ADDR=
#ENV SCP_ADDR=
#ENV NRF_PORT=
#ENV NRF_PORT=

RUN chmod +x /root/setup.sh

CMD /root/setup.sh
