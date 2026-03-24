# phpmyadmin-gateway

Caddy-based Basic Auth gateway for protecting phpMyAdmin on Railway.

This repository provides a small reverse proxy service that adds HTTP Basic Authentication in front of phpMyAdmin. It is designed to be used as part of a Railway template together with WordPress, MariaDB, and phpMyAdmin.

## What this service does

This service sits in front of phpMyAdmin and:

- requires a username and password before access
- proxies authenticated requests to phpMyAdmin
- exposes a simple `/healthz` endpoint for Railway health checks

## Why use this

The official phpMyAdmin image does not provide a separate built-in web username/password layer for protecting the UI. Its environment variables are mainly for database connection behavior.

This gateway adds an extra authentication layer so phpMyAdmin is not exposed directly to the public internet without protection.

## Railway usage

Use this repository as the source for the public phpMyAdmin gateway service.

Recommended Railway setup:

- WordPress: public
- MariaDB: private
- phpMyAdmin: private
- phpMyAdmin Gateway: public

## Required environment variables

Set these on the gateway service:

    BASIC_AUTH_USER=admin
    BASIC_AUTH_PASSWORD_HASH=your_caddy_password_hash
    PMA_UPSTREAM=phpmyadmin.railway.internal:80

## How to generate the password hash

Run this locally:

    docker run --rm caddy:2.11.2 caddy hash-password --plaintext 'YOUR_STRONG_PASSWORD'

Copy the output and use it as the value of:

    BASIC_AUTH_PASSWORD_HASH

## Healthcheck

This service exposes:

    /healthz

Recommended Railway healthcheck path:

    /healthz

## Notes

- Railway handles the public HTTPS certificate, so this Caddy service does not need to manage Let's Encrypt directly.
- phpMyAdmin should remain private and only be reached through this gateway.
- MariaDB should remain private and should not be exposed publicly.

## Related stack

This service is intended to be used with:

- WordPress
- MariaDB
- phpMyAdmin
- Caddy Basic Auth gateway

## License

Use and adapt as needed for your Railway template or deployment.
