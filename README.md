# lamparray-kbd

Per-key RGB control for **HID LampArray** keyboards on Linux — the standard "Lighting and
Illumination" HID protocol (usage page `0x59`, HUT 1.5 §25) that Windows *Dynamic Lighting* uses.
Zero dependencies: one Python 3 file talking to `/dev/hidraw*`. No kernel module, no vendor
protocol, no OpenRGB build from source.

**Origin:** the keyboard in the Acer Predator Helios 16 **PH16‑72** (USB `05af:666a`) had no
working Linux RGB control — it isn't driven by `acer-wmi` like older Predators, and the community
tools target other PIDs or a proprietary protocol. It turned out the keyboard also implements
standard LampArray on its first HID interface, and the whole thing works with ~150 lines of plain
Python. If your laptop's keyboard shows up in `lamparray-kbd list`, it will most likely just work.

## Features

- `solid`, `gradient` (uses real lamp positions), `zones`, per-key `keys`, `off`, `auto`
  (hand control back to the firmware's built-in effects), brightness
- Auto-restore: firmware does **not** persist host-set colours, so a tiny systemd user unit
  re-applies your last setting at login and every time the device re-enumerates (e.g. after
  resume from suspend), triggered by udev
- Works as a normal user via a udev `uaccess` rule (generated for your devices)
- Generic: report IDs and multi-update slot count are read from the HID report descriptor,
  so any conforming LampArray device should work

## Setup

**Requirements:** Linux with systemd and udev (any mainstream distro), Python 3.8+, `sudo` once.
Nothing to compile, no extra packages.

**1. Check that your keyboard is a LampArray device** (no install needed):

```sh
git clone https://github.com/usamathpc/lamparray-kbd
cd lamparray-kbd
./lamparray-kbd list
```

You should see a line like `05af:666a  /dev/hidraw3  ACER Keyboard (...)`. If it prints
`no HID LampArray devices found`, your keyboard doesn't use this protocol and this tool can't
help — see [Related](#related) for other projects.

**2. Install** (copies the tool to `~/.local/bin`, enables the auto-restore service, and asks for
`sudo` once to write a udev rule so you can use it without root):

```sh
./install.sh
```

**3. Try it:**

```sh
lamparray-kbd solid 00a0ff
```

The keyboard should change colour immediately. That colour now comes back automatically after
reboot and after suspend/resume. If `lamparray-kbd` is "command not found", `~/.local/bin` isn't
on your `PATH` — open a new terminal, or run `~/.local/bin/lamparray-kbd`.

**Uninstall:** `./uninstall.sh` (keeps `~/.config/lamparray-kbd`).

## Usage

```sh
lamparray-kbd list                      # detected LampArray devices
lamparray-kbd info                      # lamp count, size, every lamp with key name + position
lamparray-kbd solid 00a0ff
lamparray-kbd -b 30 solid white         # brightness %, remembered for later commands
lamparray-kbd gradient purple cyan      # left → right, any number of colours
lamparray-kbd zones red yellow green blue
lamparray-kbd keys 101010 w=red a=red s=red d=red space=white esc=orange
lamparray-kbd off
lamparray-kbd auto                      # firmware effects again (Fn key usually cycles them)
lamparray-kbd -d 05af:666a solid red    # pick a device when several are present
```

Colours: `rrggbb`, `rgb`, or `red green blue white warmwhite coolwhite cyan magenta yellow orange purple pink teal off`.
Key names: `a`–`z`, `0`–`9`, `f1`–`f24`, `esc space enter tab backspace lctrl lshift lalt lmeta
rctrl … up down left right home end pageup pagedown insert delete kp0`–`kp9 kpenter` … (from the
HID keycode each lamp reports), or a raw lamp number from `info`.

The last setting per device is stored in `~/.config/lamparray-kbd/state.json`;
`lamparray-kbd restore` re-applies it (that's all the systemd unit does).

## Tested devices

| Device | USB ID | Lamps | Notes |
|---|---|---|---|
| Acer Predator Helios 16 PH16‑72 keyboard (Sunrex) | `05af:666a` | 103 per-key | Fedora 44, kernel 7.2. [Details](docs/devices/acer-predator-helios-16-ph16-72.md) |

Got another one working? Please open an issue/PR with the output of `lamparray-kbd list` and
`lamparray-kbd info`. Likely candidates: other Acer PH16‑7x / PH18‑7x / PHN16‑7x keyboards
(`05af:667b`, `05af:766a`…), Darfon lid logos, and any keyboard advertised as
"Windows Dynamic Lighting compatible".

## How it works

See [docs/PROTOCOL.md](docs/PROTOCOL.md). Short version: `LampArrayControl(AutonomousMode=0)`
takes control from the firmware; `LampRangeUpdate` paints a contiguous range one colour;
`LampMultiUpdate` sets N lamps (N = slots in the descriptor, 8 on the Acer) per feature report;
`LampAttributesRequest/Response` gives each lamp's position and key binding. Everything is HID
feature reports via `HIDIOCSFEATURE`/`HIDIOCGFEATURE` ioctls.

## Limitations

- No animated effects (breathing/wave) — that needs a daemon streaming frames; `auto` gives you
  the firmware's own animations instead. PRs welcome.
- Only lamps the device exposes through LampArray. On the PH16‑72 the lid logo (Darfon `0d62:ba51`)
  is a separate proprietary HID device and is not covered.
- Non-programmable lamps and non-keyboard `LampArrayKind`s aren't special-cased; `solid`/`gradient`
  still work on them.

## Troubleshooting

| Symptom | Fix |
|---|---|
| `no permission on /dev/hidrawN` | Run `sudo lamparray-kbd install-udev`, then unplug/replug or reboot. If it persists, check `ls -l /dev/hidraw*` — the udev `uaccess` rule only grants access to the *active* graphical session. |
| Colour doesn't come back after resume | `systemctl --user status lamparray-kbd-restore.service` and `journalctl --user -u lamparray-kbd-restore`. Make sure `install.sh` ran as your user (not with `sudo`). |
| `list` shows the device but commands do nothing | Some firmware ignores LampArray until a vendor "mode switch" — open an issue with `lamparray-kbd info` output and your model. |
| Keys are named `lampNN` instead of `a`, `f1`… | The device doesn't report key bindings; use the lamp numbers from `info` with `keys`. |

## Related

- [OpenRGB](https://gitlab.com/CalcProgrammer1/OpenRGB) has a generic HID LampArray controller on
  master since 2026‑08 ([!2348](https://gitlab.com/CalcProgrammer1/OpenRGB/-/merge_requests/2348));
  once it's in a release, it should detect the same devices and give you a GUI.
- [TensorRaya/acer-predator-helios-rgb](https://github.com/TensorRaya/acer-predator-helios-rgb) —
  reverse-engineered proprietary protocol for PH16‑7x keyboards (`05af:667b`).
- [cleyton1986/predator-sense](https://github.com/cleyton1986/predator-sense) — GUI for Acer
  laptops (fans/profiles) with a decompiled RGB protocol.
- Rust LampArray CLIs: [lampctl](https://github.com/mrp2003/lampctl),
  [hid-rgb-ctl](https://github.com/xz-dev/hid-rgb-ctl), [rgblamp](https://github.com/aryaveersr/rgblamp).
- Microsoft: [Dynamic Lighting device guidelines](https://learn.microsoft.com/en-us/windows-hardware/design/component-guidelines/dynamic-lighting-devices).

## License

MIT
