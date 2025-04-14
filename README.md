### DuckDB own ports

#### How to add a new port

1. Create the folder `ports/<name>`
2. Add relevant files
3. Run (from the root of the repo):
```bash
vcpkg --x-builtin-ports-root=./ports --x-builtin-registry-versions-dir=./versions x-add-version <name> --verbose
```
