# Changelog

## 0.2.0

Add `--minify`, which strips comments and indentation from the bundle after the Customizer
parameters.

## 0.1.0

First release. `onescad INPUT -o OUTPUT [-L DIR]... [--verify]` bundles an OpenSCAD model and
everything it includes or uses into one `.scad` file that keeps the Customizer working, copies a
neighboring presets file, and embeds each contributing license.
