"
A TKTPharoProcess executes a block in a new pharo process
"
Class {
	#name : #TKTPharoProcess,
	#superclass : #TKTProcess,
	#instVars : [
		'process'
	],
	#category : #'TaskIT-Kernel'
}

{ #category : #controlling }
TKTPharoProcess >> execute [
	process ifNil: [
		process := executable newProcess .
		process name: processName .
		process priority: priority.
		process resume.
	] ifNotNil: [ 
		self error: 'Process has been already executed.'
	]
]

{ #category : #controlling }
TKTPharoProcess >> isTerminated [
	^ process isTerminated
]

{ #category : #controlling }
TKTPharoProcess >> pid [
	^ process  hash.
]

{ #category : #controlling }
TKTPharoProcess >> resume [
	process ifNotNil: [  
		process resume.
	] ifNil: [  
		self error: 'Resume is for resuming execution. For starting it up in first execution send #execute message'.
	]
]

{ #category : #controlling }
TKTPharoProcess >> setProcessSpecificVariableValue: aProcessSpecificVariable with: aValue [

	process setProcessSpecificVariableValue: aProcessSpecificVariable with: aValue
]

{ #category : #controlling }
TKTPharoProcess >> suspend [

	process ifNil: [ 
		self error: 'The process has not being executed yet'.
	] ifNotNil:[
		self isTerminated ifFalse:[
			process suspend.	
		]
	]
]

{ #category : #controlling }
TKTPharoProcess >> terminate [

	process ifNil: [ 
		self error: 'The process has not being executed yet'.
	] ifNotNil:[
		self isTerminated ifFalse:[
			process terminate.	
		]
	]
]
