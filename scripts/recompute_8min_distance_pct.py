"""Shared within-phase eight-minute distance progress; no sensor data edits.

Distance is cumulative haversine length through available 10-second GPS
positions, starting at the first valid position. Missing GPS yields blank
pct_complete; the next valid position bridges the gap in a straight line.
Each phase uses the greatest observed participant distance as 100 percent.
Tram retains its previously corrected time coverage; other phases unchanged.
"""
import csv
import hashlib
import io
import math
import shutil
from collections import defaultdict
from datetime import datetime
from pathlib import Path

ROOT = Path(r'D:\Pranav\docker\Paper3_Final')
TARGET = ROOT / 'output/merged_all_11participants_8min.csv'
PHASES = {'WalkU', 'WalkG', 'BikeU', 'BikeG'}

def distance(a, b):
    lat1, lon1, lat2, lon2 = map(math.radians, (*a, *b))
    h = math.sin((lat2-lat1)/2)**2 + math.cos(lat1)*math.cos(lat2)*math.sin((lon2-lon1)/2)**2
    return 6371000 * 2 * math.asin(min(1, math.sqrt(h)))

def main():
    original = TARGET.read_bytes()
    reader = csv.DictReader(io.StringIO(original.decode('utf-8-sig'), newline=''))
    fields = reader.fieldnames
    rows = list(reader)
    groups = defaultdict(list)
    for row in rows:
        if row['PhaseID'] in PHASES:
            groups[(row['ParticipantID'], row['PhaseID'])].append(row)
    distances = {}
    totals = {}
    for key, group in groups.items():
        group.sort(key=lambda r: r['Datetime'])
        assert len(group) == 48
        assert (datetime.fromisoformat(group[-1]['Datetime']) - datetime.fromisoformat(group[0]['Datetime'])).total_seconds() == 470
        previous, total = None, 0.
        for row in group:
            try:
                point = (float(row['ucm_GPS_lat']), float(row['ucm_GPS_lon']))
                assert all(math.isfinite(x) for x in point)
                assert -90 <= point[0] <= 90 and -180 <= point[1] <= 180
            except (ValueError, AssertionError):
                distances[id(row)] = None
                continue
            if previous is not None:
                total += distance(previous, point)
            distances[id(row)] = total
            previous = point
        totals[key] = total
    assert len(groups) == 44
    for phase in sorted(PHASES):
        maximum_key = max((key for key in totals if key[1] == phase), key=totals.get)
        maximum = totals[maximum_key]
        assert maximum > 0
        for key, group in groups.items():
            if key[1] != phase:
                continue
            for row in group:
                value = distances[id(row)]
                row['pct_complete'] = '' if value is None else format(value / maximum * 100, '.8f').rstrip('0').rstrip('.')
        print(phase, 'reference', maximum_key[0], 'metres', round(maximum, 3))
        assert groups[maximum_key][-1]['pct_complete'] == '100'
    out = io.StringIO(newline='')
    writer = csv.DictWriter(out, fieldnames=fields, lineterminator='\r\n')
    writer.writeheader()
    writer.writerows(rows)
    payload = out.getvalue().encode('utf-8-sig' if original.startswith(b'\xef\xbb\xbf') else 'utf-8')
    before = list(csv.DictReader(io.StringIO(original.decode('utf-8-sig'), newline='')))
    after = list(csv.DictReader(io.StringIO(payload.decode('utf-8-sig'), newline='')))
    assert len(before) == len(after) == 5023
    for old, new in zip(before, after):
        for col in fields:
            if col != 'pct_complete' or old['PhaseID'] not in PHASES:
                assert old[col] == new[col], col
        if new['PhaseID'] in PHASES and new['pct_complete']:
            assert 0 <= float(new['pct_complete']) <= 100
    stamp = datetime.now().strftime('%Y%m%d_%H%M%S')
    backup = TARGET.with_name(TARGET.stem + '_backup_before_distance_pct_' + stamp + '.csv')
    assert not backup.exists()
    assert TARGET.read_bytes() == original, 'Concurrent change; refusing overwrite'
    shutil.copy2(TARGET, backup)
    assert backup.read_bytes() == original
    temporary = TARGET.with_suffix('.distance_pct_tmp')
    temporary.write_bytes(payload)
    assert TARGET.read_bytes() == original, 'Concurrent change; refusing overwrite'
    temporary.replace(TARGET)
    assert backup.read_bytes() == original
    print('Verified: 5023 rows, only four core phases pct_complete changed; Tram and all other fields preserved.')
    print('Backup:', backup)

if __name__ == '__main__':
    main()
