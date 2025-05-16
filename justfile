zmkdir := "../zmk"

# Start devcontainer
up:
  devcontainer up --workspace-folder {{zmkdir}}

# parse build.yaml and filter targets by expression
_parse_targets $expr:
  #!/usr/bin/env bash
  attrs="[.shield, .board, .snippet, .\"cmake-args\"]"
  filter="(($attrs | map(. // [.]) | combinations), ((.include // {})[] | $attrs)) | join(\",\")"
  echo "$(yq -r "$filter" build.yaml | grep -v "^," | grep -i "${expr/#all/.*}")"

# Build a single firmware
_build_single $shield $board $snippet $cmake_args *west_args:
  #!/usr/bin/env bash
  set -euxo pipefail
  artifact="${shield:+${shield// /+}-}${board}"
  build_dir="{{ 'build' / '$artifact' }}"

  echo "west_args: {{west_args}}"
  echo "Building $artifact"
  # Nice hack below for doing a multiline script in `devcontainer exec`
  # https://stackoverflow.com/a/58037687
  cat <<EOF | devcontainer exec --workspace-folder {{zmkdir}} bash
  # Automatically join everything in zmk-modules with semicolons
  extra_modules="/workspaces/zmk-config;\$(ls -d -1 /workspaces/zmk-modules/* | tr '\n' ';')"
  cd /workspaces/zmk/app

  west build \
  --build-dir "$build_dir" \
  --board $board \
  {{ west_args }} \
  ${snippet:+-S "$snippet"} \
  -- \
  -DSHIELD="$shield" \
  ${cmake_args:+"$cmake_args"} \
  -DZMK_CONFIG="/workspaces/zmk-config/config" \
  -DZMK_EXTRA_MODULES="\$extra_modules"

  mv $build_dir/zephyr/zmk.uf2 /workspaces/zmk-config/dist/${artifact}.uf2
  ls -la /workspaces/zmk-config/dist/${artifact}.uf2
  EOF

# Build firmware for matching targets
build expr *west_args:
  #!/usr/bin/env bash
  set -euo pipefail
  targets=$(just _parse_targets {{ expr }})

  [[ -z $targets ]] && echo "No matching targets found. Aborting..." >&2 && exit 1
  echo "$targets" | while IFS=, read -r shield board snippet cmake_args; do
      just _build_single "$shield" "$board" "$snippet" "$cmake_args" {{ west_args }}
  done

# List build targets
list:
  @just _parse_targets all | sort | cut -d ',' -f1,2 | column -t -s ,
