"
A PhaROSTickingClock class represents a sensor of time. Is a thread that send a tick message to a given object every n hz. 
"
Class {
	#name : #PhaROSTickingClock,
	#superclass : #Object,
	#instVars : [
		'process'
	],
	#category : #'PhaROS-Package'
}

{ #category : #'as yet unclassified' }
PhaROSTickingClock >> finalize [
	process := nil.
]

{ #category : #'as yet unclassified' }
PhaROSTickingClock >> stop [
	process := nil.
]

{ #category : #'as yet unclassified' }
PhaROSTickingClock >> tick: aTickable andSleep: aRate [
	aRate wait.
	aTickable tick.
	
]

{ #category : #'as yet unclassified' }
PhaROSTickingClock >> tickAt: aRate on: aTickable [
	process ifNil: [ process:=( self paralellize looping tick: aTickable andSleep: aRate) asStickyReference ]
]
