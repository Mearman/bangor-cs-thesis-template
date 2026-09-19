#!/usr/bin/env bash
# Stamp the released version and date into every module header. Runs in the release workflow only, on Linux CI; contributors never need it.
set -euo pipefail

version="$1"
date="$(date +%Y/%m/%d)"

for f in bangor.sty bangoridentity.sty bangorlayout.sty \
         bangordeclarations.sty bangorletter.sty bangorthesis.cls; do
  python3 - "$f" "$date" "$version" << 'EOF'
import re
import sys

path, date, version = sys.argv[1:4]
src = open(path).read()
pattern = re.compile(
    r"(\\(?:ProvidesPackage|ProvidesClass)\{[^}]+\}\[)"
    r"\d{4}/\d{2}/\d{2} v[\d.]+")
new, count = pattern.subn(
    r"\g<1>" + date + " v" + version, src, count=1)
if count != 1:
    sys.exit("no version header found in " + path)
open(path, "w").write(new)
EOF
done

grep -h "v${version}" bangor.sty bangorthesis.cls >/dev/null
echo "stamped v${version} (${date}) into module headers"
