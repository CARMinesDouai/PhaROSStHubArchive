"
This collection is derived from an OrderedCollection. It stores VMMatchPair objects, which are pairs of point-like objects that are deemed corresponding with each other by the ICP algorithm.

- squaredError
		computes the square error, which is the sum over the squared euclidean distance between the corresponding points.
- asMatchCollection
		returns self

"
Class {
	#name : #VMMatchCollection,
	#superclass : #OrderedCollection,
	#category : #'VectorMaps-SLAM - ICP'
}

{ #category : #'as yet unclassified' }
VMMatchCollection >> asMatchCollection [
	^self
]

{ #category : #'as yet unclassified' }
VMMatchCollection >> squaredError [
	| errorSum |
	
	errorSum := 0.
	
	self do: [ :match |
		match outlier ifFalse: [
			errorSum := errorSum + (match squaredDistance).
		].
	].
	
	^errorSum.

]
