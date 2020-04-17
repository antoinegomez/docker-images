#!/usr/bin/env bash
set -eu

kong migrations bootstrap

exec "$@"
