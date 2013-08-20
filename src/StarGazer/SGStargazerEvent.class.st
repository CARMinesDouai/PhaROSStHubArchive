Class {
	#name : #SGStargazerEvent,
	#superclass : #Object,
	#instVars : [
		'condition',
		'action',
		'manager'
	],
	#category : #'StarGazer-Ros'
}

{ #category : #'as yet unclassified' }
SGStargazerEvent >> action: anActionBlock [ 	
	action  := anActionBlock.
]

{ #category : #'as yet unclassified' }
SGStargazerEvent >> apply: aLandmark [
	(condition value: aLandmark ) ifTrue: [
		self executeAction: aLandmark.
		
	].

]

{ #category : #'as yet unclassified' }
SGStargazerEvent >> cancel [ 
	manager remove: self.
	condition := [ :lmk | false ]. 
]

{ #category : #'as yet unclassified' }
SGStargazerEvent >> condition: aConditionBlock [
	condition := aConditionBlock 
]

{ #category : #'as yet unclassified' }
SGStargazerEvent >> executeAction: aLandmark [ 
	action cull: aLandmark.	
]

{ #category : #'as yet unclassified' }
SGStargazerEvent >> manager: aSGStargazerEventManager [
	manager := aSGStargazerEventManager 
]
