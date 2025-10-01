# eXist-db
Container image builder for eXist-db applications.

* <https://exist-db.org>
* <https://hub.docker.com/r/existdb/existdb>

## GitLab

Add `.gitlab-ci.yml` to your repo with:

```yaml
build:
  trigger:
    strategy: depend  # use `mirror` with GitLab 18.2
    include:
    - project: lettres/services/existdb
      file: .gitlab/pipelines/build.yaml
      inputs:
        existdb-version: 6.4.0
```

## GitHub

Add `.github/workflows/build.yaml` to your repo with:

```yaml
on: push
jobs:
  build:
    uses: unige-lettres/existdb/.github/workflows/build.yaml@main
    with:
      existdb-version: 6.4.0
```
