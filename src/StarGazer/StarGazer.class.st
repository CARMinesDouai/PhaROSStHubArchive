Class {
	#name : #StarGazer,
	#superclass : #Object,
	#instVars : [
		'port',
		'lastKnownPosition'
	],
	#category : #'StarGazer-Kernel'
}

{ #category : #'as yet unclassified' }
StarGazer class >> atPort: aPortId [
	^ self new port: (SGPort atPortId: aPortId); yourself.
]

{ #category : #'as yet unclassified' }
StarGazer class >> default [
	^ self atPort: SGPort defaultPortID.
]

{ #category : #accessing }
StarGazer >> lastKnownPosition [

	^ lastKnownPosition.
]

{ #category : #accessing }
StarGazer >> port: aSGPort [
	port := aSGPort
]
