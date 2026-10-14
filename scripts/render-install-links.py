#!/usr/bin/env python3
"""Write the install links into the root README from sfdx-project.json.

`sf package version create` appends a "<Package>@<version> -> 04t..." entry to
packageAliases, which makes sfdx-project.json the source of truth for what is
installable. This script takes the highest version of each package and rewrites
the block between the INSTALL_LINK markers in the root README.
Release status must be verified separately before publishing customer links.

Usage:
  python3 scripts/render-install-links.py            # rewrite README
  python3 scripts/render-install-links.py --check    # exit 1 if any is out of date
"""
import json
import re
import sys
from pathlib import Path

START = "<!-- INSTALL_LINK:START -->"
END = "<!-- INSTALL_LINK:END -->"
LOGIN = "https://login.salesforce.com/packaging/installPackage.apexp?p0="
TEST = "https://test.salesforce.com/packaging/installPackage.apexp?p0="

# Buttons are shields.io badges in the Salesforce brand colour
BADGE = "https://img.shields.io/badge/"
BADGE_PROD = BADGE + "Install-Production%20or%20Developer%20org-00A1E0?style=for-the-badge"
BADGE_SANDBOX = BADGE + "Install-Sandbox-6B7A8F?style=for-the-badge"


def version_key(version: str) -> tuple:
    """0.1.0-1 -> (0, 1, 0, 1), so versions sort numerically rather than as text."""
    return tuple(int(part) for part in re.split(r"[.\-]", version))


def latest_versions(aliases: dict) -> dict:
    """Package name -> (version, 04t id) for the highest version of each package."""
    best: dict = {}
    for alias, subscriber_id in aliases.items():
        if "@" not in alias or not subscriber_id.startswith("04t"):
            continue
        name, version = alias.rsplit("@", 1)
        key = version_key(version)
        if name not in best or key > best[name][0]:
            best[name] = (key, version, subscriber_id)
    return {name: (v, sid) for name, (_, v, sid) in best.items()}


def render(version: str, subscriber_id: str) -> str:
    return (
        f'<a href="{LOGIN}{subscriber_id}" target="_blank" rel="noopener noreferrer">'
        f'<img alt="Install in a production or Developer org" src="{BADGE_PROD}"></a>\n'
        f'<a href="{TEST}{subscriber_id}" target="_blank" rel="noopener noreferrer">'
        f'<img alt="Install in a sandbox" src="{BADGE_SANDBOX}"></a>\n\n'
        f"Version {version}"
    )


def main() -> int:
    check = "--check" in sys.argv
    root = Path(__file__).resolve().parent.parent
    project = json.loads((root / "sfdx-project.json").read_text())
    versions = latest_versions(project.get("packageAliases") or {})

    stale, written, errors = [], 0, []

    entries = [entry for entry in project["packageDirectories"] if entry.get("package")]
    if len(entries) != 1:
        print("Expected exactly one configured package for the root README", file=sys.stderr)
        return 1

    for entry in entries:
        name = entry["package"]
        readme = root / "README.md"

        if not readme.exists():
            errors.append("No root README.md")
            continue
        if name not in versions:
            errors.append(f"{name}: no package version yet")
            continue

        text = readme.read_text()
        if text.count(START) != 1 or text.count(END) != 1 or text.index(START) > text.index(END):
            errors.append(
                f"{readme.relative_to(root)}: expected exactly one ordered "
                f"{START} / {END} marker pair"
            )
            continue

        version, subscriber_id = versions[name]
        updated = re.sub(
            re.escape(START) + r".*?" + re.escape(END),
            f"{START}\n{render(version, subscriber_id)}\n{END}",
            text,
            flags=re.S,
        )
        if updated == text:
            continue
        if check:
            stale.append(str(readme.relative_to(root)))
        else:
            readme.write_text(updated)
            written += 1

    if errors:
        print("Install-link configuration errors:", file=sys.stderr)
        for error in errors:
            print(f"  {error}", file=sys.stderr)

    if check:
        if stale:
            print("Install links are out of date in:", file=sys.stderr)
            for path in stale:
                print(f"  {path}", file=sys.stderr)
            print("Run: python3 scripts/render-install-links.py", file=sys.stderr)
        if stale or errors:
            return 1
        print("Install links are up to date")
        return 0

    if errors:
        return 1
    print(f"Updated {written} README(s)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
