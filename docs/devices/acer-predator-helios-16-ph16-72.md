# Acer Predator Helios 16 PH16‑72 — internal keyboard

- USB `05af:666a` "ACER Keyboard" (Jing‑Mold Enterprise / Sunrex), bcdDevice 0.25
- 4 HID interfaces: **0 = boot keyboard + vendor page 0xFF89 + LampArray**, 1 = vendor 0xFF00,
  2 = consumer/hotkeys, 3 = vendor 0xFF02 (Acer's proprietary lighting protocol)
- LampArray: 103 lamps, per-key, `LampArrayKind=1` (keyboard), bounding box 339×105 mm,
  `MinUpdateInterval` 33 ms; every lamp is programmable with 8‑bit R/G/B/I and an `InputBinding`
  (HID keycode) — so key names come straight from the device
- Report IDs: Attributes `0x81`, AttrRequest `0x82`, AttrResponse `0x83`, MultiUpdate `0x84`
  (8 slots), RangeUpdate `0x85`, Control `0x86`
- Tested: Fedora 44, kernel 7.2.4, `hid-generic`; no kernel changes needed
- Not LampArray on this laptop: the lid logo (Darfon `0d62:ba51`, vendor page 0xFF01)
- The keyboard re-enumerates on every resume from suspend (S3) → colours are re-applied by the
  restore service (udev `SYSTEMD_USER_WANTS`)

## Interface 0 report descriptor

```
06 89 ff 09 10 a1 01 85 5a 09 01 15 00 26 ff 00
75 08 95 10 b1 00 c0 05 01 09 06 a1 01 85 01 75
01 95 08 05 07 19 e0 29 e7 15 00 25 01 81 02 95
01 75 08 81 03 95 05 75 01 05 08 19 01 29 05 91
02 95 01 75 03 91 03 05 07 19 00 2a ff 00 15 00
26 ff 00 95 06 75 08 81 00 05 07 19 04 29 a4 15
00 25 01 95 a0 75 01 81 02 c0 05 59 09 01 a1 01
85 81 09 02 a1 02 09 03 15 00 27 ff ff 00 00 75
10 95 01 b1 03 09 04 09 05 09 06 09 07 09 08 15
00 27 ff ff ff 7f 75 20 95 05 b1 03 c0 85 82 09
20 a1 02 09 21 15 00 27 ff ff 00 00 75 10 95 01
b1 02 c0 85 83 09 22 a1 02 09 21 15 00 27 ff ff
00 00 75 10 95 01 b1 02 09 23 09 24 09 25 09 27
09 26 15 00 27 ff ff ff 7f 75 20 95 05 b1 02 09
28 09 29 09 2a 09 2b 09 2c 09 2d 15 00 26 ff 00
75 08 95 06 b1 02 c0 85 84 09 50 a1 02 09 03 09
55 15 00 25 08 75 08 95 02 b1 02 09 21 15 00 27
ff ff 00 00 75 10 95 08 b1 02 09 51 09 52 09 53
09 54 09 51 09 52 09 53 09 54 09 51 09 52 09 53
09 54 09 51 09 52 09 53 09 54 09 51 09 52 09 53
09 54 09 51 09 52 09 53 09 54 09 51 09 52 09 53
09 54 09 51 09 52 09 53 09 54 15 00 26 ff 00 75
08 95 20 b1 02 c0 85 85 09 60 a1 02 09 55 15 00
25 08 75 08 95 01 b1 02 09 61 09 62 15 00 27 ff
ff 00 00 75 10 95 02 b1 02 09 51 09 52 09 53 09
54 15 00 26 ff 00 75 08 95 04 b1 02 c0 85 86 09
70 a1 02 09 71 15 00 25 01 75 08 95 01 b1 02 c0
c0
```

## Lamp map (`lamparray-kbd info`)

```
05af:666a ACER Keyboard (/dev/hidraw3): kind=keyboard lamps=103 size=339x105x0mm min_update=33ms
  0  esc          x=   5.9mm y=  5.2mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
  1  f1           x=  26.7mm y=  5.2mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
  2  f2           x=  42.9mm y=  5.2mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
  3  f3           x=  59.1mm y=  5.2mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
  4  f4           x=  74.0mm y=  5.3mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
  5  f5           x=  94.7mm y=  5.2mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
  6  f6           x= 110.9mm y=  5.2mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
  7  f7           x= 127.1mm y=  5.2mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
  8  f8           x= 143.3mm y=  5.2mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
  9  f9           x= 162.8mm y=  5.2mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 10  f10          x= 178.9mm y=  5.2mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 11  f11          x= 195.2mm y=  5.2mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 12  f12          x= 211.3mm y=  5.2mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 13  printscreen  x= 230.8mm y=  5.2mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 14  insert       x= 247.0mm y=  5.2mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 15  delete       x= 263.2mm y=  5.2mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 16  lamp16       x= 282.1mm y=  5.2mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 17  lamp17       x= 298.3mm y=  5.2mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 18  lamp18       x= 314.5mm y=  5.2mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 19  lamp19       x= 330.7mm y=  5.2mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 20  grave        x=   5.0mm y= 21.6mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 21  1            x=  23.1mm y= 21.6mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 22  2            x=  42.0mm y= 21.6mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 23  3            x=  61.0mm y= 21.6mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 24  4            x=  79.9mm y= 21.6mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 25  5            x=  98.9mm y= 21.6mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 26  6            x= 117.8mm y= 21.6mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 27  7            x= 136.8mm y= 21.6mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 28  8            x= 155.7mm y= 21.6mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 29  9            x= 174.7mm y= 21.6mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 30  0            x= 193.6mm y= 21.6mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 31  minus        x= 212.6mm y= 21.6mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 32  equal        x= 231.5mm y= 21.6mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 33  backspace    x= 256.1mm y= 18.8mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 34  lamp34       x= 282.1mm y= 21.6mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 35  numlock      x= 298.3mm y= 21.6mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 36  kpslash      x= 314.5mm y= 21.6mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 37  kpasterisk   x= 330.7mm y= 21.6mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 38  tab          x=   6.1mm y= 43.2mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 39  q            x=  32.6mm y= 40.5mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 40  w            x=  51.6mm y= 40.5mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 41  e            x=  70.5mm y= 40.5mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 42  r            x=  89.5mm y= 40.5mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 43  t            x= 108.4mm y= 40.5mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 44  y            x= 127.4mm y= 40.5mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 45  u            x= 146.3mm y= 40.5mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 46  i            x= 165.3mm y= 40.5mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 47  o            x= 184.2mm y= 40.5mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 48  p            x= 203.2mm y= 40.5mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 49  lbracket     x= 222.1mm y= 40.5mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 50  rbracket     x= 241.1mm y= 40.5mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 51  backslash    x= 260.9mm y= 40.5mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 52  kp7          x= 282.1mm y= 43.5mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 53  kp8          x= 298.3mm y= 43.5mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 54  kp9          x= 314.5mm y= 43.5mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 55  kpminus      x= 330.7mm y= 43.5mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 56  capslock     x=   5.9mm y= 57.1mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 57  a            x=  37.4mm y= 59.5mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 58  s            x=  56.3mm y= 59.5mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 59  d            x=  75.3mm y= 59.5mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 60  f            x=  94.2mm y= 59.5mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 61  g            x= 113.2mm y= 59.5mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 62  h            x= 132.1mm y= 59.5mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 63  j            x= 151.1mm y= 59.5mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 64  k            x= 170.0mm y= 59.5mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 65  l            x= 189.0mm y= 59.5mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 66  semicolon    x= 207.9mm y= 59.5mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 67  quote        x= 226.9mm y= 59.5mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 68  enter        x= 253.8mm y= 56.7mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 69  kp4          x= 282.1mm y= 62.5mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 70  kp5          x= 298.3mm y= 62.5mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 71  kp6          x= 314.5mm y= 62.5mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 72  kpplus       x= 330.7mm y= 62.5mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 73  lshift       x=  16.9mm y= 75.8mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 74  z            x=  46.8mm y= 78.4mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 75  x            x=  65.8mm y= 78.4mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 76  c            x=  84.7mm y= 78.4mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 77  v            x= 103.7mm y= 78.4mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 78  b            x= 122.6mm y= 78.4mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 79  n            x= 141.6mm y= 78.4mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 80  m            x= 160.5mm y= 78.4mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 81  comma        x= 179.4mm y= 78.4mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 82  period       x= 198.4mm y= 78.4mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 83  slash        x= 217.3mm y= 78.4mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 84  rshift       x= 235.9mm y= 81.1mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 85  up           x= 261.8mm y= 80.8mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 86  kp1          x= 282.1mm y= 81.4mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 87  kp2          x= 298.3mm y= 81.4mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 88  kp3          x= 314.5mm y= 81.4mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 89  lctrl        x=   7.4mm y= 97.3mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 90  lamp90       x=  27.9mm y= 97.3mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 91  lmeta        x=  46.8mm y= 97.3mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 92  lalt         x=  65.8mm y= 97.3mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 93  space        x= 122.6mm y=100.0mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 94  ralt         x= 176.6mm y= 97.4mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 95  menu         x= 198.4mm y= 97.3mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 96  f23          x= 220.6mm y= 97.3mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 97  left         x= 242.8mm y= 99.8mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 98  down         x= 261.8mm y= 99.8mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
 99  right        x= 280.8mm y= 99.8mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
100  kp0          x= 298.3mm y=100.4mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
101  kpdot        x= 314.5mm y=100.4mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
102  kpenter      x= 332.9mm y= 89.9mm levels=R255/G255/B255/I255 purposes=1 latency=5000us
```
