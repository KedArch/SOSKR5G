FROM baza:latest

RUN add-apt-repository ppa:open5gs/latest && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends open5gs-bsf && \
    apt-get clean
COPY setup.sh /root/setup.sh

#ENV DB_URI=
#ENV BSF_ADDR=
#ENV BSF_PORT=
#ENV SCP_ADDR=
#ENV SCP_PORT=

RUN chmod +x /root/setup.sh

CMD /root/setup.sh
