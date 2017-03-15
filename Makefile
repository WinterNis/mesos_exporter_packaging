BUILD_DIR=./build

.PHONY: build
build: clean
	mkdir -p $(BUILD_DIR)
	wget -P $(BUILD_DIR) https://github.com/WinterNis/mesos_exporter/archive/v$(VERSION).zip
	unzip -q -d $(BUILD_DIR) $(BUILD_DIR)/v$(VERSION).zip
	cd $(BUILD_DIR)/mesos_exporter-$(VERSION) && go get && go build -o mesos_exporter
	mv $(BUILD_DIR)/mesos_exporter-$(VERSION)/mesos_exporter $(BUILD_DIR)

.PHONY: deb
deb:
	rm -f mesos_exporter*.deb
	fpm -m "<WinterNis>" \
	  -n mesos_exporter \
		-d logrotate \
		-s dir -t deb \
		-a all \
		--description "Prometheus exporter for OS mesos" \
		--url "https://github.com/WinterNis/mesos_exporter" \
		--license "Apache 2 License" \
		--deb-user mesos_exporter \
		--deb-group mesos_exporter \
		--deb-no-default-config-files \
		--directories /var/log/mesos_exporter \
		--deb-systemd deb/mesos_exporter.service \
		--before-install deb/before-install.sh \
		--after-install deb/after-install.sh \
		--before-upgrade deb/before-upgrade.sh \
		--after-upgrade deb/after-upgrade.sh \
		--before-remove deb/before-remove.sh \
		--after-remove deb/after-remove.sh \
		--inputs deb/input

.PHONY: clean
clean:
		rm -rf build
		rm -f *.deb
