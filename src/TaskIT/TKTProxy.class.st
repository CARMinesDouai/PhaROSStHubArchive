Class {
	#name : #TKTProxy,
	#superclass : #Object,
	#instVars : [
		'wrapped'
	],
	#category : #'TaskIT-Worker'
}

{ #category : #'as yet unclassified' }
TKTProxy class >> for: anObject [ 
	^ self new wrapp: anObject ; yourself.
]

{ #category : #'as yet unclassified' }
TKTProxy >> doesNotUnderstand: aMessage [

	^ (self spawn: ([ wrapped perform: aMessage selector  withArguments: aMessage arguments ] )) asResult.
]

{ #category : #'as yet unclassified' }
TKTProxy >> spawn: aBlock [
	self subclassResponsibility.
]

{ #category : #'as yet unclassified' }
TKTProxy >> value [
	^ self spawn: ([ wrapped value ]) asResult.
]

{ #category : #'as yet unclassified' }
TKTProxy >> wrapp: anObject [ 
	wrapped := anObject.
]
