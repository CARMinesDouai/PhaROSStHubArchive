Class {
	#name : #TKTWitness,
	#superclass : #Object,
	#instVars : [
		'target'
	],
	#category : #'TaskIT-Sugar'
}

{ #category : #'as yet unclassified' }
TKTWitness class >> cleanup: aTarget [

	aTarget finalize.
]

{ #category : #'as yet unclassified' }
TKTWitness class >> for: aTarget [
	^ self new target: aTarget; yourself.
]

{ #category : #accessing }
TKTWitness >> target: aTarget [
	self toFinalizeSend: #cleanup: to: TKTWitness with: aTarget .
	
]
