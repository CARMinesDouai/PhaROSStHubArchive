Class {
	#name : #PingActor,
	#superclass : #Object,
	#traits : 'TATActor',
	#classTraits : 'TATActor classTrait',
	#instVars : [
		'times'
	],
	#category : #'ActIT-Examples'
}

{ #category : #'as yet unclassified' }
PingActor >> initialize [

	super initialize.
	times := 0.
]

{ #category : #'as yet unclassified' }
PingActor >> ping: anActor [

	anActor pingFrom: self.
]

{ #category : #'as yet unclassified' }
PingActor >> pingFrom: anotherPingActor [

	times := times + 1.
	times < 100 ifTrue: [ 
		times logCr.
		self ping: anotherPingActor ]
]
