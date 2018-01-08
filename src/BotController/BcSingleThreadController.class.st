Class {
	#name : #BcSingleThreadController,
	#superclass : #BcController,
	#instVars : [
		'thread'
	],
	#category : #'BotController-Controllers'
}

{ #category : #living }
BcSingleThreadController >> act [
	^self
]

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
		every: self defaultInterStepDuration.
	thread priority: self defaultPriority.
]

{ #category : #living }
BcSingleThreadController >> plan [
	^self
]

{ #category : #living }
BcSingleThreadController >> sense [
	^self
]

{ #category : #living }
BcSingleThreadController >> start [
	super start.
	thread start
]

{ #category : #living }
BcSingleThreadController >> step [
	self sense.
	self plan.
	self act.
]

{ #category : #living }
BcSingleThreadController >> stop [
	super stop.
	thread stop
]
