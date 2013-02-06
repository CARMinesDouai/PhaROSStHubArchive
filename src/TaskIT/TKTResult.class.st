Class {
	#name : #TKTResult,
	#superclass : #Object,
	#instVars : [
		'future'
	],
	#category : #'TaskIT-Worker'
}

{ #category : #'as yet unclassified' }
TKTResult class >> for: aFuture [
	^ self new future: aFuture ; yourself.
]

{ #category : #'as yet unclassified' }
TKTResult >> deployValue:  aValue [
	| realValue |
	
	realValue := (aValue class = SmallInteger) ifTrue: [ aValue asFloat ] ifFalse: [ aValue ]. 	
	self becomeForward: realValue.

]

{ #category : #'as yet unclassified' }
TKTResult >> doesNotUnderstand: aMessage [
	| rslt | 
	
	future apply: [
		: aFuture | 
		rslt := aFuture value perform: aMessage selector withArguments: aMessage arguments.
	].
	
	^ rslt.
]

{ #category : #'as yet unclassified' }
TKTResult >> future: aFuture [
	aFuture whenFinished: [ :  aValue  |  self deployValue: aValue ].	
	future set: aFuture.
	
]

{ #category : #'as yet unclassified' }
TKTResult >> initialize [ 
	future := TKTVariable for: nil.
]
