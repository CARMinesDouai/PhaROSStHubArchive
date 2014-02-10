Class {
	#name : #PhaROSItemDefinition,
	#superclass : #Object,
	#instVars : [
		'name',
		'type'
	],
	#category : #'PhaROS-Types-DSL'
}

{ #category : #'type parsing' }
PhaROSItemDefinition class >> parseRosLine: aLine typePool: aTypePool [
	| fieldType fieldName |
	fieldType := self parseType:( ($ split: aLine) at:1)  typePool: aTypePool.
	fieldName := ($ split: aLine) at:2.
	 ^ self new type: fieldType; name: fieldName; yourself
]

{ #category : #'type parsing' }
PhaROSItemDefinition class >> parseType:aTypeToken  typePool: aTypePool [
	| openBraket closeBraket innerType |
	
	"
		Possible types
		Type
		Type[]
		Type[N]
	"
	
	openBraket := aTypeToken indexOf: $[ .
	openBraket = 0 ifTrue: [ 
		" Is a common type "
		^ aTypePool type:  aTypeToken.
	].



	closeBraket := aTypeToken indexOf:$].
	innerType :=  aTypePool type:( aTypeToken copyFrom: 1 to: openBraket -1 ).
	
	^ openBraket + 1 = closeBraket  ifTrue: [ 
		" Is a typed array  "
		PhaROSArrayType ofType: innerType .
	 ] ifFalse: [ 
		" Is a typed array with fixed size "
		PhaROSArrayFixedLenghtType of: ( aTypeToken copyFrom: openBraket+ 1to: closeBraket -1 ) ofType: innerType
	 ].





	
]

{ #category : #testing }
PhaROSItemDefinition >> isConstant [
	^ false
]

{ #category : #testing }
PhaROSItemDefinition >> isField [
	^ false.
]

{ #category : #accessing }
PhaROSItemDefinition >> name [
	^ name
]

{ #category : #accessing }
PhaROSItemDefinition >> name: aName [
	name:= aName.
]

{ #category : #converting }
PhaROSItemDefinition >> rosdefinition [
	^ self subclassResponsibility .
]

{ #category : #accessing }
PhaROSItemDefinition >> type [
	^ type.
]

{ #category : #accessing }
PhaROSItemDefinition >> type: aType [
	self haltIf: (aType isKindOf: PhaROSMessageTypeBuilder ).
	type:= aType
]
