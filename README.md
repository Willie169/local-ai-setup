# local-ai-setup

This repo contains my local AI setup.

## Device Specs

This is the specs of my laptop, which I design this repo for:

<details><summary><code>sudo inxi -Fxz</code></summary>
<pre><code>System:
  Kernel: 7.0.0-30-generic arch: x86_64 bits: 64 compiler: gcc v: 15.2.0
  Desktop: KDE Plasma v: 6.6.6 Distro: Ubuntu 26.04 LTS (Resolute Raccoon)
Machine:
  Type: Laptop System: Micro-Star product: Thin 15 B13UC v: REV:1.0
    serial: <filter>
  Mobo: Micro-Star model: MS-16R8 v: REV:1.0 serial: <filter> Firmware: UEFI
    vendor: American Megatrends LLC. v: E16R8IMS.70D date: 04/07/2026
Battery:
  ID-1: BAT1 charge: 49.3 Wh (100%) condition: 49.3/51.3 Wh (96%) volts: 12.88
    min: 11.4 model: MSI BIF0_9 status: full
CPU:
  Info: 8-core (4-mt/4-st) model: 13th Gen Intel Core i5-13420H bits: 64
    type: MST AMCP arch: Raptor Lake rev: 2 cache: L1: 704 KiB L2: 7 MiB
    L3: 12 MiB
  Speed (MHz): avg: 507 min/max: 400/4600:3400 cores: 1: 507 2: 507 3: 507
    4: 507 5: 507 6: 507 7: 507 8: 507 9: 507 10: 507 11: 507 12: 507
    bogomips: 62668
  Flags-basic: avx avx2 ht lm nx pae sse sse2 sse3 sse4_1 sse4_2 ssse3 vmx
Graphics:
  Device-1: Intel Raptor Lake-P [UHD Graphics] vendor: Micro-Star MSI
    driver: i915 v: kernel arch: Xe bus-ID: 0000:00:02.0
  Device-2: NVIDIA GA107M [GeForce RTX 3050 Mobile] vendor: Micro-Star MSI
    driver: nvidia v: 610.57.04 arch: Ampere bus-ID: 0000:01:00.0
  Device-3: Bison HD Webcam driver: uvcvideo type: USB bus-ID: 1-6:2
  Display: unspecified server: X.Org v: 24.1.10 with: Xwayland v: 24.1.10
    driver: dri: iris gpu: i915 resolution: 1920x1080~144Hz
  API: EGL v: 1.5 drivers: iris,nvidia,swrast platforms:
    active: gbm,x11,surfaceless,device inactive: wayland,device-1
  API: OpenGL v: 4.6.0 compat-v: 4.5 vendor: intel mesa v: 26.0.8-1ubuntu0.3
    glx-v: 1.4 direct-render: yes renderer: Mesa Intel Graphics (RPL-P)
  API: Vulkan v: 1.4.341 drivers: intel,nvidia,llvmpipe surfaces: N/A
    devices: 3
  Info: Tools: api: clinfo, eglinfo, glxinfo, vulkaninfo de: kscreen-console,
    kscreen-doctor, xfce4-display-settings gpu: nvidia-settings,nvidia-smi
    wl: wayland-info x11: xdriinfo, xdpyinfo, xprop, xrandr
Audio:
  Device-1: Intel Raptor Lake-P/U/H cAVS vendor: Micro-Star MSI
    driver: sof-audio-pci-intel-tgl bus-ID: 0000:00:1f.3
  Device-2: NVIDIA GA107 High Definition Audio vendor: Micro-Star MSI
    driver: snd_hda_intel v: kernel bus-ID: 0000:01:00.1
  API: ALSA v: k7.0.0-30-generic status: kernel-api
  Server-1: PipeWire v: 1.6.2 status: n/a (root, process)
