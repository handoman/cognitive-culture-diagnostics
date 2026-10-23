#!/usr/bin/env bash
# CCF monograph: merge chapters + appendices -> single PDF via Pandoc/XeLaTeX
#
# Usage:
#   scripts/build-pdf.sh [repo_dir]
#   (defaults to the directory two levels up from this script)
#
# Mirrors the original (2026-07) one-off export, with two bugs fixed
# along the way (see notes below):
#   PowerShell merge:
#     $main = Get-ChildItem .\*.md | Sort-Object Name
#     $appendix = Get-ChildItem .\appendix\*.md | Sort-Object Name
#     Get-Content ($main.FullName + $appendix.FullName) |
#       Set-Content -Path .\ccf_monografi_full.md -Encoding utf8
#   Pandoc (WSL):
#     pandoc (Get-ChildItem *.md | Sort-Object Name | % { $_.FullName }) `
#       --pdf-engine=xelatex --toc --number-sections `
#       -V documentclass=report -V fontsize=11pt -V geometry:margin=3cm `
#       -o monografi.pdf
#
# Notes / fixes vs. the original one-off run:
#
#   1. Repo layout changed: chapters now live in content/sv/00-...25-*.md,
#      appendices in content/sv/appendices/appendix-{a..f}-*.md.
#      policy-brief.md, README*.md, llms.txt are intentionally excluded
#      (they weren't part of the original merge either).
#
#   2. The old CSS file (Georgia serif, h1/h2/h3 sizing) was never actually
#      used by the xelatex command — CSS doesn't apply to a LaTeX-engine
#      PDF. It was a leftover from an earlier wkhtmltopdf/weasyprint
#      attempt that got abandoned when Pandoc misbehaved on Windows. We
#      approximate the same "elegant serif book" feel directly via
#      -V mainfont so there's one coherent pipeline instead of two.
#
#   3. BUG FIXED — double/triple heading numbers (e.g. "6.1 0.1
#      Transparens..."): every heading in these files already carries
#      its own manual number in the heading text itself
#      (e.g. "## 0.1 Transparens om subjekt/objekt-roll"). The old
#      --number-sections flag made LaTeX add ITS OWN auto-numbering on
#      top of that. Dropped the flag; --toc alone still builds a correct,
#      clickable table of contents without touching the heading text.
#
#   4. Missing ☐ (U+2610) glyph: the checkbox symbol used in the appendix
#      checklists isn't present in TeX Gyre Pagella. Swapped for a plain
#      ASCII "[ ]" in the PDF-only merged copy; the source .md files (and
#      the MkDocs/CF Pages site) keep the real Unicode glyph untouched.
#
#   5. Missing lmodern.sty: some minimal TeX Live installs are missing
#      the "lm" LaTeX package even though they're not needed under
#      xelatex (lmodern is a pdfLaTeX legacy default that Pandoc's
#      template loads unconditionally unless -V fontfamily is set — and
#      fontfamily is also used elsewhere in the template to pick a real
#      font package, so it can't just be set to a dummy value). If
#      lmodern.sty can't be found, this script drops in a harmless no-op
#      stub via TEXINPUTS so xelatex doesn't choke on it.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="${1:-$(cd "$SCRIPT_DIR/.." && pwd)}"
SV_DIR="$REPO_DIR/content/sv"
OUT_DIR="$REPO_DIR/export"

VERSION="$(git -C "$REPO_DIR" describe --tags --always 2>/dev/null || echo "untagged")"
MERGED_MD="$OUT_DIR/ccf_monografi_full.md"
OUT_PDF="$OUT_DIR/ccf_monografi_${VERSION}.pdf"

mkdir -p "$OUT_DIR"

echo "== 1/2: merging chapters + appendices (version: $VERSION) =="
# Numbered chapter files (00-25), sorted by filename -> correct reading order.
# Appendix files (appendix-a .. appendix-f), sorted by filename.
: > "$MERGED_MD"
for f in "$SV_DIR"/[0-9][0-9]-*.md; do
  cat "$f" >> "$MERGED_MD"
  echo -e "\n\n" >> "$MERGED_MD"
done
for f in "$SV_DIR"/appendices/appendix-*.md; do
  cat "$f" >> "$MERGED_MD"
  echo -e "\n\n" >> "$MERGED_MD"
done
echo "   merged -> $MERGED_MD ($(wc -l < "$MERGED_MD") lines)"

# Fix 4: swap the checkbox glyph (PDF-render copy only).
sed -i 's/☐/[ ]/g' "$MERGED_MD"

echo "== 2/2: rendering PDF with pandoc + xelatex =="

# Fix 5: work around a missing lmodern.sty on minimal TeX Live installs.
TEX_EXTRA_INPUTS=""
if ! kpsewhich lmodern.sty >/dev/null 2>&1; then
  echo "   (lmodern.sty not found - installing a harmless xelatex-only stub)"
  STUB_DIR="$(mktemp -d)"
  cat > "$STUB_DIR/lmodern.sty" <<'EOF'
% Minimal no-op stub: lmodern.sty is a pdfLaTeX legacy font package.
% Under xelatex with fontspec + \mainfont set via pandoc's -V mainfont,
% it is not needed. This stub exists only because this TeX Live install
% is missing the real (also harmless-under-xelatex) package.
\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{lmodern}[2026/01/01 no-op stub for xelatex]
EOF
  TEX_EXTRA_INPUTS="$STUB_DIR"
fi

TEXINPUTS=".:${TEX_EXTRA_INPUTS}:${TEXINPUTS:-}" pandoc "$MERGED_MD" \
  --pdf-engine=xelatex \
  --toc \
  -V documentclass=report \
  -V fontsize=11pt \
  -V geometry:margin=3cm \
  -V mainfont="TeX Gyre Pagella" \
  -V lang=sv \
  -o "$OUT_PDF"

echo "== done: $OUT_PDF =="
ls -lh "$OUT_PDF"
