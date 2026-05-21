# zmk-config-firm

ZMK firmware config for a Dactyl Manuform 6x7 with ZMK Studio support.

## Local Compile

### 1. Install Zephyr SDK

```bash
cd /tmp
wget https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.16.9/zephyr-sdk-0.16.9_linux-x86_64.tar.xz
tar xf zephyr-sdk-0.16.9_linux-x86_64.tar.xz
cd zephyr-sdk-0.16.9 && ./setup.sh -c
```

### 2. Initialize west workspace

```bash
cd /path/to/zmk-config-firm
west init -l config/
west update
west zephyr-export
```

### 3. Build

```bash
export ZEPHYR_SDK_INSTALL_DIR=/tmp/zephyr-sdk-0.16.9

# Left side (with Studio RPC over USB UART)
west build -p auto -b nice_nano_v2 -s zmk/app -- \
  -DSHIELD=dactyl_manuform_left \
  -DZMK_CONFIG="$(pwd)/config" \
  "-DBOARD_ROOT=$(pwd);zmk/app"

# Right side (no Studio snippet)
west build -p auto -b nice_nano_v2 -s zmk/app -- \
  -DSHIELD=dactyl_manuform_right \
  -DZMK_CONFIG="$(pwd)/config" \
  "-DBOARD_ROOT=$(pwd);zmk/app"
```

Output `.uf2` files are at `build/zephyr/zmk.uf2`.

### Python Dependencies

If you get `ModuleNotFoundError` during build:

```bash
pip install pyelftools
```
