#!/bin/bash

set -euo pipefail

function print_info() {
    echo "INFO: $1"
}

function print_error() {
    echo "ERROR: $1"
}

function set_output() {
    KEY=$1
    VALUE=$2

    print_info "Setting output: $KEY=$VALUE"
    {
        echo "$KEY<<EOF"
        echo "$VALUE"
        echo "EOF"
    } >> "$GITHUB_OUTPUT"
}

function main() {
    OWNER=${OWNER:-}
    REPO=${REPO:-}
    REF=${REF:-}
    GH_TOKEN=${GH_TOKEN:-}

    print_info "Getting ref info..."
    set +e
    response=$( \
        gh api \
        -H "Accept: application/vnd.github+json" \
        -H "X-GitHub-Api-Version: 2022-11-28" \
        /repos/$OWNER/$REPO/git/ref/$REF \
    )
    exit_code=$?
    set -e

    print_info "Exit code: $exit_code"
    print_info "Response: $response"

    if [[ $exit_code -ne 0 ]]; then
        response_code=$(echo $response | jq -r '.status')
        if [[ "$response_code" == "404" ]]; then
            print_error "Ref not found, exiting..."
            set_output "exists" "false"
            exit 0
        fi

        print_error "Failed to get ref info, exiting..."
        exit 1
    fi

    set_output "exists" "true"
    set_output "ref" "$REF"
    set_output "sha" "$(echo $response | jq -r '.object.sha')"
    set_output "type" "$(echo $response | jq -r '.object.type')"
}

main "$@"
