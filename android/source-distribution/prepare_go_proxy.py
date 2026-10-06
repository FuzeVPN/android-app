"""Prepare an isolated offline Go module proxy from the reviewed source archives."""
from pathlib import Path, PurePosixPath
import argparse
import hashlib
import json
import shutil


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('output', type=Path, help='New directory for the offline proxy')
    args = parser.parse_args()
    output = args.output.resolve()
    if output.exists():
        raise SystemExit('The output directory must not exist.')
    root = Path(__file__).resolve().parents[2]
    manifest = json.loads((Path(__file__).parent / 'completeness.manifest.json').read_text(encoding='utf-8'))
    files = []
    for component in manifest['components']:
        if 'go_sum' not in component:
            continue
        name = PurePosixPath(component['name'])
        version = component['version']
        if name.is_absolute() or '..' in name.parts or any(c in version for c in '/\\:'):
            raise SystemExit('Unsafe module coordinate.')
        for field, digest, suffix in (('path', 'sha256', '.zip'), ('go_mod_file', 'go_mod_sha256', '.mod'), ('version_info_file', 'version_info_sha256', '.info')):
            source = (root / component[field]).resolve()
            if not source.is_relative_to(root / 'android/source-distribution') or not source.is_file():
                raise SystemExit('Source outside reviewed distribution.')
            if hashlib.sha256(source.read_bytes()).hexdigest() != component[digest]:
                raise SystemExit(f'Source hash mismatch: {source.name}')
            files.append((source, output / name / '@v' / (version + suffix)))
    output.mkdir(parents=True)
    for source, target in files:
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copyfile(source, target)
    print(output.as_uri())


if __name__ == '__main__':
    main()
