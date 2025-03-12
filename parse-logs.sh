#!/bin/bash

is_number() {
    [[ "$1" =~ ^[0-9]+$ ]]
}

while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -l|--lines)
            if is_number "$2"; then
                LINES="$2"
            else
                echo "ERROR(is num)"
                exit 1
            fi
            shift 2
            ;;
        -o|--order)
            if [[ "$2" == "up" || "$2" == "down" ]]; then
                ORDER="$2"
            else
                echo "ERROR(order)"
                exit 1
            fi
            shift 2
            ;;
        *)
            if [[ -z "$DIR" ]]; then
                DIR="$1"
            else
                echo "ERROR(no dir)"
                exit 1
            fi
            shift
            ;;
    esac
done

LINES=${LINES:-10}
ORDER=${ORDER:-up}

if [[ -z "$DIR" || ! -d "$DIR" ]]; then
    echo "ERROR(no dir or empty)"
    exit 1
fi


CONTENT=$(find "$DIR" -type f -name "*.log" -print0 | xargs -0 cat)

LOGS=$(echo "$CONTENT" | grep -E "^\[ (INFO|DEBUG|WARNING|ERROR) \]\s+[0-9]{2}:[0-9]{2}:[0-9]{4}\s+(0|[1-9][0-9]*)\s+[a-zA-Z_]*$")


if [[ -z "$LOGS" ]]; then
    echo "LOGS NOT FOUND"
    exit 0
fi

SORTED_LOGS=$(echo "$LOGS" | sort -k5 -nr)

if [[ "$ORDER" == "up" ]]; then
    echo "$SORTED_LOGS" | head -n "$LINES"
else
    echo "$SORTED_LOGS" | tail -n "$LINES"
fi
