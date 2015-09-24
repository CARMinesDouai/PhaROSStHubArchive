Class {
	#name : #RrMultiVectorsDisplayController,
	#superclass : #RrSingleVectorDisplayController,
	#category : #'ReactiveRobot-00-SensorViewer'
}

{ #category : #acting }
RrMultiVectorsDisplayController >> draw: vectors [
	self display erase.
	vectors do: [ :each | 
		self display draw: each
	]
]
