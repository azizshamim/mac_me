# Title of project

Track the mac addresses of network devices and associate them with people to track when people are in specific locations.

## Credits

* James Fryman

## Setup

* `script/bootstrap`: Sets up the application for running. Installs deps. Requires: Elixir (install using `brew install elixir`)

## Deployment

This project leverages edeliver: https://github.com/boldpoker/edeliver. Config settings can be found at `.deliver/config`

Initial Release:
* `mix edeliver build release [--revision=<git-revision>|--tag=<git-tag>] [--branch=<git-branch>]`

Upgrade (appup):
* `mix edeliver build appups --from=<git-tag-or-revision>|--with=<release-version-from-store> [--to=<git-tag-or-revision>] [--branch=<git-branch>]`

Upgrade (live):
* `mix edeliver build upgrade --from=<git-tag-or-revision>|--with=<release-version-from-store> [--to=<git-tag-or-revision>] [--branch=<git-branch>]`

Deploy:
* `mix edeliver deploy release|upgrade [[to] staging|production] [--version=<release-version>] [Options]`

## How to get help??
