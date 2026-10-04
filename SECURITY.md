# Security

onescad reads the `.scad` files that a model includes or uses, the license files beside them,
and a neighboring presets `.json`. It runs `git` to read the source's remote and commit, and,
with `--verify`, `openscad`. It writes the bundle and a copy of the presets file. It makes no
network requests and sends no telemetry. A bundle embeds the remote URL of the repository it
was built from.

## Reporting a vulnerability

Please use
[GitHub's private vulnerability reporting](https://github.com/kjiwa/onescad/security/advisories/new)
for this repository rather than opening a public issue. If that option isn't available yet,
email kamil.jiwa@gmail.com instead.
