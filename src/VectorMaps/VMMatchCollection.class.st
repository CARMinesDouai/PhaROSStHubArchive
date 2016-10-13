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
		errorSum := errorSum + (match squaredDistance).
	].
	
	^errorSum.

]
