Class {
	#name : #BGSCar2012RandomMeanSimulation,
	#superclass : #BGSParametrizedExplorationSimulation,
	#category : #'BOSS-Exploration-CAR2012'
}

{ #category : #simulating }
BGSCar2012RandomMeanSimulation class >> positionsForRobotsCount: robotsCount [
	|positions|
	positions := OrderedCollection withAll: {1@1. 1@3}.
	3 to: robotsCount do: [:index|
		|previousPosition delta|
		previousPosition := positions atLast: 2.		
		index even 
			ifTrue: [delta := 0@2]
			ifFalse: [delta := 2@0].
		positions add: previousPosition + delta
	].
	^positions first: robotsCount
	
]

{ #category : #simulating }
BGSCar2012RandomMeanSimulation class >> runFor: robotsCount in: aTerrain logFileName: fullFileName [ 
	|sim logger |
	sim := self 
			terrain: aTerrain 
			robotsClass: BGSCollaborativeNearestFrontierExplorerRobot
			positions: (self positionsForRobotsCount: robotsCount)
			stopOn: [:simulation| simulation unexploredPositionsCount = 0 ] 
			afterStopDo: [
				logger close.
				Smalltalk image snapshot: false andQuit: true].
	logger := BGSCar2012DoitLogger on: sim logInto: fullFileName.
	sim run.
	^sim
]
