#!/usr/bin/env python3
"""Auto-discover Docker Compose files and check for newer stable image tags."""

import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
APP_DIR = ROOT / 'app'

SKIP_IMAGES = {
    'ghcr.io/immich-app/postgres',
}


def parse_version(tag):
    v = tag
    if v.startswith('release-'):
        v = v[8:]
    elif v.startswith('v'):
        v = v[1:]
    v = re.sub(r'-(slim|openvino|cuda|alpine|bookworm|bullseye).*$', '', v)
    return tuple(int(p) for p in v.split('.') if p.isdigit())


def tag_to_pattern(tag):
    return '^' + re.sub(r'\d+', r'\\d+', re.escape(tag)) + '$'


def tag_to_glob_filter(tag):
    result = re.sub(r'\d+\.\d+\.\d+', '*', tag)
    if result == '*':
        return None
    return result


def discover_services(base_dir):
    services = []
    for compose_file in sorted(base_dir.glob('*/docker-compose.yml')):
        content = compose_file.read_text()
        for line in content.split('\n'):
            m = re.match(r'\s*image:\s+(\S+):(\S+)', line)
            if not m:
                continue
            full_image, tag = m.group(1), m.group(2)
            if '@sha256:' in tag:
                continue
            if full_image in SKIP_IMAGES:
                continue
            services.append({
                'file': str(compose_file.relative_to(ROOT)),
                'image': full_image,
                'tag': tag,
            })
    return services


def get_tags(image, filter_glob=None):
    cmd = ['regctl', 'tag', 'ls', image]
    if filter_glob:
        cmd.extend(['--filter', filter_glob])
    result = subprocess.run(
        cmd,
        capture_output=True, text=True, timeout=60,
    )
    if result.returncode != 0:
        print(f'  Skipping: {result.stderr.strip()}')
        return []
    return [t.strip() for t in result.stdout.strip().split('\n') if t.strip()]


def get_latest_stable(image, current_tag):
    tags = get_tags(image, tag_to_glob_filter(current_tag))
    if not tags:
        return None
    pattern = re.compile(tag_to_pattern(current_tag))
    stable = [t for t in tags if pattern.match(t)]
    if not stable:
        return None
    return max(stable, key=parse_version)


def update_compose(filepath, image_name, old_tag, new_tag):
    content = filepath.read_text()
    old = f'image: {image_name}:{old_tag}'
    new = f'image: {image_name}:{new_tag}'
    if old not in content:
        print(f'  Could not find image line in file')
        return False
    filepath.write_text(content.replace(old, new))
    return True


def main():
    services = discover_services(APP_DIR)
    if not services:
        print('No services found.')
        return

    print(f'Found {len(services)} service(s) across {len({s["file"] for s in services})} compose file(s)\n')

    updates = []

    for svc in services:
        compose = ROOT / svc['file']
        current = svc['tag']
        image = svc['image']

        print(f'{svc["file"]} :: {image}:{current}')

        try:
            cv = parse_version(current)
        except (ValueError, IndexError):
            print(f'  Cannot parse version, skipping')
            continue

        latest = get_latest_stable(image, current)
        if latest is None:
            print(f'  No matching tags found')
            continue

        try:
            lv = parse_version(latest)
        except (ValueError, IndexError):
            print(f'  Cannot parse latest tag {latest}, skipping')
            continue

        if lv > cv:
            print(f'  {current}  ->  {latest}')
            if update_compose(compose, image, current, latest):
                updates.append(f'{svc["file"]}: {image}:{current} -> {latest}')
        elif lv == cv:
            print(f'  Already latest ({current})')
        else:
            print(f'  Current ({current}) is newer ({latest})?')

    if updates:
        print(f'\n{len(updates)} service(s) updated:')
        for u in updates:
            print(f'  - {u}')
    else:
        print('\nAll images are up to date.')


if __name__ == '__main__':
    main()
