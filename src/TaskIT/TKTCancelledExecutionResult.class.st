"
I'm a cancelled task execution.
"
Class {
	#name : #TKTCancelledExecutionResult,
	#superclass : #TKTResult,
	#category : #'TaskIT-Kernel'
}

{ #category : #testing }
TKTCancelledExecutionResult >> isCancelled [
	
	^ true
]
