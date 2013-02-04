Class {
	#name : #TKTTasker,
	#superclass : #Object,
	#instVars : [
		'wrapped'
	],
	#category : #'TaskIT-Kernel'
}

{ #category : #'as yet unclassified' }
TKTTasker class >> for: anObject [ 
	^ self new wrapp: anObject ; yourself.
]

{ #category : #'as yet unclassified' }
TKTTasker >> doesNotUnderstand: aMessage [

	^ [ wrapped perform: aMessage selector  withArguments: aMessage arguments ] taskIt asResult.
]

{ #category : #'as yet unclassified' }
TKTTasker >> paralellized [ 
	 ^ self.
]

{ #category : #'as yet unclassified' }
TKTTasker >> value [
	^ [ wrapped value ] taskIt asResult.
]

{ #category : #'as yet unclassified' }
TKTTasker >> wrapp: anObject [ 
	wrapped := anObject.
]
