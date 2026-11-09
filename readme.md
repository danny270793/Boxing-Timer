# Boxing Timer

Round timer with local modes. No account or sign-in: all data (modes and preferences) stays on the device.

Flutter **3.47.2** (see [`.tool-versions`](.tool-versions)). Package: `io.github.danny270793.boxingtimmer`.

## Quick start

```sh
asdf exec flutter pub get
asdf exec flutter run
```

## Documentation

- [Run on an emulator or device](docs/getting-started.md)
- [Sync Xcode and publish to the App Store](docs/app-store.md)
- [Bump app version and Flutter SDK](docs/versioning.md)

## Agents

See [AGENTS.md](AGENTS.md) (Claude: [CLAUDE.md](CLAUDE.md)).

## Deploy

`./scripts/deploy.sh` builds a release APK and publishes it to Firebase App Distribution. Before the first run, copy `scripts/.env.deploy.example` to `scripts/.env.deploy` (gitignored), set `FIREBASE_GROUPS` to the tester group alias, and run `firebase login`. `--bump` raises the build number and `--dry-run` prints the commands without running them.
