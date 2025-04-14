#!/usr/bin/env bash

[ "$(id -u)" -eq 0 ] || {
    echo "Must be run with root privileges"
    exit 1
}

function deploy () {
    mkdir -p /usr/local/bin/ || exit 1

    install -m 755 pmxcfs-ram.sh /usr/local/bin/pmxcfs-ram.sh || exit 1
    echo "-> installed /usr/local/bin/pmxcfs-ram.sh"

    install -m 644 pmxcfs-ram.service /etc/systemd/system/pmxcfs-ram.service || exit 1
    echo "-> installed /etc/systemd/system/pmxcfs-ram.service"
}

function enable_service () {
    systemctl enable pmxcfs-ram.service
    echo "++ enabled pmxcfs-ram.service"
}

deploy

systemctl -q is-active pmxcfs-ram && {
    echo "## update successful"
    echo "## now reboot to reload the service"
} || {
    enable_service

    echo "## installation successful"
    echo "## now reboot to activate the service"
}
