# QBiC Parent POMs
[![Build Status](https://travis-ci.org/qbicsoftware/parent-poms.svg?branch=master)](https://travis-ci.org/qbicsoftware/parent-poms)

This repository contains no code. It only contains the parent project object model (POM) files we use across all of our software.

## Motivation
QBiC relies on Liferay and Vaadin for its front-end and including these dependencies every single time in every portlet is a time-consuming task. Using [maven] parent POM files enables organizations to define dependencies in a single POM file from which other modules (_artifacts_ in [maven] lingo) can derive. 

## Structure
The hierarchy of the parent POMs reflects how QBiC structures its software: 

  - All QBiC software modules belong to a parent organization (i.e., `groupId=life.qbic`). `/pom.xml` is the parent POM for QBiC's java-based solutions. 
  - Command-line interface (CLI) tools require parsing arguments. This dependency is included in  `/cli/pom.xml`. This is the same for artifacts of type `service` and `gui`. 
  - Libraries depending on portal technlogies such as Liferay (e.g., the already deprecated `liferayandvaadinutls`) use `/portal/pom.xml` as a parent POM. 
  - Vaadin portlets use `/portal/portlet/pom.xml` as a parent POM.

```bash
parent-poms
    ├── cli
    │   └── pom.xml
    ├── portal
    │   ├── pom.xml
    │   └── portlet
    │       └── pom.xml
    └── pom.xml

```

## For developers
### Releasing a new version of the POMs
Since these parent POMs have dependencies between them, the cleanest way to manage releases is to use the same version for each of the POMs. Releasing the parent POMs is as simple as releasing other [Maven][maven] artifacts. The first thing you need to do is to merge all changes into the `master` branch:
  - `git pull`
  - `git checkout master`
  - `git merge development`

At this point, the `HEAD` of the `master` and `development` branches are identical. Update each of the parent POMs and the reference to their parents, as shown in this example:

| File                     | Before (snapshot version)                                                        | After (release version)                      |
| :----------------------- |:---------------------------------------------------------------------------------|:---------------------------------------------|
| `pom.xml`                | `project/version = 1.2.0-SNAPSHOT`                                               | `project/version = 1.2.0`
| `cli/pom.xml`            | `project/version = 1.2.0-SNAPSHOT`<br/>`project/parent/version = 1.2.0-SNAPSHOT` | `project/version = 1.2.0`<br/>`project/parent/version = 1.2.0`
| `portal/pom.xml`         | `project/version = 1.2.0-SNAPSHOT`<br/>`project/parent/version = 1.2.0-SNAPSHOT` | `project/version = 1.2.0`<br/>`project/parent/version = 1.2.0`
| `portal/portlet/pom.xml` | `project/version = 1.2.0-SNAPSHOT`<br/>`project/parent/version = 1.2.0-SNAPSHOT` | `project/version = 1.2.0`<br/>`project/parent/version = 1.2.0`

If you want to test your changes before pushing the code, take a look at what `.travis.yml` does. Here is a simplified version that you can run on your computer to _install_ these POMs in your local [Maven][maven] repository:
```sh
mvn install && mvn --file cli/pom.xml install && mvn --file portal/pom.xml install && mvn --file portal/portlet/pom.xml install
```

Once everything looks fine, stage, commit and push your changes:
  - `git add .`
  - `git commit -m "Release version 1.2.0"`
  - `git push`

Monitor the build on [Travis][travis] and make sure it all builds properly.

Switch to the `development` branch (`git checkout development`) and _bump_ the snapshot version:

| File                     | Before (snapshot version)                                                        | After (release version)                      |
| :----------------------- |:---------------------------------------------------------------------------------|:---------------------------------------------|
| `pom.xml`                | `project/version = 1.2.0-SNAPSHOT`                                               | `project/version = 1.3.0-SNAPSHOT`
| `cli/pom.xml`            | `project/version = 1.2.0-SNAPSHOT`<br/>`project/parent/version = 1.2.0-SNAPSHOT` | `project/version = 1.3.0-SNAPSHOT`<br/>`project/parent/version = 1.3.0-SNAPSHOT`
| `portal/pom.xml`         | `project/version = 1.2.0-SNAPSHOT`<br/>`project/parent/version = 1.2.0-SNAPSHOT` | `project/version = 1.3.0-SNAPSHOT`<br/>`project/parent/version = 1.3.0-SNAPSHOT`
| `portal/portlet/pom.xml` | `project/version = 1.2.0-SNAPSHOT`<br/>`project/parent/version = 1.2.0-SNAPSHOT` | `project/version = 1.3.0-SNAPSHOT`<br/>`project/parent/version = 1.3.0-SNAPSHOT`

And, again, stage, commit and push your changes (remember that you are on the `development` branch):
  - `git add .`
  - `git commit -m "Post-release version bump to 1.3.0-SNAPSHOT"`
  - `git push`

[maven]: https://maven.apache.org/
[travis]: https://travis-ci.com
