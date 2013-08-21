Class {
	#name : #SGStargazerEventManager,
	#superclass : #PhaROSStaticNodelet,
	#instVars : [
		'events'
	],
	#category : #'StarGazer-Ros'
}

{ #category : #'as yet unclassified' }
SGStargazerEventManager >> check: aLandmark [
	self halt.
	self events do: [ : e | e apply: aLandmark ].
]

{ #category : #'as yet unclassified' }
SGStargazerEventManager >> configure [
	self nodelets stargazer landmarks for: [ :lmk | self check: lmk ]
	
]

{ #category : #'as yet unclassified' }
SGStargazerEventManager >> events [ 
	^ events
]

{ #category : #'as yet unclassified' }
SGStargazerEventManager >> initialize [
	events := Set new.
]

{ #category : #'as yet unclassified' }
SGStargazerEventManager >> remove: anEvent [
	events remove: anEvent.
]

{ #category : #'as yet unclassified' }
SGStargazerEventManager >> whenLandmark: aConditionBlock do: anActionBlock [
	^ self events add: (SGStargazerEvent new manager: self; condition: aConditionBlock; action: anActionBlock; yourself).
]

{ #category : #'as yet unclassified' }
SGStargazerEventManager >> whenLandmark: aConditionBlock doOnce: anActionBlock [
	^ self events add: (SGOneTimeStargazerEvent new manager: self; condition: aConditionBlock; action: anActionBlock; yourself).
]
