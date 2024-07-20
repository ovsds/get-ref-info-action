# Get Ref Info Action

[![CI](https://github.com/ovsds/get-ref-info-action/workflows/Check%20PR/badge.svg)](https://github.com/ovsds/get-ref-info-action/actions?query=workflow%3A%22%22Check+PR%22%22)
[![GitHub Marketplace](https://img.shields.io/badge/Marketplace-Get%20Ref%20Info-blue.svg)](https://github.com/marketplace/actions/get-ref-info)

Gets target ref information.

## Usage

### Example

```yaml
- name: Get ref info
  id: get-ref-info
  uses: ovsds/get-ref-info-action@v1
  with:
    ref: heads/main
```

### Action Inputs

| Name           | Description                                                        | Default                             |
| -------------- | ------------------------------------------------------------------ | ----------------------------------- |
| `github_token` | Github token used for API calls. Required scope - 'contents: read' | ${{ github.token }}                 |
| `owner`        | Repository owner.                                                  | ${{ github.repository_owner }}      |
| `repo`         | Repository name.                                                   | ${{ github.event.repository.name }} |
| `ref`          | Target ref name.                                                   |                                     |

### Action Outputs

| Name       | Description |
| ---------- | ----------- |
| `exists`   | Ref exists  |
| `ref`      | Ref name    |
| `ref_sha`  | Ref SHA     |
| `ref_type` | Ref type    |

## Development

### Global dependencies

- nvm
- node

### Taskfile commands

For all commands see [Taskfile](Taskfile.yaml) or `task --list-all`.

## License

[MIT](LICENSE)
