#!/usr/bin/env python3
"""Export CASTLE.RAN room records to JSON.

Record layout (575 bytes, rooms 1..83, then a high-score record):
  0..431    map, 18 rows x 24 columns, CP437
  432..556  description, 5 lines x 25 columns
  557..574  exits, e.g. "N3S1" (direction letter + room number)
"""
import json
import re
import sys
from pathlib import Path

REC = 575
W, H = 24, 18


def cp437(b: bytes) -> str:
    return b.decode("cp437")


def main(ran: Path, out: Path) -> None:
    data = ran.read_bytes()
    out.mkdir(parents=True, exist_ok=True)
    rooms = []
    for i in range(83):
        r = data[i * REC:(i + 1) * REC]
        rows = [cp437(r[y * W:(y + 1) * W]) for y in range(H)]
        desc_lines = [cp437(r[432 + k * 25:432 + (k + 1) * 25]) for k in range(5)]
        exits_raw = cp437(r[557:575])
        exits = {d: int(n) for d, n in re.findall(r"([NSEWUD])(\d+)", exits_raw)}
        rooms.append({
            "id": i + 1,
            "map": rows,
            "description_lines": desc_lines,
            "description": " ".join(" ".join(desc_lines).split()),
            "exits_raw": exits_raw.rstrip(),
            "exits": exits,
        })
    hs = data[83 * REC:84 * REC]
    high = {"name": cp437(hs[:25]).strip(), "score_field": cp437(hs[25:50]).strip()}

    (out / "rooms.json").write_text(
        json.dumps({"rooms": rooms, "high_score_record": high}, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8")

    print(f"wrote {len(rooms)} rooms to {out}")


if __name__ == "__main__":
    main(Path(sys.argv[1]), Path(sys.argv[2]))
