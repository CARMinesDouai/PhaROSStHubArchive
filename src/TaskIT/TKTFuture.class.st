Class {
	#name : #TKTFuture,
	#superclass : #Object,
	#instVars : [
		'result',
		'isDeployed',
		'error',
		'monitor'
	],
	#category : #'TaskIT-Kernel'
}

{ #category : #'as yet unclassified' }
TKTFuture >> deployError: anError [
	error := anError.
	isDeployed := true.
	monitor signalAll.
	
]

{ #category : #'as yet unclassified' }
TKTFuture >> deployResult: aResult [
	result := aResult.
	isDeployed := true.
	monitor signalAll.
	
]

{ #category : #'as yet unclassified' }
TKTFuture >> initialize [ 
	isDeployed := false.
	result := nil. 
	error := nil.
	monitor := Monitor new.
]

{ #category : #'as yet unclassified' }
TKTFuture >> resultAvailable [
	^ isDeployed.
]

{ #category : #'as yet unclassified' }
TKTFuture >> value [

	monitor waitWhile: [ isDeployed not ].
		
	error ifNotNil:[
		error signal.
	].

	^ result.

]
