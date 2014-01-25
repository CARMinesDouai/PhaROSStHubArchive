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

{ #category : #'as yet unclassified' }
TKTLazyResult >> = other [ 	
	^ self perform: #= withArguments: {other}.
]

{ #category : #'as yet unclassified' }
TKTLazyResult >> asString [ 	
	^ self perform: #asString.
]

{ #category : #'as yet unclassified' }
TKTLazyResult >> at: anId [
	^ self perform: #at: withArguments: { anId }.
]

{ #category : #'as yet unclassified' }
TKTLazyResult >> cancel [
	cancelled := true.
	^ future cancel.
]

{ #category : #'as yet unclassified' }
TKTLazyResult >> deployValue:  aValue [
	| realValue |

	realValue := (aValue class = SmallInteger) ifTrue: [ aValue asFloat ] ifFalse: [ aValue ]. 	
	
	self becomeForward: realValue.

]

{ #category : #'as yet unclassified' }
TKTLazyResult >> doesNotUnderstand: aMessage [
	
	cancelled ifTrue: [
		Error signal: 'The process was cancelled'.
	].

	^ self  perform: aMessage selector withArguments: aMessage arguments.
	
]

{ #category : #'as yet unclassified' }
TKTLazyResult >> finalize [ 
	future finalize.

]

{ #category : #'as yet unclassified' }
TKTLazyResult >> future: aFuture [
	aFuture whenFinished: [ :  aValue  |  self deployValue: aValue ].	
	future set: aFuture.
	
]

{ #category : #'as yet unclassified' }
TKTLazyResult >> initialize [ 
	cancelled := false.
	future := TKTExclusiveAccessVariable initialValue: nil.
]

{ #category : #'as yet unclassified' }
TKTLazyResult >> isKindOf: aClass [
	^ self perform: #isKindOf:   withArguments: { aClass }
]

{ #category : #'as yet unclassified' }
TKTLazyResult >> isResult [
	^ true
]

{ #category : #'as yet unclassified' }
TKTLazyResult >> perform: aSelector [ 
		| rslt | 
		future apply: [
			: aFuture | 
			rslt := aFuture value perform: aSelector 
		].
		^ rslt
]

{ #category : #'as yet unclassified' }
TKTLazyResult >> perform: aSelector withArguments: anArray [
		| rslt | 
		future apply: [
			: aFuture | 
			rslt := aFuture value perform: aSelector withArguments: anArray
		].
		^ rslt
]

{ #category : #'as yet unclassified' }
TKTLazyResult >> size [ 	
	^ self perform: #size.
]

{ #category : #'as yet unclassified' }
TKTLazyResult >> value [ 	
	^ self perform: #value.
]
