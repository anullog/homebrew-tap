# anullog/homebrew-tap

[Homebrew](https://brew.sh) formulae for my tools.

| Formula | What it is |
|---|---|
| [`photosync`](https://github.com/anullog/photosync) | Safe copy, mirror and verify for photo folders and memory cards (macOS) |

## Install

```bash
brew install anullog/tap/photosync
```

`brew upgrade` keeps it up to date; `brew uninstall photosync` removes it.

## Releasing a new version of a formula

1. Tag and publish the release in the tool's repository (e.g. `v1.2.0`).
2. Get the checksum of its source archive:
   ```bash
   curl -sL https://github.com/anullog/photosync/archive/refs/tags/v1.2.0.tar.gz | shasum -a 256
   ```
3. Update `url` and `sha256` in `Formula/photosync.rb`, push, and let CI pass.
