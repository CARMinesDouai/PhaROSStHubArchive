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
	| rslt | 
	
	cancelled ifTrue: [
		Error signal: 'The process was cancelled'.
	].
	future apply: [
		: aFuture | 
		rslt := aFuture value perform: aMessage selector withArguments: aMessage arguments.
	].
	
	^ rslt.
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
