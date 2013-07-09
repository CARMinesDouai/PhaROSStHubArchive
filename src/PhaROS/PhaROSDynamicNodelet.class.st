Class {
	#name : #PhaROSDynamicNodelet,
	#superclass : #PhaROSNodelet,
	#instVars : [
		'types',
		'dependencies'
	],
	#category : #'PhaROS-Nodelets'
}

{ #category : #'as yet unclassified' }
PhaROSDynamicNodelet >> dependencies [ 
	^ dependencies
]

{ #category : #'as yet unclassified' }
PhaROSDynamicNodelet >> initialize [ 
	dependencies := Set new.
	types := Dictionary new. 
]

{ #category : #'as yet unclassified' }
PhaROSDynamicNodelet >> registerDependency: aBlock [
	dependencies add: aBlock
]

{ #category : #'as yet unclassified' }
PhaROSDynamicNodelet >> registerType: aTypeName with: aDefinition [
	types at: aTypeName put: aDefinition.
]

{ #category : #'as yet unclassified' }
PhaROSDynamicNodelet >> types [ 
	^ types 
]
