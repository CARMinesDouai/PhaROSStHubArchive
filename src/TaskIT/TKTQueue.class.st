Class {
	#name : #TKTQueue,
	#superclass : #Object,
	#instVars : [
		'queue',
		'workAvailability',
		'timeout'
	],
	#category : #'TaskIT-Channel'
}

{ #category : #'as yet unclassified' }
TKTQueue >> add: anObject [
	
	queue add: anObject.	
	workAvailability signal.
	
	^ anObject.
]

{ #category : #'as yet unclassified' }
TKTQueue >> initialize [ 
	queue := TKTVariable for: (OrderedCollection new).
	workAvailability := Semaphore new.
	timeout := 5000.
]

{ #category : #'as yet unclassified' }
TKTQueue >> next [
	^ self nextIfTimeOut: [ self next ].
]

{ #category : #'as yet unclassified' }
TKTQueue >> nextIfTimeOut: aBlock [
	^ (workAvailability waitTimeoutMSecs: timeout ) ifTrue: aBlock ifFalse: [ self peek  ].
]

{ #category : #'as yet unclassified' }
TKTQueue >> peek [
	^ self peekIfNothing: [
		^ nil.
	 ].
]

{ #category : #'as yet unclassified' }
TKTQueue >> peekAll [
	| ord current |
	
	ord := OrderedCollection new.
	
	[ (current := self peek) notNil ] whileTrue: [ ord add: current ].

	^ ord.
]

{ #category : #'as yet unclassified' }
TKTQueue >> peekIfNothing: aBlock [
	| work theresWork |
	
	theresWork := false. 

	queue get size > 0 ifTrue:	[
		work := queue get removeFirst. 
		theresWork := true.	
	].

	^ theresWork ifFalse: aBlock ifTrue: [ work ]. 
]

{ #category : #'as yet unclassified' }
TKTQueue >> size [
	^ queue get size.
]

{ #category : #accessing }
TKTQueue >> timeout [
	^ timeout
]

{ #category : #'as yet unclassified' }
TKTQueue >> timeout: aTimeout [
	"Millseconds"
	timeout := aTimeout.
]
