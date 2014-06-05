"
actor1 := ATActor for: PingActorWithoutCompiler.
actor2 := ATActor for: PingActorWithoutCompiler .

actor1 ping: actor2.

(Delay forMilliseconds: 17) wait.
actor1 suspend.

actor1 resume.
(Delay forMilliseconds: 35) wait.
actor1 suspend.

actor1 stop.
actor2 stop.
"
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

	anActor pingFrom: ATCurrentActor value
]

{ #category : #'as yet unclassified' }
PingActorWithoutCompiler >> pingFrom: anotherPingActor [

	times := times + 1.
	times < 100 ifTrue: [ 
		times logCr.
		self ping: anotherPingActor ]
]
