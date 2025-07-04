### DuckDB own ports

#### How to add a new port

1. Create the folder `ports/<name>`
2. Add relevant files
3. Run (from the root of the repo):
```bash
vcpkg --x-builtin-ports-root=./ports --x-builtin-registry-versions-dir=./versions x-add-version <name> --verbose
```

#### How to update an existing port

1. Add relevant files / change existing files
2. Increment the `port-version` in `ports/<name>/vcpkg.json`
3. Increment the `port-version` in `versions/baseline.json` for the <name> entry
4. Run (from the root of the repo):
```bash
vcpkg --x-builtin-ports-root=./ports --x-builtin-registry-versions-dir=./versions x-add-version <name> --verbose
```

#### NOTE:
To test an added port, it needs to merged into the `main` branch of your fork.
