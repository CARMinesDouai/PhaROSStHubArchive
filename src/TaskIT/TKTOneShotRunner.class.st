Class {
	#name : #TKTOneShotRunner,
	#superclass : #TKTRunner,
	#instVars : [
		'future'
	],
	#category : #'TaskIT-Kernel'
}

{ #category : #running }
TKTOneShotRunner >> cancelFutures [

	self cancel: future.
]

{ #category : #running }
TKTOneShotRunner >> run: aTKTTask [

	future := TKTFuture new
					runner: self;
					yourself.
					
	process := [
		aTKTTask value: future.
		self stopProcess.
	] newProcess.
	process name: 'A TKTTask'.
	process priority: aTKTTask priority.
	process resume.
	
	^ future.
]
