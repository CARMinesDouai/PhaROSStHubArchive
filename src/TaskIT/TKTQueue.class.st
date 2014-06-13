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

{ #category : #adding }
TKTQueue >> add: anObject [
	
	queue add: anObject.	
	workAvailability signal.
	
	^ anObject.
]

{ #category : #converting }
TKTQueue >> asOrderedCollection [

	^ queue get asOrderedCollection
]

{ #category : #accessing }
TKTQueue >> collect: aBlock [

	^ queue collect: aBlock
]

{ #category : #'initialize-release' }
TKTQueue >> initialize [ 
	queue := TKTExclusiveAccessVariable initialValue: (OrderedCollection new).
	workAvailability := Semaphore new.
	timeout := 5000.
]

{ #category : #accessing }
TKTQueue >> next [
	^ self nextIfTimeOut: [ self next ].
]

{ #category : #accessing }
TKTQueue >> nextIfTimeOut: aBlock [
	^ (workAvailability waitTimeoutMSecs: timeout ) ifTrue: aBlock ifFalse: [ self peek  ].
]

{ #category : #accessing }
TKTQueue >> peek [
	^ self peekIfNothing: [
		^ nil.
	 ].
]

{ #category : #accessing }
TKTQueue >> peekAll [
	| ord current |
	
	ord := OrderedCollection new.
	
	[ (current := self peek) notNil ] whileTrue: [ ord addFirst: current ].

	^ ord.
]

{ #category : #accessing }
TKTQueue >> peekIfNothing: aBlock [
	| work theresWork |
	
	theresWork := false. 

	queue get size > 0 ifTrue:	[
		work := queue get removeFirst. 
		theresWork := true.	
	].

	^ theresWork ifFalse: aBlock ifTrue: [ work ]. 
]

{ #category : #accessing }
TKTQueue >> size [
	^ queue get size.
]

{ #category : #accessing }
TKTQueue >> timeout [
	^ timeout
]

{ #category : #accessing }
TKTQueue >> timeout: aTimeout [
	"Millseconds"
	timeout := aTimeout.
]
