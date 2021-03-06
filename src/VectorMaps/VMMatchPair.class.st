"
This class stores two points that have been matched as corresponding points of two point collections. 



Public API and Key Messages

- squaredDistance
	returns the squared (euclidean) distance between the two points. used to compute the matching score at the VMICP object
- outlier
	returns a boolean, indicating whether or not this pair is considered an outlier and should be ignored
- outlier: aBoolean
	sets the status of the pair as outlier (true) or inlier (false)
- first
	shorthand for 'at: 1'
- second
	shorthand for 'at: 2'


"
Class {
	#name : #VMMatchPair,
	#superclass : #Array,
	#type : #variable,
	#instVars : [
		'outlier'
	],
	#category : #'VectorMaps-SLAM - ICP'
}

{ #category : #'as yet unclassified' }
VMMatchPair class >> pointA: pA pointB: pB [
	^(self new: 2)
		initialize; "not called automatically, since 'Array new:' calls a primitive and bypasses normal initialization"
		at: 1 put: pA;
		at: 2 put: pB;
		yourself.
]

{ #category : #accessing }
VMMatchPair >> first [
	^self at: 1.
]

{ #category : #initialization }
VMMatchPair >> initialize [
	super initialize.
	outlier := false.
]

{ #category : #accessing }
VMMatchPair >> outlier [
	^outlier.
]

{ #category : #accessing }
VMMatchPair >> outlier: aBoolean [
	outlier := aBoolean.
]

{ #category : #accessing }
VMMatchPair >> second [
	^self at: 2.
]

{ #category : #'as yet unclassified' }
VMMatchPair >> squaredDistance [
	^(self at:1) squaredDistanceTo: (self at: 2).
]
