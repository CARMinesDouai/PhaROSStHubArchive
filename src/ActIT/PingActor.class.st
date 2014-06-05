"
actor1 := ATActor for: PingActor.
actor2 := ATActor for: PingActor.

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
