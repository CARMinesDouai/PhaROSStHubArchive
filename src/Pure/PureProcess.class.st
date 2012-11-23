Class {
	#name : #PureProcess,
	#superclass : #Object,
	#instVars : [
		'keepRunning',
		'process',
		'processMutex'
	],
	#category : #'Pure-Kernel'
}

{ #category : #'as yet unclassified' }
PureProcess >> initialize [ 
	processMutex := Mutex new.
]

{ #category : #'as yet unclassified' }
PureProcess >> keepRunning [ 
	| val |
	processMutex  critical: [
		val := keepRunning.
	].
	^val. 
]

{ #category : #'as yet unclassified' }
PureProcess >> keepRunning: aBoolean [
	processMutex  critical: [
		keepRunning := aBoolean.
		
	].
]

{ #category : #'as yet unclassified' }
PureProcess >> priorityPolicy [ 
	^ Processor userBackgroundPriority.
]

{ #category : #'as yet unclassified' }
PureProcess >> processName [ 
	^ 'PureProcess'. 
]

{ #category : #'as yet unclassified' }
PureProcess >> run [
	self subclassResponsibility.
]

{ #category : #'as yet unclassified' }
PureProcess >> startUp [
	process ifNil: [
		self keepRunning: true.
		process := [
			[ self keepRunning ] whileTrue: [ self run. ].
		] forkAt: self priorityPolicy named: self processName.
	].
]

{ #category : #'as yet unclassified' }
PureProcess >> stop [	
	process ifNotNil: [
		self keepRunning: false.
		self waitForFinish.
		process terminate.
		process := nil.
	].



]

{ #category : #'as yet unclassified' }
PureProcess >> waitForFinish [
	(Delay forMilliseconds: 500) wait.
]
