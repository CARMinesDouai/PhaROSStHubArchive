Class {
	#name : #PhaROSDynamicPackage,
	#superclass : #PhaROSPackage,
	#instVars : [
		'types',
		'dependencies'
	],
	#category : #'PhaROS-Controllers'
}

{ #category : #'as yet unclassified' }
PhaROSDynamicPackage >> dependencies [ 
	^ dependencies
]

{ #category : #'as yet unclassified' }
PhaROSDynamicPackage >> initialize [ 
	dependencies := Set new.
	types := Dictionary new. 
]

{ #category : #'as yet unclassified' }
PhaROSDynamicPackage >> registerDependency: aBlock [
	dependencies add: aBlock
]

{ #category : #'as yet unclassified' }
PhaROSDynamicPackage >> registerType: aTypeName with: aDefinition [
	types at: aTypeName put: aDefinition.
]

{ #category : #'as yet unclassified' }
PhaROSDynamicPackage >> types [ 
	^ types 
]
