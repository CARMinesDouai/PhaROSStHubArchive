Class {
	#name : #BGSLoggerTest,
	#superclass : #TestCase,
	#instVars : [
		'logger',
		'simulation'
	],
	#category : #'BOSS-Kernel-Test'
}

{ #category : #'setUp-tearDown' }
BGSLoggerTest >> loggerClass [
	^BGSLogger
]

{ #category : #testing }
BGSLoggerTest >> printLogHeaderOn: expectedLogStr botCount: expectedRobotCount [
	expectedLogStr nextPutAll: 'step'.
	1 to: expectedRobotCount do: [ :number | 
		expectedLogStr
			tab;
			nextPutAll: 'robot';
			print: number;
			nextPutAll: '-position';
			tab;
			nextPutAll: 'robot';
			print: number;
			nextPutAll: '-heading' ].
	expectedLogStr cr
]

{ #category : #testing }
BGSLoggerTest >> printOn: expectedLogStr step:  step positions: expectedBotPositions [ 
	expectedLogStr print: step.
	expectedBotPositions
		do: [ :position | 
			expectedLogStr
				tab;
				print: position;
				tab;
				print: 0 @ -1 ].
	expectedLogStr cr
]

{ #category : #'setUp-tearDown' }
BGSLoggerTest >> setUp [ 
	super setUp.
	simulation := self simulationClass new.
	logger := self loggerClass on: simulation

]

{ #category : #'setUp-tearDown' }
BGSLoggerTest >> simulationClass [
	^BGSSimulationForTest
]

{ #category : #'setUp-tearDown' }
BGSLoggerTest >> tearDown [
	super tearDown.
	logger fileName asFileReference ensureDelete
]

{ #category : #testing }
BGSLoggerTest >> testInitialLogForASimulationWith1Robot [
	| expectedLogStr |
	self assert: logger robots size = 1.
	expectedLogStr := WriteStream on: String new.
	self printLogHeaderOn: expectedLogStr botCount: 1.
	self printOn: expectedLogStr step: 0 positions: {(1 @ 1)}.
	self assert: logger allLog = expectedLogStr contents
]

{ #category : #testing }
BGSLoggerTest >> testInitialLogForASimulationWith3Robots [
	| expectedLogStr |
	2 to: 3 do: [ :botNumber | 
		| bot botPosition |
		bot := BGSRobot number: botNumber.
		botPosition := botNumber @ botNumber.
		bot jumpTo: botPosition in: simulation terrain.
		simulation addRobot: bot ].
	logger := BGSLogger on: simulation.
	self assert: logger robots size = 3.
	expectedLogStr := WriteStream on: String new.
	self printLogHeaderOn: expectedLogStr botCount: 3.
	self
		printOn: expectedLogStr
		step: 0
		positions: {(1 @ 1). (2 @ 2). (3 @ 3)}.
	self assert: logger allLog = expectedLogStr contents
]

{ #category : #testing }
BGSLoggerTest >> testLogAfter3StepsForASimulationWith1Robot [
	| expectedLogStr |
	self assert: logger robots size = 1.
	3 timesRepeat: [ simulation step ].
	self assert: logger stepCount = 3.
	expectedLogStr := WriteStream on: String new.
	self printLogHeaderOn: expectedLogStr botCount: 1.
	(0 to: 3) do: [:step|
		self printOn: expectedLogStr step: step positions: {(1 @ 1)}].
	self assert: logger allLog = expectedLogStr contents
]
