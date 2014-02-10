Class {
	#name : #PhaROSFieldDefinition,
	#superclass : #PhaROSItemDefinition,
	#category : #'PhaROS-Types-DSL'
}

{ #category : #'instance creation' }
PhaROSFieldDefinition class >> named: aName type: aPhaROSType [ 
	^ self new name: aName; type: aPhaROSType ; yourself
]

{ #category : #converting }
PhaROSFieldDefinition >> getter [ 
	^ ('{1}' , String crlf, String tab, '^ self getAt: #{1}. ', String crlf) translated format: { name}
]

{ #category : #converting }
PhaROSFieldDefinition >> hasToInstallHelper [
	^ type isCollection
]

{ #category : #converting }
PhaROSFieldDefinition >> helper [
	^ ('add{1}: aValue' , String crlf, String tab, '^ self {2} add: aValue. ', String crlf ) translated format: { (name capitalized copyFrom:1 to: name size -1 ) . name } 
]

{ #category : #converting }
PhaROSFieldDefinition >> initializer [
	^  (String tab, ' self {1}: {2}. ', String crlf) translated format: { name . type defaultValueString }
]

{ #category : #testing }
PhaROSFieldDefinition >> isField [
	^ true
]

{ #category : #converting }
PhaROSFieldDefinition >> rosdefinition [ 
	^ ' {1} {2}' format: { type typeName . name  }.
]

{ #category : #converting }
PhaROSFieldDefinition >> setter [
	^ ('{1}: aValue' , String crlf, String tab, '^ self at: #{1} put: aValue. ', String crlf ) translated format: { name }
]
