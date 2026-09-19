#!/usr/bin/env bash
# Stamp the released version and date into every module header. Runs in the release workflow only, on Linux CI; contributors never need it.
set -euo pipefail

version="$1"
date="$(date +%Y/%m/%d)"

for f in bangor.sty bangoridentity.sty bangorlayout.sty \
         bangordeclarations.sty bangorletter.sty bangorthesis.cls; do
  sed -i.bak -E \
    "s|^((\\\\Provides(Package|Class))\\{[^}]+\\}\\[)[0-9]{4}/[0-9]{2}/[0-9]{2} v[0-9]+\\.[0-9]+\\.[0-9]+|\\1${date} v${version}|" \
    "$f"
  rm -f "$f.bak"
done

grep -h "v${version}" bangor.sty bangorthesis.cls >/dev/null
echo "stamped v${version} (${date}) into module headers"
