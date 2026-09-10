#!/usr/bin/env bash
# ── TEMPORARY SHIM ───────────────────────────────────────────────────────────
# GitHub Pages is serving this repo's ROOT, not docs/. Until the Pages setting
# is changed to "branch: master, folder: /docs", copy the built pages up to the
# root so kimyoungwon.github.io/portfolio/ serves the site instead of README.md.
#
# Deliberately NOT copied: assets/ and styles.css — the root already holds those
# as source, and the built HTML references them by the same relative paths.
#
# Once Settings → Pages points at /docs, delete this script, drop the
# post-render line from _quarto.yml, and `git rm` the copied files at the root.
# ─────────────────────────────────────────────────────────────────────────────
set -euo pipefail
cd "$(dirname "$0")"

cp -f docs/.nojekyll .nojekyll
for f in docs/*.html docs/search.json docs/listings.json docs/robots.txt docs/sitemap.xml; do
  [ -e "$f" ] && cp -f "$f" .
done
rm -rf site_libs
cp -R docs/site_libs site_libs

echo "publish-root: copied $(ls docs/*.html | wc -l | tr -d ' ') pages + site_libs to repo root"