Network:
  Device-1: Intel Raptor Lake PCH CNVi WiFi driver: iwlwifi v: kernel
    bus-ID: 0000:00:14.3
  IF: wlo1 state: up mac: <filter>
  Device-2: Realtek RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet
    vendor: Micro-Star MSI driver: r8169 v: kernel port: 3000
    bus-ID: 0000:03:00.0
  IF: enp3s0 state: down mac: <filter>
  IF-ID-1: br-21f1b142d611 state: up speed: 10000 Mbps duplex: unknown
    mac: <filter>
  IF-ID-2: br-8459764550d9 state: up speed: 10000 Mbps duplex: unknown
    mac: <filter>
  IF-ID-3: docker0 state: up speed: 10000 Mbps duplex: unknown mac: <filter>
  IF-ID-4: lxcbr0 state: down mac: <filter>
  IF-ID-5: tailscale0 state: unknown speed: -1 duplex: full mac: N/A
  IF-ID-6: veth294ddce state: up speed: 10000 Mbps duplex: full
    mac: <filter>
  IF-ID-7: veth3476419 state: up speed: 10000 Mbps duplex: full
    mac: <filter>
  IF-ID-8: veth3ccd46b state: up speed: 10000 Mbps duplex: full
    mac: <filter>
  IF-ID-9: veth3fae380 state: up speed: 10000 Mbps duplex: full
    mac: <filter>
  IF-ID-10: veth61e3091 state: up speed: 10000 Mbps duplex: full
    mac: <filter>
  IF-ID-11: veth91fed2f state: up speed: 10000 Mbps duplex: full
    mac: <filter>
  IF-ID-12: vethbf5084b state: up speed: 10000 Mbps duplex: full
    mac: <filter>
  IF-ID-13: vethe6bf0a5 state: up speed: 10000 Mbps duplex: full
    mac: <filter>
  IF-ID-14: vetheb547ac state: up speed: 10000 Mbps duplex: full
    mac: <filter>
  IF-ID-15: virbr0 state: down mac: <filter>
Bluetooth:
  Device-1: Intel AX211 Bluetooth driver: btusb v: 0.8 type: USB
    bus-ID: 1-10:3
  Report: hciconfig ID: hci0 rfk-id: 0 state: down
    bt-service: enabled,running rfk-block: hardware: no software: yes
    address: <filter>
RAID:
  Hardware-1: Intel RST Volume Management Device Controller driver: vmd v: 0.6
    bus-ID: 0000:00:0e.0
Drives:
  Local Storage: total: 476.94 GiB used: 378.84 GiB (79.4%)
  ID-1: /dev/nvme0n1 vendor: Samsung model: MZVL4512HBLU-00BTW
    size: 476.94 GiB temp: 31.9 C
Partition:
  ID-1: / size: 404.05 GiB used: 378.81 GiB (93.8%) fs: btrfs
    dev: /dev/nvme0n1p4
  ID-2: /boot/efi size: 296 MiB used: 39.4 MiB (13.3%) fs: vfat
    dev: /dev/nvme0n1p1
  ID-3: /home size: 404.05 GiB used: 378.81 GiB (93.8%) fs: btrfs
    dev: /dev/nvme0n1p4
Swap:
  ID-1: swap-1 type: zram size: 11.32 GiB used: 4 KiB (0.0%) dev: /dev/zram0
  ID-2: swap-2 type: file size: 20 GiB used: 0 KiB (0.0%)
    file: /swap/swapfile
Sensors:
  System Temperatures: cpu: 43.0 C mobo: N/A
  Fan Speeds (rpm): cpu: 2400 fan-2: 0 fan-3: 0 fan-4: 0
Info:
  Memory: total: 16 GiB available: 15.32 GiB used: 6.39 GiB (41.7%)
    igpu: 60 MiB
  Processes: 446 Uptime: 2h 58m Init: systemd
  Packages: 3654 Compilers: clang: 21.1.8 gcc: 15.2.0 Shell: Sudo
    inxi: 3.3.40
</code></pre>
</details>
<details><summary><code>cat /etc/os-release</code></summary>
<pre><code>PRETTY_NAME="Ubuntu 26.04.1 LTS"
NAME="Ubuntu"
VERSION_ID="26.04"
VERSION="26.04.1 LTS (Resolute Raccoon)"
VERSION_CODENAME=resolute
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=resolute
LOGO=ubuntu-logo
</code></pre>
</details>

## Prerequisites

1. `uv`, `conda` ([miniforge](https://github.com/conda-forge/miniforge) recommended), and `brew` installed.
2. NVIDIA drivers and CUDA installed.

Refer to my [ubuntu-setup-with-vnc-and-gpu](https://github.com/Willie169/ubuntu-setup-with-vnc-and-gpu) repo for how to install and configure them.

## Installation

Obtain a Hugging Face token and export it before running the installation script is recommended for faster download:
```
export HF_TOKEN=<your_huggingface_token>
```
Run the installation script in this repo:
```
./install.sh
```
And add the following to your `~/.bashrc`:
```
[[ -f "$HOME/.local-ai-setup/bashrc.sh" ]] && . "$HOME/.local-ai-setup/bashrc.sh"
```

## Update

Run:
```
update_local_ai_setup
```

