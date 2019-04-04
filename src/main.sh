#!/usr/bin/env bash

function read_file() {
	file="${1}"
	while IFS='' read -r line || [[ -n "${line}" ]]; do
    	echo "${line}"
	done < "${file}"
}

function states() {
	#states="../data/states"
	states="../data/test_state"
	for state in $(read_file "${states}"); do
		echo "${state}"
	done
}


# NEED TO FORMAT STATE ON INPUT TO ENSURE IT MATCHES CASE AT WIKIPEDIA
function format_state() {
	state="$(echo "${state}" | tr '[:lower:]' '[:upper:]')"
	echo "${state}"
}

function request() {
	url="${1}"
	curl -s "${url}"
}

function get_counties() {
	state="${1}"
	request "https://en.wikipedia.org/wiki/List_of_counties_in_${state}" | grep -iE "^<li>" | grep -i "_County" | grep -o "title=.*\"" | grep -o "\".*, " | tr -d ',"' | sed 's/ County//g'
}

for state in $(states); do
	echo "Main Program:"
	echo $state
	echo -e "$(get_counties "${state}")\r\n"
done
