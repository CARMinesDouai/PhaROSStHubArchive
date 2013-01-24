Class {
	#name : #PureWorkQueue,
	#superclass : #Object,
	#instVars : [
		'queue',
		'mutex',
		'workAvailability',
		'waitTimeout'
	],
	#category : #'Pure-Kernel'
}

{ #category : #'as yet unclassified' }
PureWorkQueue >> add: aWork [
	| realWork |
	realWork := aWork asWork.
	
	mutex critical: [
		queue add: realWork.	
	].

	workAvailability signal.
	
	^ realWork.
]

{ #category : #'as yet unclassified' }
PureWorkQueue >> initialize [ 
	queue := OrderedCollection new.
	mutex := Mutex new.
	workAvailability := Semaphore new.
	waitTimeout := 5000.
]

{ #category : #'as yet unclassified' }
PureWorkQueue >> next [
	^ self nextIfTimeOut: [ self next ].
]

{ #category : #'as yet unclassified' }
PureWorkQueue >> nextIfTimeOut: aBlock [
	^ (workAvailability waitTimeoutMSecs: waitTimeout) ifTrue: aBlock ifFalse: [ self peek  ].
]

{ #category : #'as yet unclassified' }
PureWorkQueue >> peek [
	^ self peekIfNothing: [
		self error: 'There is not work available.'.
	 ].
]

{ #category : #'as yet unclassified' }
PureWorkQueue >> peekIfNothing: aBlock [
	| work theresWork |
	
	theresWork := false. 
	
	mutex critical: [
		queue size > 0 ifTrue:	[
			work := queue at:1. 
			queue remove: work.	
			theresWork := true.		
		] 
	].

	^ theresWork ifFalse: aBlock ifTrue: [ work ]. 
]

{ #category : #'as yet unclassified' }
PureWorkQueue >> waitTimeoutInMSeconds: anAmountOfMSeconds [
	waitTimeout  := anAmountOfMSeconds
]

{ #category : #'as yet unclassified' }
PureWorkQueue >> waitTimeoutInSeconds: anAmountOfSeconds [
	waitTimeout  := anAmountOfSeconds * 1000.
]
