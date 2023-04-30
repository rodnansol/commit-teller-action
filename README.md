# CLI App GitHub Action

With the help of this action, you can use the [CLI APP](https://github.com/rodnansol/cli-app-template) in your actions.

Example usage:

```yaml
name: run-cli-app
on:
  push:
    branches:
      - main
  workflow_dispatch:

jobs:
  update-catalog-documentation:
    runs-on: ubuntu-latest
    name: Update catalog documentation
    if: startsWith(github.event.head_commit.message, 'Committing the result of the CLI app') != true
    steps:
      - uses: actions/checkout@v3
      - uses: rodnansol/cli-app-action@v0.1.0
        name: Run CLI app
        with:
          version: early-access
          arguments: hello
      - name: Commit changes
        shell: bash
        run: |
          git add README.adoc
          git config --global user.email "${{ secrets.COMMITTER_EMAIL }}"
          git config --global user.name "${{ secrets.COMMITTER_NAME }}"
          git commit -m "Committing the result of the CLI app"
          git push origin main


```

- It will download the specified version of the tool, in this case the **early-access** and it will run it with the configured **arguments**.
- The next step will commit the generated files.

## Extra tips

## Documentation

Please check the documentation here [rodnansol.github.io](https://rodnansol.github.io/cli-app/latest/index.html)
