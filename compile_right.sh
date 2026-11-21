#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"
export ZEPHYR_SDK_INSTALL_DIR=/home/fsukri/zephyr-sdk-0.16.9
export ZEPHYR_TOOLCHAIN_VARIANT=zephyr
export PATH="/home/fsukri/.venv/bin:$PATH"
west build -p auto -b nice_nano_v2 -s zmk/app -d build_right -- \
  -DSHIELD=dactyl_manuform_right \
  -DZMK_CONFIG="$(pwd)/config" \
  -DBOARD_ROOT="$(pwd)"

cp build_right/zephyr/zmk.uf2 "$(pwd)/right.uf2"
echo "Built: $(pwd)/right.uf2"
