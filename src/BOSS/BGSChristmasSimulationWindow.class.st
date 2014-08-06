"
see comment of BGSChristmasSimulation
"
Class {
	#name : #BGSChristmasSimulationWindow,
	#superclass : #BGSExplorationSimulationWindow,
	#category : #'BOSS-Christmas2011'
}

{ #category : #'instance creation' }
BGSChristmasSimulationWindow class >> on: simulation [
	(super on: simulation)
		position: 40@0;
		yourself
]

{ #category : #'initialize-release' }
BGSChristmasSimulationWindow >> gridViewClass [
	^BGSChristmasGridView 
]
