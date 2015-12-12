# What is this!?

daiichi (第一) / the first

This is a scaffolding project, meant to be used to bootstrap a new project.
It contains a bit of "convention over configuration" in order to provide
a consistent experience for creating/developing/deploying your application.

What this provides is *just enough* scaffolding to be able to deploy
an application within The Bikeshed and fryman.io Infrastructures.

> Be one with the 12-factor app.

## What it contains

### The Scaffolding

The scaffolding contains a few files necessary to plug into *most* tools
currently in use, and provides an easy convention allowing growth into
future tools as necessary. Submit a PR to add states if necessary.

* `script/bootstrap`         - Run OS commands to get requirements. Meant to run once
* `script/bootstrap-vagrant` - Run OS commands *(vagrant)*
* `script/bootstrap-docker`  - Run OS commands *(docker)*
* `script/cibuild`           - Script executed on CI servers
* `script/build`             - Script executed to build assets
* `script/server`            - Entry script to start server
* `script/shared-functions`  - Hopefully this makes sense

### The Templates
* .env        - Any variables set in `.env` will be sourced into the
                ENV of the running application.
* Travis CI   - Baseline `.travis.yml` leveraging daiichi scaffolding
* Docker      - Baseline `Dockerfile` leveraging daiichi scaffolding
* Vagrantfile - Baseline `Vagrantfile` leveraging daiichi scaffolding

## Usage

This project is meant to be added to an existing git project. You *could*
clone this repo as a base, but it's best to use this as an overlay repo.

```
  cd <to your project>
  git remote add daiichi https://github.com/frymanio/daiichi
  git pull daiichi master
```

Update as needed.

## GO FORTH

Now, delete all this, and write a good app/docs


----------------------------------------

# Title of project

Put a nice description here

## Credits

Who wrote this?

## Setup

* What settings need to be set for deployment?
* Are there system pre-requsites necessary?

## Deployment


## How to get help??
