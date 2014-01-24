Class {
	#name : #TKTRunner,
	#superclass : #Object,
	#category : #'TaskIT-Kernel'
}

{ #category : #cancelling }
TKTRunner >> cancel [

	self subclassResponsibility
]

{ #category : #cancelling }
TKTRunner >> cancel: aTKTFuture [ 

	aTKTFuture isValueAvailable ifTrue: [ self error: 'this future was already deployed' ].
	aTKTFuture deployValue: TKTCancelledFutureValue new.
]

{ #category : #running }
TKTRunner >> deployError: anError intoFuture: aFuture [

	aFuture deployError: anError.
]

{ #category : #running }
TKTRunner >> deployValue: aValue intoFuture: aFuture [

	aFuture deployValue: aValue.
]

{ #category : #testing }
TKTRunner >> isRunning [
	^ self isTerminated not
]

{ #category : #testing }
TKTRunner >> isTerminated [

	self subclassResponsibility
]

{ #category : #private }
TKTRunner >> newFuture [

	^ TKTFuture new
			runner: self;
			yourself
]

{ #category : #running }
TKTRunner >> run: aTKTTask [

	self subclassResponsibility
]
