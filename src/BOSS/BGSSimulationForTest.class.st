Class {
	#name : #BGSSimulationForTest,
	#superclass : #BGSSimulation,
	#instVars : [
		'autoStopConditionFlag'
	],
	#category : #'BOSS-Kernel-Test'
}

{ #category : #accessing }
BGSSimulationForTest >> autoStopConditionFlag [
	^ autoStopConditionFlag
]

{ #category : #accessing }
BGSSimulationForTest >> autoStopConditionFlag: anObject [
	autoStopConditionFlag := anObject
]

{ #category : #testing }
BGSSimulationForTest >> autoStopConditionReached [
	^self autoStopConditionFlag 
]

{ #category : #'initialize-release' }
BGSSimulationForTest >> deployRobots [
	self robots first jumpTo: 1@1 in: self terrain

]

{ #category : #'initialize-release' }
BGSSimulationForTest >> initialize [ 
	super initialize.
	self autoStopConditionFlag: false
]

{ #category : #'initialize-release' }
BGSSimulationForTest >> robotClass [
	^BGSRobot
]

{ #category : #'initialize-release' }
BGSSimulationForTest >> robotCount [
	^1
]

{ #category : #'initialize-release' }
BGSSimulationForTest >> terrainClass [
	^BGSTerrainForTest
]
