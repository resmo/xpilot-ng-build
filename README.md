# XPilot-ng Build

Debian does not include a xpilot package anymore, let's build it with help of a container.

## Make Build: tar.gz with binaries

To make a new build, you need `podman` and `make` to be installed!

```
make package
```

## Install existing build

```
make install
```

or download the release from ./dist then run

```
sudo tar xzvf ./dist/xpilot-ng-*.tar.gz -C /usr/local

```

## Install user config

```
make download-user-config
```

## Run a server

```
/usr/local/bin/xpilot-ng-server -map /usr/local/share/xpilot-ng/maps/draemmap2.xp
```

## Run a client:
```
/usr/local/bin/xpilot-ng-server -map /usr/local/share/xpilot-ng/maps/draemmap2.xp
```
