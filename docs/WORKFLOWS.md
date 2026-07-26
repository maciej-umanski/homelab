# Workflows

## Image Updates

[`.github/workflows/image-updates.yml`](../.github/workflows/image-updates.yml)

Automatically checks for newer Docker image tags in all `app/*/docker-compose.yml` files and opens a pull request with
the updates.

### Schedule

Runs weekly on Sunday at 03:00 UTC. Can also be triggered manually from the GitHub Actions UI.

### How it works

1. Installs `regctl` (from [regclient](https://regclient.org/)) to query container registries
2. Runs [`.github/scripts/check-updates.py`](../.github/scripts/check-updates.py) which:
    - Discovers all `app/*/docker-compose.yml` files
    - Parses pinned image tags (skips digest-pinned and variable-based tags)
    - Fetches available tags from each registry
    - Filters tags matching the same version family
    - Compares versions and updates the compose file if a newer version is found
3. If any images were updated, creates a pull request on the `auto/image-updates` branch

### Handling updates

When the workflow creates a PR:

1. Review the changes — verify the new versions are stable and compatible
2. Check upstream release notes for breaking changes
3. Merge the PR
4. Deploy with `docker compose pull && docker compose up -d` on the server
