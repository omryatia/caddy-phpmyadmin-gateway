#!/bin/sh
set -eu

if [ -z "${BASIC_AUTH_USER:-}" ]; then
  echo "BASIC_AUTH_USER is required"
  exit 1
fi

if [ -z "${BASIC_AUTH_PASSWORD:-}" ]; then
  echo "BASIC_AUTH_PASSWORD is required"
  exit 1
fi

if [ -z "${PMA_UPSTREAM:-}" ]; then
  echo "PMA_UPSTREAM is required"
  exit 1
fi

export BASIC_AUTH_PASSWORD_HASH="$(caddy hash-password --plaintext "$BASIC_AUTH_PASSWORD")"

exec caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
