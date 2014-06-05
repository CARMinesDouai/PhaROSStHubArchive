"
I'm the value placed on a future when the future execution produced an error. I throw an exception when I receive a message.
"
Class {
	#name : #TKTInvalidFutureValue,
	#superclass : #Object,
	#category : #'TaskIT-Futures'
}

{ #category : #'error handling' }
TKTInvalidFutureValue >> doesNotUnderstand: aMessage [
	Error signal: 'The process or task related with this result resulted in error.'
]
