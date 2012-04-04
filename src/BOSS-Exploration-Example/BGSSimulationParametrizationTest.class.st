Class {
	#name : #BGSSimulationParametrizationTest,
	#superclass : #TestCase,
	#instVars : [
		'simulation',
		'terrain',
		'robotsCount',
		'robotsClass',
		'afterStopActionPerformed',
		'stopFlag'
	],
	#category : #'BOSS-Kernel-Test'
}

{ #category : #testing }
BGSSimulationParametrizationTest >> setUp [
	super setUp.
	terrain := BGSExplorableTerrain new.
	afterStopActionPerformed := false.
	stopFlag := false.
	robotsCount := 1.
	robotsClass := BGSRobot.
	simulation := BGSParametrizedExplorationSimulation 
				terrain: terrain 
				robotsClass: BGSRobot  
				positions: {1@1} 
				stopOn: [:sim| stopFlag] 
				afterStopDo: [:sim| afterStopActionPerformed := true].

]

{ #category : #testing }
BGSSimulationParametrizationTest >> tearDown [
	super tearDown.
	simulation pause

]

{ #category : #testing }
BGSSimulationParametrizationTest >> testAfterStopAction [
	simulation run.
	(Delay forMilliseconds: 100) wait.
	stopFlag := true.
	(Delay forMilliseconds: 100) wait.
	self assert: simulation autoStopConditionReached.
	self assert: afterStopActionPerformed
]

{ #category : #testing }
BGSSimulationParametrizationTest >> testPauseDoesNotTriggerAfterStopAction [
	simulation run.
	(Delay forMilliseconds: 100) wait.
	simulation pause.
	(Delay forMilliseconds: 100) wait.
	self deny: simulation autoStopConditionReached.
	self deny: afterStopActionPerformed
]

{ #category : #testing }
BGSSimulationParametrizationTest >> testRobotsClass [
	simulation robots do: [:bot|
		self assert: (bot isKindOf: robotsClass)]
]

{ #category : #testing }
BGSSimulationParametrizationTest >> testRobotsCount [
	self assert: simulation robots size = robotsCount
]

{ #category : #testing }
BGSSimulationParametrizationTest >> testSimulationTerrainIsProvidedOnCreation [
	self assert: simulation terrain == terrain
]
