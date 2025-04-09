### DuckDB own ports

#### How to add a new port

1. Create the folder `ports/PORT_NAME`
2. Add relevant files
3. Add a file `versions/P-/PORT_NAME.json` (instead of `P-` use first letter of `PORT_NAME` || `-`)
4. Run `git -C ./ports ls-tree --format='%(objectname)' HEAD -- PORT_NAME`
5. store the result as `git-tree`
