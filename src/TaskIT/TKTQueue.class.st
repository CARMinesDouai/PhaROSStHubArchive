Class {
	#name : #TKTQueue,
	#superclass : #Object,
	#instVars : [
		'queue',
		'workAvailability',
		'waitTimeout'
	],
	#category : #'TaskIT-Kernel'
}

{ #category : #'as yet unclassified' }
TKTQueue >> add: aWork [
	| realWork |
	realWork := aWork asWork.
	
	mutex critical: [
		queue add: realWork.	
	].

	workAvailability signal.
	
	^ realWork.
]

{ #category : #'as yet unclassified' }
TKTQueue >> initialize [ 
	queue := TKTVariable for: (OrderedCollection new).
	workAvailability := Monitor new.
	waitTimeout := 5000.
]

{ #category : #'as yet unclassified' }
TKTQueue >> next [
	^ self nextIfTimeOut: [ self next ].
]

{ #category : #'as yet unclassified' }
TKTQueue >> nextIfTimeOut: aBlock [
	^ (workAvailability waitWhile: [ queue get size = 0 ] maxMilliseconds: waitTimeout) ifTrue: aBlock ifFalse: [ self peek  ].
]

{ #category : #'as yet unclassified' }
TKTQueue >> peek [
	^ self peekIfNothing: [
		^ nil.
	 ].
]

{ #category : #'as yet unclassified' }
TKTQueue >> peekIfNothing: aBlock [
	| work theresWork |
	
	theresWork := false. 

	queue get size > 0 ifTrue:	[
		work := queue get at:1. 
		queue get remove: work.	
		theresWork := true.		
	].

	^ theresWork ifFalse: aBlock ifTrue: [ work ]. 
]

{ #category : #'as yet unclassified' }
TKTQueue >> waitTimeoutInMSeconds: anAmountOfMSeconds [
	waitTimeout  := anAmountOfMSeconds
]

{ #category : #'as yet unclassified' }
TKTQueue >> waitTimeoutInSeconds: anAmountOfSeconds [
	waitTimeout  := anAmountOfSeconds * 1000.
]
