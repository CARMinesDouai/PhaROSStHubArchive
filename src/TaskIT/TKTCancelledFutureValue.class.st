"
I'm the value placed on a future when the future was cancelled. I throw an exception when I receive a message.
"
Class {
	#name : #TKTCancelledFutureValue,
	#superclass : #Object,
	#category : #'TaskIT-Futures'
}

{ #category : #'error handling' }
TKTCancelledFutureValue >> doesNotUnderstand: aMessage [
	Error signal: 'The process or task related with this result was cancelled.'
]
