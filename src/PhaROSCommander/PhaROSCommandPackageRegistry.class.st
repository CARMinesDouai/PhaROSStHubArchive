Class {
	#name : #PhaROSCommandPackageRegistry,
	#superclass : #Object,
	#classInstVars : [
		'registries'
	],
	#category : #PhaROSCommander
}

{ #category : #accessing }
PhaROSCommandPackageRegistry class >> existsPackageNamed: aPackageName [ 
	^ self registries anySatisfy: [ :r | (r respondsTo: #includesPackage:) and: [ r includesPackage: aPackageName  ] ].
]

{ #category : #accessing }
PhaROSCommandPackageRegistry class >> initialize [
	registries := Set new. 
]

{ #category : #accessing }
PhaROSCommandPackageRegistry class >> register: aDirectory [
	registries add: aDirectory.
]

{ #category : #accesing }
PhaROSCommandPackageRegistry class >> registries [
	^ registries.
]
