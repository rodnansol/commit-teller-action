# Commit Teller GitHub Action

With the help of this action, you can use the [CLI APP](https://github.com/rodnansol/commit-teller) in your actions.

Example usage:

```yaml
name: Create story about Pull Request
on:
  pull_request:
    types:
      - closed

jobs:
  create-story-for-pull-request:
    runs-on: ubuntu-latest
    name: Create story for pull request at merge
    if: github.event.pull_request.merged == true
    steps:
      - uses: actions/checkout@v3
      - uses: rodnansol/commit-teller-action@v0.1.0
        name: Create story
        env:
          ISSUE_NUMBER: ${{ github.event.number }}
          COMMIT_TELLER_GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          COMMIT_TELLER_OPENAI_API_KEY: ${{ secrets.OPENAI_KEY }}
        with:
          version: early-access
          arguments: create-story -pr ${ISSUE_NUMBER} --owner ${GITHUB_REPOSITORY%/*} --repository ${GITHUB_REPOSITORY#*/}
      - name: Commit story changes
        shell: bash
        env:
          ISSUE_NUMBER: ${{ github.event.number }}
        run: |
          git add *.adoc
          git config --global user.email "${{ secrets.COMMITTER_EMAIL }}"
          git config --global user.name "${{ secrets.COMMITTER_NAME }}"
          git commit -m "docs(core): Creating story about pull request ${ISSUE_NUMBER}"
          git push origin main
```

- It will download the specified version of the tool, in this case the **early-access** and it will run it with the configured **arguments**.
- The next step will commit the generated files if there is any

## Extra tips

## Documentation

Please check the documentation here [rodnansol.github.io](https://rodnansol.github.io/commit-teller/latest/index.html)
