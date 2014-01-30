Class {
	#name : #TKTOneShotRunner,
	#superclass : #TKTOwnProcessRunner,
	#instVars : [
		'future'
	],
	#category : #'TaskIT-Kernel'
}

{ #category : #running }
TKTOneShotRunner >> cancelFutures [

	self cancel: future.
]

{ #category : #accessing }
TKTOneShotRunner >> defaultProcessName [

	^ 'One Shot runner'
]

{ #category : #running }
TKTOneShotRunner >> run: aTKTTask [

	| task |
	future := self newFuture.
	task := aTKTTask asTask.
	process := [
		task runOnRunner: self withFuture: future
	] newProcess.
	process name: 'A TKTTask'.
	process priority: task priority.
	process resume.
	
	^ future.
]
