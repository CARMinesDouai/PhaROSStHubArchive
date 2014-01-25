Class {
	#name : #TKTLazyResult,
	#superclass : #Object,
	#instVars : [
		'future',
		'cancelled'
	],
	#category : #'TaskIT-Kernel'
}

{ #category : #'as yet unclassified' }
TKTLazyResult class >> for: aFuture [
	^ self new future: aFuture ; yourself.
]

{ #category : #comparing }
TKTLazyResult >> = other [ 	
	^ self perform: #= withArguments: {other}.
]

{ #category : #converting }
TKTLazyResult >> asString [ 	
	^ self perform: #asString.
]

{ #category : #accessing }
TKTLazyResult >> at: anId [
	^ self perform: #at: withArguments: { anId }.
]

{ #category : #actions }
TKTLazyResult >> cancel [
	cancelled := true.
	^ future cancel.
]

{ #category : #'execution-finished' }
TKTLazyResult >> deployValue:  aValue [
	| realValue |

	realValue := (aValue class = SmallInteger) ifTrue: [ aValue asFloat ] ifFalse: [ aValue ]. 	
	
	self becomeForward: realValue.

]

{ #category : #'error handling' }
TKTLazyResult >> doesNotUnderstand: aMessage [
	
	cancelled ifTrue: [
		Error signal: 'The process was cancelled'.
	].

	^ self  perform: aMessage selector withArguments: aMessage arguments.
	
]

{ #category : #finalization }
TKTLazyResult >> finalize [ 
	future finalize.

]

{ #category : #accessing }
TKTLazyResult >> future: aFuture [
	aFuture whenFinished: [ :aValue | self deployValue: aValue ].
	future set: aFuture
]

{ #category : #'initialize-release' }
TKTLazyResult >> initialize [
	super initialize.
	cancelled := false.
	future := TKTExclusiveAccessVariable initialValue: nil.
]

{ #category : #'class membership' }
TKTLazyResult >> isKindOf: aClass [
	^ self perform: #isKindOf: withArguments: {aClass}
]

{ #category : #testing }
TKTLazyResult >> isResult [
	^ true
]

{ #category : #'message handling' }
TKTLazyResult >> perform: aSelector [

	^ future do: [ :aFuture | aFuture value perform: aSelector ]
]

{ #category : #'message handling' }
TKTLazyResult >> perform: aSelector withArguments: anArray [
	
	^ future do: [ :aFuture | aFuture value perform: aSelector withArguments: anArray ].
]

{ #category : #accessing }
TKTLazyResult >> size [ 	
	^ self perform: #size.
]

{ #category : #evaluating }
TKTLazyResult >> value [ 	
	^ self perform: #value.
]
