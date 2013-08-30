Class {
	#name : #PureROSBaseLandmarkEvent,
	#superclass : #SGStargazerEventManager,
	#category : #'PureROS-Nodelets'
}

{ #category : #'as yet unclassified' }
PureROSBaseLandmarkEvent >> configure [
	self nodelets stargazer absoluteLandmarks  for: [ :lmk | self check: lmk ]
	
]
