#!/usr/bin/env bash

# Stop if any command fails.
set -e

# Stop on unset variables.
set -u

# Be in project root.
cd "${0%/*}/.."

# Have dependencies from npm ready.
npm i

# Have clean distribution directory.
rm -r dist || true

# Copy static resources.
cp -r src/_dist dist

# Compile application.
elm make src/ElmShop/Api.elm --output "dist/.app/elm.js" --optimize
elm-ffi "dist/.app/elm.js"
{
  uglifyjs "dist/.app/elm.js" --compress 'pure_funcs=[F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9],pure_getters,passes=2,unsafe_comps,unsafe'
  uglifyjs "dist/.app/main.js" --compress
} | uglifyjs --output "dist/.app/main.js" --mangle
rm "dist/.app/elm.js"
