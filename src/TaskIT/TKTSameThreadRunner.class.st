Class {
	#name : #TKTSameThreadRunner,
	#superclass : #TKTRunner,
	#category : #'TaskIT-Kernel'
}

{ #category : #testing }
TKTSameThreadRunner >> isTerminated [

	^ true
]

{ #category : #running }
TKTSameThreadRunner >> run: aTKTTask [

	| future |
	future := self newFuture.				
	aTKTTask asTask runOnRunner: self withFuture: future.
	^ future.
]
