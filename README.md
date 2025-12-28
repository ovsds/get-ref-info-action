# Get Ref Info Action

[![CI](https://github.com/ovsds/get-ref-info-action/workflows/Check%20PR/badge.svg)](https://github.com/ovsds/get-ref-info-action/actions?query=workflow%3A%22%22Check+PR%22%22)
[![GitHub Marketplace](https://img.shields.io/badge/Marketplace-Get%20Ref%20Info-blue.svg)](https://github.com/marketplace/actions/get-ref-info)

Returns information for the given ref

## Usage

### Example

```yaml
jobs:
  get-ref-info:
    steps:
      - name: Get Ref Info
        id: get-ref-info
        uses: ovsds/get-ref-info-action@v1
        with:
          ref: heads/main
```

### Action Inputs

```yaml
inputs:
  github_token:
    description: |
      Github token used for API calls. Required scope - 'contents: read'
    default: ${{ github.token }}

  owner:
    description: |
      Owner of the repository
    default: ${{ github.repository_owner }}

  repo:
    description: |
      Repository name
    default: ${{ github.event.repository.name }}

  ref:
    description: |
      Target ref name
    required: true
```

### Action Outputs

```yaml
outputs:
  exists:
    description: |
      Ref exists
    value: ${{ steps.get-ref.outputs.exists }}

  ref:
    description: |
      Ref name
    value: ${{ steps.get-ref.outputs.ref }}

  sha:
    description: |
      Ref SHA
    value: ${{ steps.get-ref.outputs.sha }}

  type:
    description: |
      Ref type
```

## Development

### Global dependencies

- [Taskfile](https://taskfile.dev/installation/)
- [nvm](https://github.com/nvm-sh/nvm?tab=readme-ov-file#install--update-script)

### Taskfile commands

For all commands see [Taskfile](Taskfile.yaml) or `task --list-all`.

## License

[MIT](LICENSE)
