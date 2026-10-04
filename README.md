# onescad

Bundle an OpenSCAD model into one self-contained, Customizer-ready `.scad` file.

```sh
uvx onescad model.scad -o dist/model.scad
```

The bundle renders identically to the source, keeps the Customizer's parameters, groups, and
widgets, and carries the license text of every file it takes code from. Python 3.11 or newer;
no runtime dependencies.

## Usage

```
onescad INPUT -o OUTPUT [-L DIR]... [--minify] [--verify] [--version]
```

| Option | Meaning |
| --- | --- |
| `INPUT` | The model's `.scad` file. |
| `-o`, `--output` | The bundle to write. Parent directories are created. |
| `-L`, `--library DIR` | A directory to search for `include` and `use`; repeatable. |
| `--minify` | Strip comments and indentation after the Customizer parameters. |
| `--verify` | Render the source and the bundle with `openscad` and compare them. |
| `--version` | Print the version. |

Warnings print to stderr as `onescad: warning: <message>`. Errors print as `onescad: <message>`.

| Exit code | Meaning |
| --- | --- |
| 0 | The bundle was written (and verified, with `--verify`). |
| 1 | The bundle could not be built or verified. |
| 2 | Usage error. |

## Search path

`include` and `use` are resolved in this order: the including file's directory, each `-L`
directory, then each `OPENSCADPATH` entry. OpenSCAD also searches the user and built-in library
directories; onescad does not, so a bundle is the same on every machine. Put those libraries on
`-L` or `OPENSCADPATH`. A missing file is an error that lists the directories searched.

## What gets bundled

The output has these parts, in order:

1. A header of `//` comments:
   - the onescad version, marked as generated;
   - the source path relative to its git root, the remote as an https URL, and the commit, with
     `+dirty` when tracked files have uncommitted changes (omitted outside a git work tree with a
     commit);
   - the main file's leading comment;
   - the fonts named by `font=` strings, the files read by `import()` or `surface()`, and a note
     naming the presets file, when they apply;
   - for each license file covering code that was kept, its directory and its text verbatim. The
     license file is the nearest `LICENSE*`, `LICENCE*`, or `COPYING*` in an ancestor directory of
     each source file.
2. The Customizer parameters, hoisted to the top.
3. A `/* [Hidden] */` marker, so nothing after it appears in the Customizer.
4. Each used file's definitions, dependencies first, each preceded by a `// onescad: <path>` marker
   and the file's leading comment.
5. The main file, with its included files spliced in.

`--minify` removes comments, blank lines, and indentation from parts 4 and 5, keeping one line
break where the source had any; on BOSL2 it cuts the bundle by about two thirds. The header and
the Customizer parameters are kept, so the licenses and the Customizer's descriptions survive.
Identifiers are not renamed.

The output has no timestamps, so the same input gives byte-identical output.

Definitions that the model never reaches are dropped. A definition is renamed (`name__1`) when
keeping its name would capture a different reference, as when a library wraps a builtin it later
overrides.

## Presets

If `model.json` sits next to `model.scad`, onescad copies it verbatim to the output's name with a
`.json` extension (`dist/model.json` for `-o dist/model.scad`). OpenSCAD loads presets only from a
`.json` beside the `.scad`, so keep the two together. A warning names each preset key that is not a
Customizer parameter of the bundle.

## Verification

`--verify` needs `openscad` on `PATH`. It compares the source with the bundle on:

- the CSG of the default parameters and of every preset;
- the `ECHO` lines, after undoing renames;
- the Customizer parameter set (`-o x.param`, ignoring `title`).

The bundle renders with `OPENSCADPATH` unset and an empty `HOME`, which proves it is
self-contained. `text()` fonts are not compared. Verifying needs an OpenSCAD that can export
`param` (the 2026.09 snapshots do; 2021.01 is untested).

## Limitations

- The Customizer is emulated, not run. A model whose parameter assignment reads a name before
  that name's first assignment cannot be hoisted; onescad stops with an error.
- A top-level `$` variable in a used file, conflicting definitions that cannot be renamed, and a
  rename that would split a call's possible targets are errors.
- A top-level variable in a used file is evaluated once in the bundle, not on every call as
  OpenSCAD does; onescad warns.
- `import()` and `surface()` still read their files at render time; onescad warns and lists them
  in the header. Relative paths then resolve against wherever the bundle is rendered.
- Fonts are not embedded; the header lists those that `font=` names.
- A model's license text appears in the header only when a license file covers its source.
  onescad warns about each source file with none.

## License

MIT. See `LICENSE`. Bundles carry the licenses of their inputs; check them before redistributing.
