#/bin/bash

STATE_SAVE_FILE="${HOME}/.config/picom/state_save_file"

if [ ! -f ${STATE_SAVE_FILE} ];
then
    touch ${STATE_SAVE_FILE}
    echo "off" > ${STATE_SAVE_FILE}
fi

LAST_STATE="$(cat ${STATE_SAVE_FILE})"

if [ "${1}" == "reload" ];
then
    if [ "${LAST_STATE}" == "on" ];
    then
        picom -b
    fi

elif [ "${1}" == "toggle" ]
then
    if [ "${LAST_STATE}" == "on" ];
    then
        killall -q picom
        echo "off" > ${STATE_SAVE_FILE}
    elif [ "${LAST_STATE}" == "off" ]
    then
        picom -b
        echo "on" > ${STATE_SAVE_FILE}
    else
        echo "ERROR: wrong parameter in ${STATE_SAVE_FILE}" >&2
        exit 1
    fi
fi
