"
A PhaROSConstantDefinition  Is an constant usable in the type that is part of. It has name, type and value.
"
Class {
	#name : #PhaROSConstantDefinition,
	#superclass : #PhaROSItemDefinition,
	#instVars : [
		'value'
	],
	#category : #'PhaROS-Types-DSL'
}

{ #category : #'instance creation' }
PhaROSConstantDefinition class >> named: aName typedAs: aPhaROSType withValue: aValue [ 
	^ self new name: aName; type: aPhaROSType; value: aValue; yourself
]

{ #category : #'type parsing' }
PhaROSConstantDefinition class >> parseRosLine: aLine typePool: aTypePool [
	|typeLine|
	typeLine := ($= split: aLine).
	
	^ (super parseRosLine: (typeLine at:1) typePool: aTypePool) value: (typeLine at:2); yourself.
	
]

{ #category : #converting }
PhaROSConstantDefinition >> classAccessor [
	

	^ (('{1}', String crlf, String tab, '^{2}' , String crlf) translated format: { name asLowercase . self valueForGeneration })
]

{ #category : #testing }
PhaROSConstantDefinition >> isConstant [ 	
	^ true
]

{ #category : #accessing }
PhaROSConstantDefinition >> name: aName [
	name:= aName
]

{ #category : #converting }
PhaROSConstantDefinition >> rosdefinition [ 
	^ ' {1} {2}={3}' format: { type typeName . name . self valueForGeneration }.
]

{ #category : #accessing }
PhaROSConstantDefinition >> type: aPhaROSType [
	type := aPhaROSType
]

{ #category : #accessing }
PhaROSConstantDefinition >> value: aValue [
	value:= aValue.
]

{ #category : #converting }
PhaROSConstantDefinition >> valueForGeneration [
	^ (type isKindOf: PhaROSStringType ) ifTrue: [ '''{1}''' format: { value asString } ] ifFalse: [ value asString ].
]
