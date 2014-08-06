"
I am a grid element.  I have a content that can be any visitable object (i.e. responding to acceptVisitor:)

Subclasses are likely to override
-acceptVisitor: someVisitor
"
Class {
	#name : #BGSCell,
	#superclass : #Object,
	#instVars : [
		'content',
		'grid',
		'position',
		'color'
	],
	#category : #'BOSS-Kernel'
}

{ #category : #'instance creation' }
BGSCell class >> at: aPoint in: aGrid [
	^self new
		grid: aGrid;
		position: aPoint
		yourself
]

{ #category : #'instance creation' }
BGSCell class >> wallAt: aPoint in: aGrid [
	^(self at: aPoint in: aGrid)
		wall;
		yourself
]

{ #category : #visiting }
BGSCell >> acceptContentVisitor: aVisitor [
	self isEmpty
		ifTrue: [ ^ self ].
	self content acceptVisitor: aVisitor
]

{ #category : #visiting }
BGSCell >> acceptVisitor: aVisitor [
	aVisitor visitCell: self.
	self acceptContentVisitor: aVisitor
]

{ #category : #accessing }
BGSCell >> color [
	^ color
]

{ #category : #accessing }
BGSCell >> color: anObject [
	color := anObject
]

{ #category : #'content handling' }
BGSCell >> content [
	^ content
]

{ #category : #'content handling' }
BGSCell >> content: anObject [
	content := anObject.
	self updateCellOf: anObject
]

{ #category : #'initialize-release' }
BGSCell >> defaultColor [
	^ Color white
]

{ #category : #'content handling' }
BGSCell >> empty [
	self content: nil
]

{ #category : #accessing }
BGSCell >> grid [
	^ grid
]

{ #category : #accessing }
BGSCell >> grid: anObject [
	grid := anObject
]

{ #category : #'initialize-release' }
BGSCell >> initialize [ 
	super initialize.
	self color: self defaultColor
]

{ #category : #testing }
BGSCell >> isEmpty [
	^self content isNil
]

{ #category : #accessing }
BGSCell >> position [
	^ position
]

{ #category : #accessing }
BGSCell >> position: anObject [
	position := anObject
]

{ #category : #printing }
BGSCell >> printOn: aStream [
	aStream nextPutAll: 'aCell at'.
	self position printOn: aStream.
	aStream nextPutAll: '. '.
	self isEmpty
		ifTrue: [ ^ aStream nextPutAll: #empty ].
	self content printOn: aStream
]

{ #category : #'content handling' }
BGSCell >> updateCellOf: anObject [
	anObject ifNotNil: [ anObject cell: self ]
]

{ #category : #'content handling' }
BGSCell >> wall [
	self content: self wallClass new
]

{ #category : #'content handling' }
BGSCell >> wallClass [
	^BGSWall
]
