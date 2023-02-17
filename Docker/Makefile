.PHONY: build-all
build-all: build-baza build-amf build-ausf build-bsf build-nrf build-nssf build-pcf build-scp build-smf build-udm build-udr build-upf build-webui
build-baza:
	docker build --tag baza baza
build-amf: build-baza
	docker build --tag amf amf
build-ausf: build-baza
	docker build --tag ausf ausf
build-bsf: build-baza
	docker build --tag bsf bsf
build-nrf: build-baza
	docker build --tag nrf nrf
build-nssf: build-baza
	docker build --tag nssf nssf
build-pcf: build-baza
	docker build --tag pcf pcf
build-scp: build-baza
	docker build --tag scp scp
build-smf: build-baza
	docker build --tag smf smf
build-udm: build-baza
	docker build --tag udm udm
build-udr: build-baza
	docker build --tag udr udr
build-upf: build-baza
	docker build --tag upf upf
build-webui:
	chmod +x webui/download.sh
	./webui/download.sh
	docker build --tag webui webui
