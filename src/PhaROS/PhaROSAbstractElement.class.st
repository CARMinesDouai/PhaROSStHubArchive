Class {
	#name : #PhaROSAbstractElement,
	#superclass : #Object,
	#instVars : [
		'properties'
	],
	#category : #'PhaROS-Launch'
}

{ #category : #'as yet unclassified' }
PhaROSAbstractElement >> at: aPropertyName put: aValue [ 
	self properties at: aPropertyName put: aValue.
]

{ #category : #'as yet unclassified' }
PhaROSAbstractElement >> at: aPropertyName put: aValue checking: aBlock [
	self assert: (aBlock cull: aValue cull: aPropertyName cull: self ).
	self at: aPropertyName put: aValue.
]

{ #category : #'as yet unclassified' }
PhaROSAbstractElement >> at: aPropertyName put: aValue ofType: aType [
	^ self at: aPropertyName put: aValue checking: [: val | val isKindOf: aType].
]

{ #category : #'as yet unclassified' }
PhaROSAbstractElement >> initialize [ 
	properties := Dictionary new.
]

{ #category : #'as yet unclassified' }
PhaROSAbstractElement >> nodeName [
	self subclassResponsibility .
]

{ #category : #'as yet unclassified' }
PhaROSAbstractElement >> properties [ 
	^ properties
]

{ #category : #'as yet unclassified' }
PhaROSAbstractElement >> xml [
	^ self xmlHeader,self xmlBody,  self xmlTail.
]

{ #category : #'as yet unclassified' }
PhaROSAbstractElement >> xmlBody [ 
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
PhaROSAbstractElement >> xmlHeader [
	^( properties keys inject:( '<{1} ' format: {self nodeName} ) into: [ :acc :prop | acc,  prop asString, '="', (properties at: prop) asString, '" ' ]), '>', String crlf.
]

{ #category : #'as yet unclassified' }
PhaROSAbstractElement >> xmlTail [
	^  ('</{1}>' format: {self nodeName}), String crlf.
]
