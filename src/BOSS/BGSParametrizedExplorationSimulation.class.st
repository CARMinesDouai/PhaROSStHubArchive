Class {
	#name : #BGSParametrizedExplorationSimulation,
	#superclass : #BGSExplorationSimulation,
	#instVars : [
		'robotClass',
		'robotInitialPositions',
		'stopConditionBlock',
		'afterStopBlock'
	],
	#category : #'BOSS-Exploration'
}

{ #category : #'instance creation' }
BGSParametrizedExplorationSimulation class >> terrain: terrain robotsClass: robotClass positions: points stopOn: stopConditionBlock afterStopDo: afterStopBlock [
	^self basicNew
		terrain: terrain; 
		robotClass: robotClass;
		robotInitialPositions: points;
		stopConditionBlock: stopConditionBlock;
		afterStopBlock: afterStopBlock;
		initialize;
		yourself
]

{ #category : #accessing }
BGSParametrizedExplorationSimulation >> afterStopBlock [
	^ afterStopBlock
]

{ #category : #accessing }
BGSParametrizedExplorationSimulation >> afterStopBlock: anObject [
	afterStopBlock := anObject
]

{ #category : #testing }
BGSParametrizedExplorationSimulation >> autoStopConditionReached [
	^self stopConditionBlock cull: self
]

{ #category : #'initialize-release' }
BGSParametrizedExplorationSimulation >> deployRobots [
	self robots with: self robotInitialPositions do: [:bot :point|
		bot jumpTo: point in: self terrain]
]

{ #category : #accessing }
BGSParametrizedExplorationSimulation >> robotClass [
	^robotClass
]

{ #category : #accessing }
BGSParametrizedExplorationSimulation >> robotClass: anObject [
	robotClass := anObject
]

{ #category : #accessing }
BGSParametrizedExplorationSimulation >> robotCount [
	^robotInitialPositions size
]

{ #category : #accessing }
BGSParametrizedExplorationSimulation >> robotInitialPositions [
	^ robotInitialPositions
]

{ #category : #accessing }
BGSParametrizedExplorationSimulation >> robotInitialPositions: anObject [
	robotInitialPositions := anObject
]

{ #category : #stepping }
BGSParametrizedExplorationSimulation >> runLoop [
	[super runLoop] ensure: [
		self autoStopConditionReached ifTrue: [
			self afterStopBlock cull: self]]
]

{ #category : #accessing }
BGSParametrizedExplorationSimulation >> stopConditionBlock [
	^ stopConditionBlock
]

{ #category : #accessing }
BGSParametrizedExplorationSimulation >> stopConditionBlock: anObject [
	stopConditionBlock := anObject
]
