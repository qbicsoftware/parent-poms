# Changelog

# 3.1.4 (2020-10-06)
* Removes unused flatten Maven plugin which will now not produce flatten
  poms during build anymore

## 3.1.3 (2020-10-05)
* As the most artefacts are hosted on Maven central
we can speed up the build process when telling
Maven to start dependency resolvement against Maven
central first.

## 3.1.2 2020-10-05

* Increase Java memory during vaadin compilation to `-XmX1024m`
  
## 3.1.1 2020-10-01

* Update URL for QBiC's Maven repository ->
  https://qbic-repo.qbic.uni-tuebingen.de

## 3.1.0 2020-09-24

* Define dependency for mysql java connector (8.0.21)

## 3.0.0 22-09-2020

* Remove all libraries from the dependency list that implement the
  parent-poms themselves. This caused a cyclic dependency and needed to
  be solved. All applications need to define these libraries now
  explicitly.
* Add GroovyDoc generation
* Use new Sonatype Nexus instance

## 2.4.0

* Updates data-model-lib from 1.9.4 to 1.10.1


## 2.3.0 14-08-2020

* Introduce automated GroovyDoc generation 

## 2.2.5 03-08-2020

* Pin version for flatten-maven-plugin to 1.2.2

## 2.2.4 03-08-2020

* Remove dependency pin for vaadin in the portal pom

## 2.2.3 03-08-2020

* Introduce portal-utils-lib for portal pom (v2.2.0)
* Fix revision number

## 2.2.2 03-08-2020

* Flatten the child poms for proper deployment

## 2.2.1 03-08-2020

* Bump log4j core version to address a security vulnerarbility
* Introduce core-utils-lib and data-model-lib in root pom

## 2.2.0

* Include dependency for the Spock testing framework
* Files ending with `*Spec.groovy` and `*Specification.groovy` are now executed during the Maven's test cycle
* Include dependency for the Corbertura Maven plugin
* Enables Micronaut openAPI view generation
