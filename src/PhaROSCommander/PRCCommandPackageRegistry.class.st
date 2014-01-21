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
