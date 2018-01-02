#!/bin/bash

set -euo pipefail

package=""
number_of_runs=30
wait_time="30s"
mem_stats_results="$TMPDIR/mem_stats_results/"

# The number of seconds since the epoch, it is used for making mem stats
# filename unique.
SCRIPT_INVOCATION_DATETIME=$(date +%s)

usage() {
    cat <<EOF
Usage: and-monitor-mem.sh [OPTION]...
    -h, --help                  usage information (this)
    -n, --number_of_runs        number of runs
    -p, --package               package of the app to test
    -w, --wait_time             wait time before ending this trace
EOF
}

parse_arguments() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -h|--help)
        usage
        exit 0
        ;;
      -n|--number_of_runs)
        number_of_runs=$2
        shift
        ;;
      -p|--package)
        package=$2
        shift
        ;;
      -w|--wait_time)
        wait_time=$2
        shift
        ;;
    esac
    shift
  done
}

# Main entry point
if [[ $# -eq 0 ]]; then
  usage
  exit 1
else
  parse_arguments "$@"

  # if we do not have have package, exit early with an error
  [[ "$package" == "" ]] && echo "Package not specified" 1>&2 && exit 1
fi


if ! mkdir -p "$mem_stats_results"; then
  echo >&2 "unable to create mem stats result directory : $mem_stats_results"
  exit 1
fi
cd "$mem_stats_results"

echo "-------------------------------------"
echo "Starting measurement"

for (( c=1; c<=number_of_runs; c++ )); do
  echo ""
  echo "Run $c "
  dumpsys meminfo |awk '/: Visible/{found=0} {if(found) print} /: Foreground/{found=1}'|tr -d ' ' >>  "$package-pss-$SCRIPT_INVOCATION_DATETIME".txt
  cat /proc/meminfo|grep -A 2 MemAvailable: >> "$package-memavailable+cache-$SCRIPT_INVOCATION_DATETIME".txt
  sleep "$wait_time"
done

dumpsys SurfaceFlinger |awk '/Start to dump Gralloc buffers info/{found=0} {if(found) print} /Allocated buffers:/{found=1}' >> "$package-SurfaceFlinger-$SCRIPT_INVOCATION_DATETIME".txt
echo ""
echo "Finished measurement"
echo "-------------------------------------"
