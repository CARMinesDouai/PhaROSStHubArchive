Class {
	#name : #SGOneTimeStargazerEvent,
	#superclass : #SGStargazerEvent,
	#category : #'StarGazer-Ros'
}

{ #category : #'as yet unclassified' }
SGOneTimeStargazerEvent >> executeAction: aLandmark [ 
	super executeAction: aLandmark.
	manager remove: self.
]
