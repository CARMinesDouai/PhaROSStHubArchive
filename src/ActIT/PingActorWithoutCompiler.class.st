Class {
	#name : #PingActorWithoutCompiler,
	#superclass : #Object,
	#traits : 'TATActor',
	#classTraits : 'TATActor classTrait',
	#instVars : [
		'times'
	],
	#category : #'ActIT-Examples'
}

{ #category : #'as yet unclassified' }
PingActorWithoutCompiler >> initialize [

	super initialize.
	times := 0.
]

{ #category : #'as yet unclassified' }
PingActorWithoutCompiler >> ping: anActor [

	anActor send: #pingFrom: with: ATCurrentActor value
]

{ #category : #'as yet unclassified' }
PingActorWithoutCompiler >> pingFrom: anotherPingActor [

	times := times + 1.
	times < 100 ifTrue: [ 
		times logCr.
		self ping: anotherPingActor ]
]
