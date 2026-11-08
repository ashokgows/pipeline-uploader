#!/bin/sh
# Publishes the policy pages as a PUBLIC GitHub Pages site:
#   https://ashokgows.github.io/pipeline-uploader/
# Run once, from anywhere:  sh policy_site/publish_site.sh
set -e
cd "$(dirname "$0")"
git init -q 2>/dev/null || true
git add -A
git -c user.name="ashokgows" -c user.email="ashokgows@users.noreply.github.com" \
    commit -q -m "Policy pages for the YouTube Pipeline Uploader OAuth app" || true
git branch -M main
gh repo create ashokgows/pipeline-uploader --public \
    --description "Privacy policy and terms for the personal-use YouTube Pipeline Uploader OAuth app" \
    --source=. --remote=origin --push
sleep 3
gh api -X POST repos/ashokgows/pipeline-uploader/pages -f 'source[branch]=main' -f 'source[path]=/' >/dev/null
echo "Published. Pages will be live in ~1 minute at https://ashokgows.github.io/pipeline-uploader/"
