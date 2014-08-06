Class {
	#name : #BGSExplorationLoggerTest,
	#superclass : #BGSLoggerTest,
	#category : #'BOSS-Exploration-Test'
}

{ #category : #testing }
BGSExplorationLoggerTest >> initialExpectedLog [
	|expectedLogStream|
	expectedLogStream := String new writeStream.
	#(step frontiers unexplored 'robot1-position' 'robot1-heading') do: [:headerString|
			expectedLogStream nextPutAll: headerString] 
		separatedBy: [
			expectedLogStream tab].
	expectedLogStream cr.
	{0. 3. 2496. 1@1. 0@ -1} do: [:initialValue|
			expectedLogStream print: initialValue] 
		separatedBy: [
			expectedLogStream tab].
	expectedLogStream cr.
	^expectedLogStream contents
]

{ #category : #testing }
BGSExplorationLoggerTest >> loggerClass [ 
	^BGSExplorationLogger 
]

{ #category : #testing }
BGSExplorationLoggerTest >> simulationClass [ 
	^BGS1RobotFrontierExplorationSimulation
]

{ #category : #testing }
BGSExplorationLoggerTest >> testInitialLog [
	self assert: logger allLog = self initialExpectedLog
]
