Class {
	#name : #RrMultiVectorsDisplayController,
	#superclass : #RrSingleVectorDisplayController,
	#category : #'ReactiveRobot-Demo'
}

{ #category : #acting }
RrMultiVectorsDisplayController >> draw: vectors [
	self display erase.
	vectors do: [ :each | 
		self display draw: each
	]
]
