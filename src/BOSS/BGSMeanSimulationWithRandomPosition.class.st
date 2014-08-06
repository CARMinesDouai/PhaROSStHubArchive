Class {
	#name : #BGSMeanSimulationWithRandomPosition,
	#superclass : #BGSParametrizedExplorationSimulation,
	#category : #'BOSS-Exploration-CAR2012'
}

{ #category : #'as yet unclassified' }
BGSMeanSimulationWithRandomPosition class >> positionsIn: aTerrain forRobotsCount: robotsCount [
	^ aTerrain emptyCellPositions asArray shuffle first: robotsCount 

]

{ #category : #'as yet unclassified' }
BGSMeanSimulationWithRandomPosition class >> runFor: robotsCount in: aTerrain logFileName: fullFileName [ 
	|sim results fileStr lock|
	
	lock := Semaphore new.
	results := OrderedCollection new.
	1 to: 30 do: [ :i |
		sim := self 
			terrain: aTerrain 
			robotsClass: BGSCollaborativeNearestFrontierExplorerRobot
			positions: (self positionsIn: aTerrain forRobotsCount: robotsCount)
			stopOn: [:simulation| simulation unexploredPositionsCount = 0 ] 
			afterStopDo: [
				results add: sim stepCount.
				lock signal.
				].
		sim run.
		lock wait.	
	].
	
	fileStr := FileStream fileNamed: fullFileName.
	fileStr print:  robotsCount.
	
	fileStr tab;
		print: (results average asFloat roundTo: 2).
			
	results do: [ :result | 
		fileStr tab;
			print: result
	].
		
	fileStr lf 
		close.

	Smalltalk image snapshot: false andQuit: true
			
]
