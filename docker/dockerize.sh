#!/usr/bin/env bash

set -eo pipefail

my=""
for cmd in terraform kubectl helm inspec gcloud az aws; do
  my+=$(echo "function $cmd { docker run -it --rm -v $(pwd):/share $DOCKER_USER/terraform-toolbox $cmd \"\$@\" }")
  my+=$(echo ";export -f \"$cmd\";")
done

echo "$my"
