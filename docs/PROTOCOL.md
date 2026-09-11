# HID LampArray as used by lamparray-kbd

Reference: USB HID Usage Tables 1.5, §25 "Lighting And Illumination Page (0x59)".
All reports below are **Feature** reports on the interface whose descriptor contains the
top-level collection `Usage Page 0x59 / Usage 0x01 (LampArray)`. Report IDs are chosen by the
device; `lamparray-kbd` reads them from the descriptor (`parse_descriptor`). The byte layouts
are fixed by the spec (little-endian).

| Usage | Name | Direction | Payload after report ID |
|---|---|---|---|
| `0x02` | LampArrayAttributesReport | GET | `LampCount u16`, `BoundingBoxWidth/Height/Depth u32 ×3` (µm), `LampArrayKind u32`, `MinUpdateInterval u32` (µs) |
| `0x20` | LampAttributesRequestReport | SET | `LampId u16` |
| `0x22` | LampAttributesResponseReport | GET | `LampId u16`, `PositionX/Y/Z u32 ×3` (µm), `UpdateLatency u32` (µs), `LampPurposes u32`, `Red/Green/Blue/IntensityLevelCount u8 ×4`, `IsProgrammable u8`, `InputBinding u8` (HID keyboard usage) |
| `0x50` | LampMultiUpdateReport | SET | `LampCount u8`, `LampUpdateFlags u8`, `LampId u16 × slots`, `(R,G,B,I) u8×4 × slots` |
| `0x60` | LampRangeUpdateReport | SET | `LampUpdateFlags u8`, `LampIdStart u16`, `LampIdEnd u16`, `R,G,B,I u8×4` |
| `0x70` | LampArrayControlReport | SET | `AutonomousMode u8` |

`LampUpdateFlags` bit 0 = *LampUpdateComplete* — set it on the last report of a frame; the device
may buffer until it sees it. `slots` (8 on the Acer PH16‑72) is the Report Count of the `LampId`
field inside the MultiUpdate collection.

Sequence used by this tool:

1. `GET 0x02` → lamp count, bounding box (used for gradients/zones).
2. For `info`/`gradient`/`zones`/`keys`: for each lamp `SET 0x20 (id)` then `GET 0x22`.
3. `SET 0x70 AutonomousMode=0` (host takes over; the firmware effect stops).
4. `SET 0x60` (whole range) or repeated `SET 0x50` (8 lamps each, flag=1 on the last).
5. `auto` → `SET 0x70 AutonomousMode=1`.

Observed on the PH16‑72 keyboard: intensity byte is accepted as `0xFF`; `GET` on an interface
that isn't the LampArray one stalls (`EPIPE`); host-set colours are lost when the device
re-enumerates (boot, resume), hence the restore service. No idle time-out was observed — a
colour set once stayed for hours without keep-alive traffic.

Linux side: `HIDIOCSFEATURE(len)` = `_IOC(_IOC_READ|_IOC_WRITE, 'H', 0x06, len)`,
`HIDIOCGFEATURE(len)` = `… 0x07 …`; the first byte of the buffer is the report ID.
