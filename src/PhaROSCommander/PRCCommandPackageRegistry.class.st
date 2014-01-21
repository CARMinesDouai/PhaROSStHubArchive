"
This is a class (just class methods) that has the responsibility for looking up packages. In order to make your packages reachable you need to define a Directory class for your packages. This directory class needs to implement

- #includesPackage: aPackageName
	this method receive a name of package and return a boolean indicating if package is included by this directory 
	
- #deployUnitForPackage: aPackageName
	this methods receive a name of package and return a kind of MDPharoDeployUnit. For more information checkout the package PhaROSDeploymentDirectory from the squeaksource repository located at:
	http://car.mines-douai.fr/squeaksource/PhaROS

"
Class {
	#name : #PRCCommandPackageRegistry,
	#superclass : #Object,
	#classInstVars : [
		'registries'
	],
	#category : #PhaROSCommander
}

{ #category : #accessing }
PRCCommandPackageRegistry class >> deployUnitForPackage: aPackageName [ 
	| directories |
	directories := (self registries select: [ :r | (r respondsTo: #includesPackage:) and: [ r includesPackage: aPackageName  ] ]) .
	directories size = 0 ifTrue:[ self error: aPackageName, ' is not a valid package. You may add a custom repository for this package']. 
	directories size > 1 ifTrue: [ self error: aPackageName, ' is registered in more than one directory! ' ].
	
	^ (directories anyOne) deployUnitForPackage: aPackageName .
]

{ #category : #accessing }
PRCCommandPackageRegistry class >> existsPackageNamed: aPackageName [ 
	^ self registries anySatisfy: [ :r | (r respondsTo: #includesPackage:) and: [ r includesPackage: aPackageName  ] ].
]

{ #category : #accessing }
PRCCommandPackageRegistry class >> initialize [
	registries := Set new. 
]

{ #category : #accessing }
PRCCommandPackageRegistry class >> register: aDirectory [
	registries add: aDirectory.
]

{ #category : #accesing }
PRCCommandPackageRegistry class >> registries [
	^ registries.
]
