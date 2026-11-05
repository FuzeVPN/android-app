#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Copy one approved evidence document to a fresh dated snapshot, without overwrite.

Only an exact expected SHA-256 is accepted. This is not a universal secret scanner.
Use only approved reports; private credentials and signing paths are forbidden.
"""
from datetime import datetime, timezone
import argparse
import hashlib
import json
import os
from pathlib import Path
import re
import shutil
import stat
import uuid

DENIED = re.compile(r'(?i)signature|password|mot.de.passe|credential|secret|keystore|service.account|private.key')
ALLOWED_SUFFIXES = {'.json', '.md', '.txt', '.xml', '.jsonl'}

def require(condition, message):
    if not condition:
        raise ValueError(message)

def fingerprint(info):
    return info.st_dev, info.st_ino, info.st_size, info.st_mtime_ns

def reject_links(path):
    """Reject POSIX links and Windows reparse points, including junction parents."""
    for candidate in (path, *path.parents):
        try:
            info = candidate.lstat()
        except FileNotFoundError:
            continue
        require(not stat.S_ISLNK(info.st_mode) and not
                (getattr(info, 'st_file_attributes', 0) & getattr(stat, 'FILE_ATTRIBUTE_REPARSE_POINT', 0x400)),
                'Links and Windows reparse points are forbidden')

def snapshot(source, output_root, expected_sha256, label):
    source, output_root = Path(source).absolute(), Path(output_root).absolute()
    require(re.fullmatch('[0-9a-f]{64}', expected_sha256) is not None, 'Expected SHA-256 must be lowercase hexadecimal')
    require(re.fullmatch('[a-zA-Z0-9][a-zA-Z0-9._-]{0,79}', label) is not None, 'Invalid evidence label')
    require(source.suffix.lower() in ALLOWED_SUFFIXES and not DENIED.search(str(source)), 'Private or unsupported source path')
    reject_links(source)
    reject_links(output_root)
    require(source.is_file(), 'Source must be a regular document')
    require(output_root.is_dir(), 'Output root must already exist')
    output_root = output_root.resolve(strict=True)
    before = source.stat()
    digest = hashlib.sha256()
    collected = datetime.now(timezone.utc)
    destination = output_root / (collected.strftime('%Y%m%dT%H%M%S.%fZ') + '-' + label + '-' + uuid.uuid4().hex[:8])
    destination.mkdir(exist_ok=False)
    complete = False
    try:
        target = destination / source.name
        with source.open('rb') as original, target.open('xb') as copy:
            require(fingerprint(os.fstat(original.fileno())) == fingerprint(before), 'Source changed before copy')
            for block in iter(lambda: original.read(1024*1024), b''):
                digest.update(block)
                copy.write(block)
            require(fingerprint(os.fstat(original.fileno())) == fingerprint(before), 'Source changed during copy')
        require(fingerprint(source.stat()) == fingerprint(before), 'Source was replaced during copy')
        require(digest.hexdigest() == expected_sha256, 'Source differs from expected historical bytes; snapshot refused')
        receipt = {'schema': 1, 'label': label, 'collected_utc': collected.isoformat(),
            'file': source.name, 'bytes': before.st_size, 'sha256': expected_sha256,
            'policy': 'new directory; exclusive files; source fingerprint stable; no overwrite'}
        with (destination/'RECEIPT.json').open('x', encoding='utf-8') as stream:
            json.dump(receipt, stream, ensure_ascii=False, indent=2)
            stream.write('\n')
        complete = True
        return destination, receipt
    finally:
        if not complete:
            # Only this fresh UUID directory is removed; no source or previous
            # snapshot can be addressed by the user-supplied label.
            reject_links(destination)
            require(destination.resolve(strict=True).parent == output_root, 'Cleanup escaped the expected output root')
            shutil.rmtree(destination)

def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--source', required=True)
    parser.add_argument('--output-root', required=True)
    parser.add_argument('--expected-sha256', required=True)
    parser.add_argument('--label', required=True)
    args = parser.parse_args(argv)
    destination, receipt = snapshot(args.source, args.output_root, args.expected_sha256, args.label)
    print(json.dumps({'snapshot': str(destination), **receipt}, ensure_ascii=False))
    return 0

if __name__ == '__main__':
    try:
        raise SystemExit(main())
    except (ValueError, OSError) as error:
        raise SystemExit('FAIL: ' + str(error))
