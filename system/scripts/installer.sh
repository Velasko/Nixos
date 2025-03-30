#!/usr/bin/env bash
# git clone https://github.com/velasko/nixos $HOME/nixos

case $(cat /sys/class/dmi/id/product_uuid) in
	"03ff0210-04e0-05f0-2406-800700080009")
		MACHINE="desktop"
		;;
	"2bc99f80-f604-11ee-8226-ebae00cc1200")
		MACHINE="book4"
		;;
esac

if [[ $(cat /proc/cpuinfo | grep hypervisor | wc -l) -gt 0 ]]; then
	echo "aaaa"
fi
