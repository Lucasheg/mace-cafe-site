#!/usr/bin/env bash
set -euo pipefail

echo "➡️  Preparing local CMS bundles…"
mkdir -p admin/vendor

# Try Decap CMS (preferred) from two sources; first that works wins
if curl -sSfL --retry 4 --retry-connrefused \
  https://cdnjs.cloudflare.com/ajax/libs/decap-cms/3.1.9/decap-cms.min.js \
  -o admin/vendor/decap-cms.js; then
  echo "✅ Downloaded decap-cms from cdnjs"
else
  echo "… cdnjs failed, trying unpkg"
  curl -sSfL --retry 4 --retry-connrefused \
    https://unpkg.com/decap-cms@^3/dist/decap-cms.js \
    -o admin/vendor/decap-cms.js
  echo "✅ Downloaded decap-cms from unpkg"
fi

# Also fetch Netlify CMS app as a secondary local fallback (best-effort)
if curl -sSfL --retry 4 --retry-connrefused \
  https://unpkg.com/netlify-cms-app@^2/dist/netlify-cms.js \
  -o admin/vendor/netlify-cms.js; then
  echo "✅ Downloaded netlify-cms-app (fallback)"
else
  echo "⚠️  netlify-cms-app fallback not fetched (will still work with decap-cms)"
fi

echo "✅ CMS vendor files ready in admin/vendor/"
