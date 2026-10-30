# Release checklist

- Merge latest translations. Potentially wait for newest features to be translated.
- Rename "Unreleased" section in [CHANGELOG.md](../CHANGELOG.md).
- Create new section in [in-app release notes](../src/lib/presentation/release_notes/release_notes.dart).
    - Only mention most relevant user-facing changes here. Include important tips and limitations.
    - Do not reference Github issues.
- Create new entries in [F-Droid changelog](../metadata/en-US/changelogs).
    - These should be similar to the in-app changelogs, focusing on user-facing changes (no internals).
- Update [pubspec.yaml](src/pubspec.yaml) to new app version.
- Commit.
- Create a tag: `git tag -a vX.Y.Z -m "vX.Y.Z"`
- Push: `git push --follow-tags`
