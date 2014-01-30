"
A lazy result is an object that represents, almost transparently, the value of the task execution. This lazy result will become into the value of the result once it is available, or under demand (for example, when a message is sent to it). Lazy results support a style of programming that ressembles the synchronous style, while performing asynchronous if the result is not used. 

[[[
future := [ employee computeBaseSallary ] shootIt.
result := future asResult.

subTotal := employee sumSallaryComponents

result + subTotal
]]]

Note: Lazy results are to be used with care. They use Pharo's ==become:== facility, and so, it will freeze the system to update object references.

Lazy results can be used to easily synchronize tasks. One task running in paralell with another one and waiting for it to finish can use a lazy result object to perform transparently as much work as it can in paralell. Only when the result object is sent a message the 

[[[
future := [ employee computeBaseSallary ] shootIt.
baseSallary := future asResult.

[ employee sumSallaryComponents + baseSallary ] shootIt value.
]]]
"
Class {
	#name : #TKTLazyResult,
	#superclass : #Object,
	#instVars : [
		'future',
		'cancelled'
	],
	#category : #'TaskIT-Kernel'
}

{ #category : #'instance creation' }
TKTLazyResult class >> for: aFuture [
	^ self new
		setFuture: aFuture;
		yourself
]

{ #category : #forwarding }
TKTLazyResult >> = other [ 	
	^ self perform: #= withArguments: {other}.
]

{ #category : #forwarding }
TKTLazyResult >> asString [ 	
	^ self perform: #asString.
]

{ #category : #forwarding }
TKTLazyResult >> at: anId [
	^ self perform: #at: withArguments: { anId }.
]

{ #category : #evaluating }
TKTLazyResult >> cancel [
	cancelled := true.
	^ future cancel.
]

{ #category : #private }
TKTLazyResult >> deployValue:  aValue [
	| realValue |

	realValue := (aValue class = SmallInteger) ifTrue: [ aValue asFloat ] ifFalse: [ aValue ]. 	
	
	self becomeForward: realValue.

]

{ #category : #'message handling' }
TKTLazyResult >> doesNotUnderstand: aMessage [
	
	cancelled ifTrue: [
		Error signal: 'The process was cancelled'.
	].

	^ self perform: aMessage selector withArguments: aMessage arguments.
	
]

{ #category : #finalization }
TKTLazyResult >> finalize [ 
	future finalize.

]

{ #category : #'initialize-release' }
TKTLazyResult >> initialize [
	super initialize.
	cancelled := false.
	future := TKTExclusiveAccessVariable initialValue: nil.
]

{ #category : #forwarding }
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

{ #category : #'initialize-release' }
TKTLazyResult >> setFuture: aFuture [
	aFuture onSuccess: [ :aValue | self deployValue: aValue ].
	future set: aFuture
]

{ #category : #forwarding }
TKTLazyResult >> size [ 	
	^ self perform: #size.
]

{ #category : #forwarding }
TKTLazyResult >> value [ 	
	^ self perform: #value.
]
