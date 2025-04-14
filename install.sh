#!/usr/bin/env bash

systemctl -q is-active pmxcfs-ram && {
    echo "ERROR: pmxcfs-ram is already installed and running."
    exit 1
}

[ "$(id -u)" -eq 0 ] || {
    echo "Must be run with root privileges"
    exit 1
}

mkdir -p /usr/local/bin/ || exit 1
install -m 755 pmxcfs-ram.sh /usr/local/bin/pmxcfs-ram.sh || exit 1
echo "++ installed /usr/local/bin/pmxcfs-ram.sh"

install -m 644 pmxcfs-ram.service /etc/systemd/system/pmxcfs-ram.service || exit 1
echo "++ installed /etc/systemd/system/pmxcfs-ram.service"

systemctl enable pmxcfs-ram.service
echo "++ enabled pmxcfs-ram.service"

echo "## installation successful"
echo "## now reboot to activate the service"