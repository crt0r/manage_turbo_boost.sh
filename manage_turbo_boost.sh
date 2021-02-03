#!/usr/bin/env

# Copyright (c) 2021 Timofey Chuchkanov
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
# REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
# AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
# INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
# LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
# OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
# PERFORMANCE OF THIS SOFTWARE.

EN="--enable"
DS="--disable"
ST="--status"
HE="--help"
ACTIVE="0"
INACTIVE="1"
MSG="Turbo Boost is"

write_to_no_turbo() {
	echo "$1" | tee /sys/devices/system/cpu/intel_pstate/no_turbo 1> /dev/null
}

turbo_boost_status() {
	TB_CURRENT="$(cat /sys/devices/system/cpu/intel_pstate/no_turbo)"

	if [ "$TB_CURRENT" = "$ACTIVE" ] ; then
		echo "$MSG enabled."
	elif [ "$TB_CURRENT" = "$INACTIVE" ] ; then
		echo "$MSG disabled."
	fi
}

show_help() {
	echo "manage_turbo_boost.sh: Enable/disable Intel Turbo Boost or show\
 its current state."
	printf "\
%s\t- Enable Turbo Boost.\n\
%s\t- Disable Turbo Boost.\n\
%s\t- Show current Turbo Boost status.\n\
%s\t\t- Show this message.\n" \
$EN $DS $ST $HE
}

if [ "$EN" = "$1" ] ; then
	write_to_no_turbo "$ACTIVE"
elif [ "$DS" = "$1" ] ; then
	write_to_no_turbo "$INACTIVE"
elif [ "$ST" = "$1" ] ; then
	turbo_boost_status
elif [ "$HE" = "$1" ] ; then
	show_help
else
	echo "Wrong arguments. Use with --help to learn how to use this tool."
fi
