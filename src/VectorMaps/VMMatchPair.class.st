"
This class stores to points that have been matched as corresponding points of two point collections. 



Public API and Key Messages

- squaredDistance
	returns the squared distance between the two points. used to compute the matching score at the VMICP object


"
Class {
	#name : #VMMatchPair,
	#superclass : #Array,
	#type : #variable,
	#category : #'VectorMaps-SLAM - ICP'
}

{ #category : #'as yet unclassified' }
VMMatchPair class >> pointA: pA pointB: pB [
	^(self new: 2)
		at: 1 put: pA;
		at: 2 put: pB;
		yourself.
]

{ #category : #'as yet unclassified' }
VMMatchPair >> squaredDistance [
	^(self at:1) squaredDistanceTo: (self at: 2).
]
