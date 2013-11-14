Class {
	#name : #TKTResult,
	#superclass : #Object,
	#instVars : [
		'future',
		'cancelled'
	],
	#category : #'TaskIT-Tasks-Worker'
}

{ #category : #'as yet unclassified' }
TKTResult class >> for: aFuture [
	^ self new future: aFuture ; yourself.
]

{ #category : #'as yet unclassified' }
TKTResult >> = other [ 	
	^ self perform: #= withArguments: {other}.
]

{ #category : #'as yet unclassified' }
TKTResult >> asString [ 	
	^ self perform: #asString.
]

{ #category : #'as yet unclassified' }
TKTResult >> at: anId [
	^ self perform: #at: withArguments: { anId }.
]

{ #category : #'as yet unclassified' }
TKTResult >> cancel [
	cancelled := true.
	^ future cancel.
]

{ #category : #'as yet unclassified' }
TKTResult >> deployValue:  aValue [
	| realValue |

	realValue := (aValue class = SmallInteger) ifTrue: [ aValue asFloat ] ifFalse: [ aValue ]. 	
	
	self becomeForward: realValue.

]

{ #category : #'as yet unclassified' }
TKTResult >> doesNotUnderstand: aMessage [
	
	cancelled ifTrue: [
		Error signal: 'The process was cancelled'.
	].

	^ self  perform: aMessage selector withArguments: aMessage arguments.
	
]

{ #category : #'as yet unclassified' }
TKTResult >> finalize [ 
	future finalize.

]

{ #category : #'as yet unclassified' }
TKTResult >> future: aFuture [
	aFuture whenFinished: [ :  aValue  |  self deployValue: aValue ].	
	future set: aFuture.
	
]

{ #category : #'as yet unclassified' }
TKTResult >> initialize [ 
	cancelled := false.
	future := TKTVariable for: nil.
]

{ #category : #'as yet unclassified' }
TKTResult >> isKindOf: aClass [
	^ self perform: #isKindOf:   withArguments: { aClass }
]

{ #category : #'as yet unclassified' }
TKTResult >> isResult [
	^ true
]

{ #category : #'as yet unclassified' }
TKTResult >> perform: aSelector [ 
		| rslt | 
		future apply: [
			: aFuture | 
			rslt := aFuture value perform: aSelector 
		].
		^ rslt
]

{ #category : #'as yet unclassified' }
TKTResult >> perform: aSelector withArguments: anArray [
		| rslt | 
		future apply: [
			: aFuture | 
			rslt := aFuture value perform: aSelector withArguments: anArray
		].
		^ rslt
]

{ #category : #'as yet unclassified' }
TKTResult >> size [ 	
	^ self perform: #size.
]

{ #category : #'as yet unclassified' }
TKTResult >> value [ 	
	^ self perform: #value.
]
