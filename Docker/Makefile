.PHONY: build-all
build-all: build-baza build-builder build-amf build-ausf build-bsf build-nrf build-nssf build-pcf build-scp build-smf build-udm build-udr build-upf build-webui
open5gs:
	git clone https://github.com/KedArch/open5gs
build-baza: build-baza
	docker build --tag baza baza
build-builder: build-baza open5gs
	docker build --tag builder -f builder/Dockerfile .
build-amf: build-baza build-builder
	docker build --tag amf amf
build-ausf: build-baza build-builder
	docker build --tag ausf ausf
build-bsf: build-baza build-builder
	docker build --tag bsf bsf
build-nrf: build-baza build-builder
	docker build --tag nrf nrf
build-nssf: build-baza build-builder
	docker build --tag nssf nssf
build-pcf: build-baza build-builder
	docker build --tag pcf pcf
build-scp: build-baza build-builder
	docker build --tag scp scp
build-smf: build-baza build-builder
	docker build --tag smf smf
build-udm: build-baza build-builder
	docker build --tag udm udm
build-udr: build-baza build-builder
	docker build --tag udr udr
build-upf: build-baza build-builder
	docker build --tag upf upf
build-webui: open5gs
	docker build --tag webui -f open5gs/docker/webui/Dockerfile open5gs
