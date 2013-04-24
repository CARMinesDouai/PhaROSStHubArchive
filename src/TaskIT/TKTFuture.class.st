Class {
	#name : #TKTFuture,
	#superclass : #Object,
	#instVars : [
		'isDeployed',
		'error',
		'callbacks',
		'value',
		'result',
		'semaphore'
	],
	#category : #'TaskIT-Kernel'
}

{ #category : #'as yet unclassified' }
TKTFuture >> asResult [
	result ifNil: [
		result := TKTResult for: self. 
	].
	^ result.
]

{ #category : #'as yet unclassified' }
TKTFuture >> asStickyReference [ 
	^ TKTStickyReference for: self.
]

{ #category : #'as yet unclassified' }
TKTFuture >> cancel [ 
	TKTTaskDispatcher expropiate: self.
]

{ #category : #'as yet unclassified' }
TKTFuture >> deployError: anError [
	error := anError.
	isDeployed := true.
	semaphore signal.
	
]

{ #category : #'as yet unclassified' }
TKTFuture >> deployValue: aValue [
	value := aValue.
	isDeployed := true.
	callbacks get do: [ : c  | c cull: aValue ].
	semaphore signal.
	
]

{ #category : #'as yet unclassified' }
TKTFuture >> finalize [ 
	self cancel.
]

{ #category : #'as yet unclassified' }
TKTFuture >> initialize [ 
	isDeployed := false.
	value := nil. 
	error := nil.
	callbacks := TKTVariable for: OrderedCollection new.
	semaphore := Semaphore new.
]

{ #category : #testing }
TKTFuture >> processFinished [
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
TKTFuture >> value [

	semaphore wait.
		
	error ifNotNil:[
		error signal.
	].

	^ value.

]

{ #category : #'as yet unclassified' }
TKTFuture >> valueAvailable [
	^ isDeployed.
]

{ #category : #'as yet unclassified' }
TKTFuture >> whenFinished: aBlock [
	self valueAvailable ifTrue:[
		aBlock cull: value.	
	] ifFalse: [
		callbacks add: aBlock.
	]
]
