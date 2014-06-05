"
I represent the result of a task execution.
"
Class {
	#name : #TKTResult,
	#superclass : #Object,
	#category : #'TaskIT-Kernel'
}

{ #category : #testing }
TKTResult >> isCancelled [
	
	^ false
]

{ #category : #testing }
TKTResult >> isError [
	
	^ false
]
