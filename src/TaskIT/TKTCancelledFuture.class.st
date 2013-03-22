Class {
	#name : #TKTCancelledFuture,
	#superclass : #Object,
	#category : #'TaskIT-Kernel'
}

{ #category : #'as yet unclassified' }
TKTCancelledFuture >> doesNotUnderstand: aMessage [
	Error signal: 'The process or task related with this result was cancelled.'
]
