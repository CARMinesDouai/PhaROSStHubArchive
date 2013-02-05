Class {
	#name : #TKTResult,
	#superclass : #ProtoObject,
	#instVars : [
		'future'
	],
	#category : #'TaskIT-Kernel'
}

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
