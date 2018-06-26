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


[maven]: https://maven.apache.org/
