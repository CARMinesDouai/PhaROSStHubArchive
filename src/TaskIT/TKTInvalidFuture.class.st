Class {
	#name : #TKTInvalidFuture,
	#superclass : #Object,
	#category : #'TaskIT-Kernel'
}

{ #category : #'as yet unclassified' }
TKTInvalidFuture >> doesNotUnderstand: aMessage [
	Error signal: 'The process or task related with this result is no longer available.'
]
