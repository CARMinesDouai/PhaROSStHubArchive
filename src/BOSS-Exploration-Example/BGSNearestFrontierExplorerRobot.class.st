"
I am an explorer robot that moves towards the nearest frontier
"
Class {
	#name : #BGSNearestFrontierExplorerRobot,
	#superclass : #BGSFrontierExplorerRobot,
	#category : #'BOSS-Exploration-Example'
}

{ #category : #'accessing ' }
BGSNearestFrontierExplorerRobot >> frontierPositionsSorted [
	|myPosition|
	myPosition := self position.
	^self frontierPositions asSortedCollection: [:a :b| (myPosition dist: a) < (myPosition dist: b)].


]
