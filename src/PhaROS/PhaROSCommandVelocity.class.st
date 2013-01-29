Class {
	#name : #PhaROSCommandVelocity,
	#superclass : #PhaROSValue,
	#category : #'PhaROS-Types'
}

{ #category : #'as yet unclassified' }
PhaROSCommandVelocity >> linear [
	^ self getAt: #linear.
]

{ #category : #'as yet unclassified' }
PhaROSCommandVelocity >> linear:  aValue [
	self at:#linear put: aValue
]
