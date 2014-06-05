Class {
	#name : #TKTErrorResult,
	#superclass : #TKTResult,
	#instVars : [
		'error'
	],
	#category : #'TaskIT-Kernel'
}

{ #category : #testing }
TKTErrorResult >> isError [

	^ true
]

{ #category : #accessing }
TKTErrorResult >> setError: anError [

	error := anError
]

{ #category : #evaluating }
TKTErrorResult >> value [

	error signal
]
