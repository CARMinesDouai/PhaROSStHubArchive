Class {
	#name : #BGSCar2012SimulationTest,
	#superclass : #TestCase,
	#instVars : [
		'simClass'
	],
	#category : #'BOSS-Exploration-CAR2012'
}

{ #category : #testing }
BGSCar2012SimulationTest >> setUp [
	super setUp.
	simClass := BGSSimulationWithTopLeftIinitialPosition
]

{ #category : #testing }
BGSCar2012SimulationTest >> testPositionsFor1Robot [
	| positions |
	positions := simClass positionsForRobotsCount: 1.
	self assert: positions asSet = {1@1} asSet
]

{ #category : #testing }
BGSCar2012SimulationTest >> testPositionsFor2Robots [
	| positions |
	positions := simClass positionsForRobotsCount: 2.
	self assert: positions asSet =  {1@1.  1@3} asSet
]

{ #category : #testing }
BGSCar2012SimulationTest >> testPositionsFor3Robots [
	| positions |
	positions := simClass positionsForRobotsCount: 3.
	self assert: positions asSet =  {1@1.  1@3. 3@1} asSet
]

{ #category : #testing }
BGSCar2012SimulationTest >> testPositionsFor4Robots [
	| positions |
	positions := simClass positionsForRobotsCount: 4.
	self assert: positions asSet =  {1@1.  1@3. 3@1. 1@5} asSet
]

{ #category : #testing }
BGSCar2012SimulationTest >> testPositionsFor5Robots [
	| positions |
	positions := simClass positionsForRobotsCount: 5.
	self assert: positions asSet =  {1@1.  1@3. 3@1. 1@5. 5@1} asSet
]
