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
	future := TKTFuture new
					runner: self;
					yourself.				
	aTKTTask runOnRunner: self withFuture: future.
	^ future.
]
