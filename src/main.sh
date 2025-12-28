#!/bin/bash

set -euo pipefail

function print_info() {
    local MESSAGE=$1
    echo "INFO: ${MESSAGE}"
}

function print_error() {
    local MESSAGE=$1
    echo "ERROR:: ${MESSAGE}"
}

function set_output() {
    GITHUB_OUTPUT=${GITHUB_OUTPUT:?"GITHUB_OUTPUT is not set"}

    local KEY=$1
    local VALUE=$2

    print_info "Setting output: ${KEY}=${VALUE}"
    {
        echo "${KEY}<<EOF"
        echo "${VALUE}"
        echo "EOF"
    } >> "${GITHUB_OUTPUT}"
}

function main() {
    OWNER=${OWNER:?"OWNER is not set"}
    REPO=${REPO:?"REPO is not set"}
    REF=${REF:?"REF is not set"}
    GH_TOKEN=${GH_TOKEN:?"GH_TOKEN is not set"}

    print_info "Getting ref info..."
    set +e
    response=$( \
        gh api \
        -H "Accept: application/vnd.github+json" \
        -H "X-GitHub-Api-Version: 2022-11-28" \
        "/repos/${OWNER}/${REPO}/git/ref/${REF}" \
    )
    exit_code=$?
    set -e

    print_info "Exit code: ${exit_code}"
    print_info "Response: ${response}"

    if [[ "${exit_code}" -ne 0 ]]; then
        response_code=$(echo "${response}" | jq -r '.status')
        if [[ "${response_code}" == "404" ]]; then
            print_info "Ref not found, exiting..."
            set_output "exists" "false"
            exit 0
        fi

        print_error "Failed to get ref info, exiting..."
        exit 1
    fi

    sha=$(echo "${response}" | jq -r '.object.sha')
    type=$(echo "${response}" | jq -r '.object.type')

    set_output "exists" "true"
    set_output "ref" "${REF}"
    set_output "sha" "${sha}"
    set_output "type" "${type}"
}

main "$@"
