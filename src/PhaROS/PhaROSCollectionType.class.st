"
A PhaROSCollectionType is an abstract representation of collections type
"
Class {
	#name : #PhaROSCollectionType,
	#superclass : #PhaROSType,
	#instVars : [
		'relatedClass',
		'relatedType'
	],
	#category : #'PhaROS-Types-Basic'
}

{ #category : #'pseudo-dsl' }
PhaROSCollectionType class >> registerAlterName [
	" This is an abstract class. Does not apply "
	self = PhaROSCollectionType ifFalse: [ 
		super registerAlterName.
	 ]
]

{ #category : #'as yet unclassified' }
PhaROSCollectionType >> dataTypeSizeFor: aValue [
self flag: #cambiarEstooo. " "

	(self isAPossibleValue: aValue ) ifFalse: [
		PhaROSUnexpextedValue signal: 'Unexpected value'.
	].
	
	^(aValue inject: 0 into:[
		:acc :val | 
		acc + (self  relatedType dataTypeSizeFor: val ).
	]).
]

{ #category : #'as yet unclassified' }
PhaROSCollectionType >> decode: aDecoder [ 
	^ (1 to: (self sizeFor: aDecoder ) ) collect: [
		:i |
		self relatedType decode: aDecoder.
	] .
]

{ #category : #'as yet unclassified' }
PhaROSCollectionType >> isAPossibleSize: aSize [
	^ aSize > 0.
]

{ #category : #'as yet unclassified' }
PhaROSCollectionType >> isAPossibleValue: aValue [
	^( aValue isKindOf: Collection ) and: [
		aValue allSatisfy: [
			:val |
			self relatedType isAPossibleValue: val.
		]	
	].
]

{ #category : #'as yet unclassified' }
PhaROSCollectionType >> isCollectionType [
	^ true
]

{ #category : #'as yet unclassified' }
PhaROSCollectionType >> ofClass: aRosTypeClass [
	relatedClass := aRosTypeClass.
]

{ #category : #'as yet unclassified' }
PhaROSCollectionType >> ofType: aRosType [
	relatedType  := aRosType.
	relatedClass := aRosType class.
]

{ #category : #'as yet unclassified' }
PhaROSCollectionType >> relatedType [
	^ relatedType ifNil: [ relatedType := relatedClass new ].
]

{ #category : #'as yet unclassified' }
PhaROSCollectionType >> relatedType: aType [
	relatedType := aType.
	relatedClass := aType class.
	
]

{ #category : #'as yet unclassified' }
PhaROSCollectionType >> setEncodeDecodeSelectors [
	" Refactor needed here ."
	encodeSelector := #doesNotApplyHere.
	decodeSelector := #doesNotApplyHere.
]

{ #category : #'as yet unclassified' }
PhaROSCollectionType >> sizeFor: aDecoder [ 
	^ self subclassResponsibility.
]
