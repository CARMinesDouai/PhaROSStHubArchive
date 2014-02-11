"
A PhaROSTypeDefinition is a reification of set of fields and constants. 
"
Class {
	#name : #PhaROSTypeDefinition,
	#superclass : #Object,
	#instVars : [
		'definition'
	],
	#category : #'PhaROS-Types-DSL'
}

{ #category : #'instance creation' }
PhaROSTypeDefinition class >> for: anArrayOfDefinitions [
	^ self new definition: anArrayOfDefinitions; yourself
]

{ #category : #accessing }
PhaROSTypeDefinition >> at: aName [
	^ definition detect: [ : def | def name = aName ]
]

{ #category : #accessing }
PhaROSTypeDefinition >> atPosition: anIndex [
	^ definition at: anIndex
]

{ #category : #constants }
PhaROSTypeDefinition >> constants [
	^ definition select: #isConstant
]

{ #category : #accessing }
PhaROSTypeDefinition >> definition: anArrayOfDefinitions [
	definition := anArrayOfDefinitions 
]

{ #category : #accessing }
PhaROSTypeDefinition >> fields [
	^ definition select: #isField
]

{ #category : #converting }
PhaROSTypeDefinition >> rosdefinition [
	definition inject: '' into: [ :acc :item | acc, item rosdefinition, String lf  ]
]
