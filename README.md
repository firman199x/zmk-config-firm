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

┌──────────────────────────────────┬───────────────────────────────────────────┬──────────────────────────────────────┐
│Row                               │SuperMini pin                              │nRF GPIO                              │
├──────────────────────────────────┼───────────────────────────────────────────┼──────────────────────────────────────┤
│R0                                │D4 (MOSI)                                  │P0.22                                 │
├──────────────────────────────────┼───────────────────────────────────────────┼──────────────────────────────────────┤
│R1                                │D6 (SDA)                                   │P1.00                                 │
├──────────────────────────────────┼───────────────────────────────────────────┼──────────────────────────────────────┤
│R2                                │D7 (SCL)                                   │P0.11                                 │
├──────────────────────────────────┼───────────────────────────────────────────┼──────────────────────────────────────┤
│R3                                │D8                                         │P1.04                                 │
├──────────────────────────────────┼───────────────────────────────────────────┼──────────────────────────────────────┤
│R4                                │D9                                         │P1.06                                 │
├──────────────────────────────────┼───────────────────────────────────────────┼──────────────────────────────────────┤
│R5                                │D10 (NFC1)                                 │P0.09                                 │
├──────────────────────────────────┼───────────────────────────────────────────┼──────────────────────────────────────┤
│R6                                │D5 (CS)                                    │P0.24                                 │
└──────────────────────────────────┴───────────────────────────────────────────┴──────────────────────────────────────┘

Columns (from dactyl_manuform_left.overlay):

┌────────────────────────────────────┬──────────────────────────────────────────┬─────────────────────────────────────┐
│Column                              │SuperMini pin                             │nRF GPIO                             │
├────────────────────────────────────┼──────────────────────────────────────────┼─────────────────────────────────────┤
│C0                                  │D17 (A2)                                  │P0.31                                │
├────────────────────────────────────┼──────────────────────────────────────────┼─────────────────────────────────────┤
│C1                                  │D16 (A1)                                  │P0.29                                │
├────────────────────────────────────┼──────────────────────────────────────────┼─────────────────────────────────────┤
│C2                                  │D15 (A0)                                  │P0.02                                │
├────────────────────────────────────┼──────────────────────────────────────────┼─────────────────────────────────────┤
│C3                                  │D14 (SCL1)                                │P1.15                                │
├────────────────────────────────────┼──────────────────────────────────────────┼─────────────────────────────────────┤
│C4                                  │D13 (SDA1)                                │P1.13                                │
├────────────────────────────────────┼──────────────────────────────────────────┼─────────────────────────────────────┤
│C5                                  │D12                                       │P1.11                                │
├────────────────────────────────────┼──────────────────────────────────────────┼─────────────────────────────────────┤
│C6                                  │D11 (NFC2)                                │P0.10                                │
└────────────────────────────────────┴──────────────────────────────────────────┴─────────────────────────────────────┘



```



                                             GND            VBAT
                                             06             VBAT
                                             08             GND
                                             GND            RESET
                                             GND            3V3(13)
                                             17          O  31
                                             20          O  29
                                          *  22          O  02
                                          *  24          O  15
                                          *  00          O  13
                                          *  11          O  11
                                          *  04          O  10
                                          *  06          *  09
```
