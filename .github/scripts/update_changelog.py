"""Add a CHANGELOG entry for the add-on version in config.json if it has none.

An "## Unreleased" section, if present, becomes the new version's entry, so
add-on changes made between Portainer updates ship with the next one.
"""

import json
import re
import sys
from pathlib import Path

ADDON = Path(sys.argv[1] if len(sys.argv) > 1 else "portainer_agent")

version = json.loads((ADDON / "config.json").read_text())["version"]
changelog = ADDON / "CHANGELOG.md"
text = changelog.read_text()

if re.search(rf"^## {re.escape(version)}$", text, re.MULTILINE):
    print(f"CHANGELOG already has {version}")
    sys.exit(0)

update = (
    f"- Update Portainer agent to {version} "
    f"([release notes](https://github.com/portainer/portainer/releases/tag/{version}))\n"
)

unreleased = re.search(r"^## Unreleased\n+", text, re.MULTILINE)
if unreleased:
    text = (
        text[: unreleased.start()]
        + f"## {version}\n\n"
        + update
        + text[unreleased.end() :]
    )
else:
    first = re.search(r"^## ", text, re.MULTILINE)
    pos = first.start() if first else len(text)
    text = text[:pos] + f"## {version}\n\n" + update + "\n" + text[pos:]

changelog.write_text(text)
print(f"Added CHANGELOG entry for {version}")
