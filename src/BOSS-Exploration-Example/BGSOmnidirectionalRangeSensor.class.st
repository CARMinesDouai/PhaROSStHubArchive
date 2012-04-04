"
I am a sensor that detects obstacles in a disk around my position. The radius of the disk is my range + 1 (for my position).
"
Class {
	#name : #BGSOmnidirectionalRangeSensor,
	#superclass : #BGSBodyPart,
	#category : #'BOSS-BodyParts'
}

{ #category : #visiting }
BGSOmnidirectionalRangeSensor >> acceptVisitor: aVisitor [
	aVisitor visitOmnidirectionalRangeSensor: self
]

{ #category : #sensing }
BGSOmnidirectionalRangeSensor >> emptySensedPositions [
	^self sensedPositions select: [:position|
		self terrain isEmptyCellAt: position]

]

{ #category : #sensing }
BGSOmnidirectionalRangeSensor >> obstacleSensedPositions [
	^self sensedPositions reject: [:position|
		self terrain isEmptyCellAt: position]

]

{ #category : #sensing }
BGSOmnidirectionalRangeSensor >> sensedPositions [
	^self terrain positionsAround: self position
]
