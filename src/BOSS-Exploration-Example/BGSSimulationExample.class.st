"
SimulationExample is a simple simulation with a three robots that randomly walks in a terrain.
Instance Variables:
	stepDelay	<Delay> delay between two simulation steps.
		
To display and log the simulation, evaluate in a workspace the following code snippet
	sim := BGSSimulationExample new.
	BGSSimulationWindow on:  sim.
	logger := BGSLogger on: sim.


"
Class {
	#name : #BGSSimulationExample,
	#superclass : #BGSSlowedDownSimulation,
	#category : #'BOSS-Example'
}

{ #category : #stepping }
BGSSimulationExample >> autoStopConditionReached [ 
	^self stepCount = 100
]

{ #category : #'initialize-release' }
BGSSimulationExample >> deployRobots [
	self robots do: [:bot|
		(bot body part: #frontRangeSensor) range: 3].
	self robots with: {17@17. 37@17. 26@37} do: [:bot :position|
		bot jumpTo: position in: self terrain]

]

{ #category : #accessing }
BGSSimulationExample >> name [ 
	^'Basic Simulation Example'
]

{ #category : #'initialize-release' }
BGSSimulationExample >> robotClass [
	^BGSRandomWalkRobot
]

{ #category : #'initialize-release' }
BGSSimulationExample >> robotCount [
	^3
]

{ #category : #'initialize-release' }
BGSSimulationExample >> terrainClass [
	^BGSTerrainExample
]
