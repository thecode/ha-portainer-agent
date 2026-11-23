"""Add a CHANGELOG entry for the add-on version in config.json if it has none."""

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

entry = (
    f"## {version}\n\n"
    f"- Update Portainer agent to {version} "
    f"([release notes](https://github.com/portainer/portainer/releases/tag/{version}))\n\n"
)

first = re.search(r"^## ", text, re.MULTILINE)
pos = first.start() if first else len(text)
changelog.write_text(text[:pos] + entry + text[pos:])
print(f"Added CHANGELOG entry for {version}")
