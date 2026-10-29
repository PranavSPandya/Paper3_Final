"""Recompute Tram pct_complete as observed ten-second block coverage of 480 s.

Only pct_complete is changed. Missing observations are never synthesized.
The original full-phase percentages remain in the verified backup.
"""
import csv
import hashlib
import io
from pathlib import Path

ROOT = Path(r'D:\Pranav\docker\Paper3_Final')
TARGET = ROOT / 'output/merged_all_11participants_8min.csv'
BACKUP = ROOT / 'output/merged_all_11participants_8min_backup_before_pct_complete_20261028.csv'

def main():
    original = TARGET.read_bytes()
    assert BACKUP.read_bytes() == original, 'Input changed since backup; review before proceeding'
    text = original.decode('utf-8-sig')
    reader = csv.DictReader(io.StringIO(text, newline=''))
    fields = reader.fieldnames
    rows = list(reader)
    groups = {}
    for row in rows:
        if row['PhaseID'] == 'Tram':
            groups.setdefault(row['ParticipantID'], []).append(row)
    assert len(groups) == 11
    for pid, group in groups.items():
        group.sort(key=lambda row: row['Datetime'])
        assert len(group) <= 48
        # Existing grid is ten seconds per row; keep gaps explicit if present.
        from datetime import datetime
        start = datetime.fromisoformat(group[0]['Datetime'])
        for row in group:
            seconds = (datetime.fromisoformat(row['Datetime']) - start).total_seconds() + 10
            assert 0 < seconds <= 480
            row['pct_complete'] = format(seconds / 480 * 100, '.6f').rstrip('0').rstrip('.')
        print(pid, len(group), group[-1]['pct_complete'])
    out = io.StringIO(newline='')
    writer = csv.DictWriter(out, fieldnames=fields, lineterminator='\r\n')
    writer.writeheader()
    writer.writerows(rows)
    payload = out.getvalue().encode('utf-8-sig' if original.startswith(b'\xef\xbb\xbf') else 'utf-8')
    check = list(csv.DictReader(io.StringIO(payload.decode('utf-8-sig'), newline='')))
    before = list(csv.DictReader(io.StringIO(text, newline='')))
    assert len(check) == len(before)
    for old, new in zip(before, check):
        for field in fields:
            if field != 'pct_complete' or old['PhaseID'] != 'Tram':
                assert old[field] == new[field], field
    assert TARGET.read_bytes() == original, 'Concurrent input modification'
    temp = TARGET.with_suffix('.pct_tmp')
    temp.write_bytes(payload)
    temp.replace(TARGET)
    assert BACKUP.read_bytes() == original
    print('Verified: only Tram pct_complete changed; all 5023 rows retained; backup unchanged.')

if __name__ == '__main__':
    main()
