Class {
	#name : #PureROSBaseLandmarkEvent,
	#superclass : #SGStargazerEventManager,
	#category : #'PureROS-Nodelets'
}

{ #category : #'as yet unclassified' }
PureROSBaseLandmarkEvent >> configure [
	self nodelets navigator baseLandmarks for: [ :lmk | self check: lmk ]
	
]
