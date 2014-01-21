Class {
	#name : #PRCCommandPackageRegistry,
	#superclass : #Object,
	#classInstVars : [
		'registries'
	],
	#category : #PhaROSCommander
}

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
