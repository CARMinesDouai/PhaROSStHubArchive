Class {
	#name : #StarGazer,
	#superclass : #Object,
	#instVars : [
		'port',
		'lastKnownPosition',
		'polling'
	],
	#category : #'StarGazer-Kernel'
}

{ #category : #'as yet unclassified' }
StarGazer class >> atPort: aPort [
	^ self new port: aPort; yourself.
]

{ #category : #'as yet unclassified' }
StarGazer class >> atPortId: aPortId [
	^ self atPort:  (SGPort atPortId: aPortId).
]

{ #category : #'as yet unclassified' }
StarGazer class >> default [
	^ self atPortId: SGPort defaultPortID.
]

{ #category : #accessing }
StarGazer >> finallize [
	polling ifNotNil: [ polling cancel ].
]

{ #category : #accessing }
StarGazer >> lastKnownPosition [

	^ lastKnownPosition.
]

{ #category : #accessing }
StarGazer >> poll [
	| message |
	[ 
		message := port nextMessage. 
		message apply: self. 
	] repeat.
]

{ #category : #accessing }
StarGazer >> port: aSGPort [

	port ifNil: [
		polling cancel.
	].

	port := aSGPort asThreadsafeReference.
	polling := self parallelize poll. 

]
