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
	self events do: [ : e |[ e apply: aLandmark] on: Error do: [ : er |self halt.] ].
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
	events remove: anEvent ifAbsent: [].
]

{ #category : #'as yet unclassified' }
SGStargazerEventManager >> rescheddule: anEvent [
	events add: anEvent.
]

{ #category : #'as yet unclassified' }
SGStargazerEventManager >> whenLandmark: aConditionBlock do: anActionBlock [
	^ self events add: (SGStargazerEvent new manager: self; condition: aConditionBlock; action: anActionBlock; yourself).
]

{ #category : #'as yet unclassified' }
SGStargazerEventManager >> whenLandmark: aConditionBlock doOnce: anActionBlock [
	^ self events add: (SGOneTimeStargazerEvent new manager: self; condition: aConditionBlock; action: anActionBlock; yourself).
]
