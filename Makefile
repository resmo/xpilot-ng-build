cleanup:
	@echo "Cleaning up previous build directories..."
	@rm -rf ./tmp ./bin ./share
	@mkdir -p ./tmp/bin ./tmp/share/xpilot-ng
	@mkdir -p ./bin ./share/xpilot-ng
	@rm -rf ./dist/*
	@echo "Cleanup done."

build: cleanup
	@echo "Building xpilot-ng..."
	podman build -t xpilot-ng:latest .
	podman run -d -v ./tmp/bin:/usr/local/bin -v ./tmp/share/xpilot-ng:/usr/local/share/xpilot-ng xpilot-ng:latest sleep 20
	cp -r ./tmp/share/xpilot-ng ./share/xpilot-ng
	cp -r ./tmp/bin ./bin

package: build download-add-maps
	@echo "Packaging xpilot-ng..."
	@mkdir -p ./dist
	cd ./tmp && tar czvf ../dist/xpilot-ng-$(shell date +%Y%m%d).tar.gz bin share

install:
	@echo "Installing xpilot-ng package..."
	sudo mkdir -p /usr/local/share/xpilot-ng && sudo chmod 0755 /usr/local/share/xpilot-ng
	sudo tar xzvf ./dist/xpilot-ng-*.tar.gz -C /usr/local

download-add-maps:
	@echo "Downloading additional draemmaps..."
	@mkdir -p share/xpilot-ng/maps
	wget -O share/xpilot-ng/maps/draemmap2.xp https://www.lugbe.ch/xpilot/draemmap2.xp
	wget -O share/xpilot-ng/maps/draemmap3.xp https://www.lugbe.ch/xpilot/draemmap3.xp

download-user-config:
	@echo "Downloading default configuration into home directory..."
	wget -O ~/.xpilotrc https://www.lugbe.ch/xpilot/.xpilotrc

server:
	/usr/local/bin/xpilot-ng-server -map /usr/local/share/xpilot-ng/maps/draemmap2.xp

client:
	/usr/local/bin/xpilot-ng-x11 -join
