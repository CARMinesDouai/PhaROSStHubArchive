Class {
	#name : #TKTResult,
	#superclass : #TKTFuture,
	#instVars : [
		'mutex'
	],
	#category : #'TaskIT-Kernel'
}

{ #category : #'as yet unclassified' }
TKTResult >> deployResult: aResult [
	super deployResult: aResult.
	self become: aResult.
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
