# zmk-config-firm

ZMK firmware config for a CMD-dactyl-manuform (Dactyl Manuform 6x7) running on
nice!nano / nice2nano clone (Pro Micro nRF52840) controllers, with ZMK Studio support.

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

> Run all `west build` commands from inside the initialized workspace directory
> (the one containing `.west/`), not from the config repo root.

### 3. Build

```bash
export ZEPHYR_SDK_INSTALL_DIR=/tmp/zephyr-sdk-0.16.9

# Left side (with Studio RPC over USB UART)
west build -p auto -b nice_nano -s zmk/app -- \
  -DSHIELD=dactyl_manuform_left \
  -DZMK_CONFIG="$(pwd)/config" \
  "-DBOARD_ROOT=$(pwd);zmk/app"

# Right side (no Studio snippet)
west build -p auto -b nice_nano -s zmk/app -- \
  -DSHIELD=dactyl_manuform_right \
  -DZMK_CONFIG="$(pwd)/config" \
  "-DBOARD_ROOT=$(pwd);zmk/app"
```

Output `.uf2` files are at `build/zephyr/zmk.uf2`.

Quick compile (left/right):

```bash
./compile_left.sh
./compile_right.sh
```

### Flashing (nice!nano / nice2nano clone)

1. Put the controller into bootloader mode (double-tap the reset button).
2. A USB drive named `NICENANO` (or `NRF52BOOT`) appears.
3. Copy `zmk.uf2` to that drive. It flashes and reboots automatically.
4. Flash the left half first (central), then the right half.
5. If switching from a previous firmware, flash `settings_reset` first.

### Python Dependencies

If you get `ModuleNotFoundError` during build:

```bash
pip install pyelftools
```


lua MiniSurround.add("visual")
's the full pin map using your SuperMini labels:

Rows (from dactyl_manuform.dtsi):

┌──────────────────────────────────┬──────────────────────────────────────┐
│Row                               │nRF GPIO                              │
├──────────────────────────────────┼──────────────────────────────────────┤
│R0                                │P0.20                                 │
├──────────────────────────────────┼──────────────────────────────────────┤
│R1                                │P0.22                                 │
├──────────────────────────────────┼──────────────────────────────────────┤
│R2                                │P0.24                                 │
├──────────────────────────────────┼──────────────────────────────────────┤
│R3                                │P1.00                                 │
├──────────────────────────────────┼──────────────────────────────────────┤
│R4                                │P0.11                                 │
├──────────────────────────────────┼──────────────────────────────────────┤
│R5                                │P1.04                                 │
├──────────────────────────────────┼──────────────────────────────────────┤
│R6                                │P1.06                                 │
└──────────────────────────────────┴──────────────────────────────────────┘

Columns (from dactyl_manuform_left.overlay):

┌────────────────────────────────────┬─────────────────────────────────────┐
│Column                              │nRF GPIO                             │
├────────────────────────────────────┼─────────────────────────────────────┤
│C0                                  │P0.29                                │
├────────────────────────────────────┼─────────────────────────────────────┤
│C1                                  │P0.02                                │
├────────────────────────────────────┼─────────────────────────────────────┤
│C2                                  │P1.15                                │
├────────────────────────────────────┼─────────────────────────────────────┤
│C3                                  │P1.13                                │
├────────────────────────────────────┼─────────────────────────────────────┤
│C4                                  │P1.11                                │
├────────────────────────────────────┼─────────────────────────────────────┤
│C5                                  │P0.10                                │
├────────────────────────────────────┼─────────────────────────────────────┤
│C6                                  │P0.09                                │
└────────────────────────────────────┴─────────────────────────────────────┘
