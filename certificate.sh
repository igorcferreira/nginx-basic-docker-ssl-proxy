#!/usr/bin/env bash

HOST=""
CONTACT_EMAIL=""

while [ -n "$1" ]; do
    case "$1" in
        --host | -h) HOST="$2" && shift;;
        --email | -e) CONTACT_EMAIL="$2" && shift;;
    esac
    shift
done

if [ -z "${HOST}" ]; then
    echo "Please, provide a host to be used with the '--host' argument. Example:"
    echo "$ ./certificate.sh --host website.domain.com --email user@website.domain.com"
    exit 1
fi

if [ -z "${CONTACT_EMAIL}" ]; then
    echo "Please, provide a host to be used with the '--email' argument. Example:"
    echo "$ ./certificate.sh --host website.domain.com --email user@website.domain.com"
    exit 1
fi

docker run \
  -v letsencrypt:/etc/letsencrypt \
  -v acme-challenge:/var/www/challenge/.well-known/acme-challenge \
  --name certbot \
  "certbot/certbot" \
  certonly --webroot -w /var/www/challenge -d "${HOST}" -m "${CONTACT_EMAIL}" --agree-tos