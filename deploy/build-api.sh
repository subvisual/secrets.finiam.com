#!/usr/bin/env bash
# exit on error
set -o errexit

cd api

# Initial setup
mix deps.get --only prod
MIX_ENV=prod mix compile

# Compile assets
mkdir -p priv/static
mix phx.digest

# Build the release and overwrite the existing release directory
MIX_ENV=prod mix release --overwrite
