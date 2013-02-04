Class {
	#name : #TKTResult,
	#superclass : #TKTFuture,
	#instVars : [
		'mutex'
	],
	#category : #'TaskIT-Kernel'
}

{ #category : #'as yet unclassified' }
TKTResult >> deployValue:  aValue [
	super deployValue:  aValue.
	self become: aValue.
]

{ #category : #'as yet unclassified' }
TKTResult >> doesNotUnderstand: aMessage [
	| rslt | 
	
	mutex critical: [
		rslt := self value perform: aMessage selector withArguments: aMessage arguments.
	].
	
	^ rslt.
]

{ #category : #'as yet unclassified' }
TKTResult >> initialize [ 
	super initialize .
	mutex := Mutex new.
]
