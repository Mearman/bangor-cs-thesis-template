#!/usr/bin/env python3
"""Check that a running header is aligned to the edges of the text block.

Usage: check-header-alignment.py PDF LEFT_WORD RIGHT_WORD

Finds the first page whose header line holds both words, then compares the header's left and right edges with those of everything else on the page (the body and the footer, which are set to the same text block). The words in the header share one baseline, so words on that line are the header and every other word is not. The edges must agree to within two points, which allows for the side bearings of the glyphs and the rounding of the extracted word boxes.
"""

import re
import subprocess
import sys

TOLERANCE_POINTS = 2.0
WORD = re.compile(
    r'<word xMin="([\d.]+)" yMin="([\d.]+)" xMax="([\d.]+)" yMax="([\d.]+)">([^<]*)</word>'
)


def run(command: list[str]) -> str:
    return subprocess.run(command, capture_output=True, text=True, check=True).stdout


def main() -> int:
    pdf, left_word, right_word = sys.argv[1:4]
    pages = int(re.search(r"Pages:\s+(\d+)", run(["pdfinfo", pdf])).group(1))
    for page in range(1, pages + 1):
        html = run(["pdftotext", "-f", str(page), "-l", str(page), "-bbox", pdf, "-"])
        words = [(float(a), float(b), float(c), w) for a, b, c, _, w in WORD.findall(html)]
        lefts = [w for w in words if w[3] == left_word]
        if not lefts:
            continue
        line_y = lefts[0][1]
        header = [w for w in words if abs(w[1] - line_y) < TOLERANCE_POINTS]
        if not any(w[3] == right_word for w in header):
            continue
        rest = [w for w in words if abs(w[1] - line_y) >= TOLERANCE_POINTS]
        left_gap = min(w[0] for w in header) - min(w[0] for w in rest)
        right_gap = max(w[2] for w in rest) - max(w[2] for w in header)
        print(f"page {page}: header left edge off by {left_gap:.1f}pt, right edge off by {right_gap:.1f}pt")
        if abs(left_gap) > TOLERANCE_POINTS or abs(right_gap) > TOLERANCE_POINTS:
            print("the header is not aligned to the text block")
            return 1
        return 0
    print(f"no page has a header line holding both {left_word!r} and {right_word!r}")
    return 1


if __name__ == "__main__":
    sys.exit(main())
