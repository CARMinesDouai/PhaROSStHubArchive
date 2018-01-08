Class {
	#name : #BcSingleThreadController,
	#superclass : #BcController,
	#instVars : [
		'thread'
	],
	#category : #'BotController-Controllers'
}

{ #category : #initialization }
BcSingleThreadController >> defaultInterStepDuration [
	^100 milliSeconds
]

{ #category : #initialization }
BcSingleThreadController >> defaultPriority [
	^Processor userSchedulingPriority 
]

{ #category : #initialization }
BcSingleThreadController >> initialize [
	super initialize.
	thread := ActiveObject 
		repeat: [ self step ] 
		every: self defaultInterStepDuration
		ensure: [self stop].
	thread priority: self defaultPriority.
]

{ #category : #living }
BcSingleThreadController >> start [
	super start.
	thread start
]
