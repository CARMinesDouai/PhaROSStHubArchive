Class {
	#name : #BGSSlowedDownExplorationSimulation,
	#superclass : #BGSExplorationSimulation,
	#instVars : [
		'stepDelay',
		'stepDelayMilliseconds'
	],
	#category : #'BOSS-Exploration'
}

{ #category : #'initialize-release' }
BGSSlowedDownExplorationSimulation >> defaultStepDelayMilliseconds [
	^100
]

{ #category : #'initialize-release' }
BGSSlowedDownExplorationSimulation >> initialize [ 
	super initialize.
	self stepDelayMilliseconds: self defaultStepDelayMilliseconds
]

{ #category : #'initialize-release' }
BGSSlowedDownExplorationSimulation >> resetStepDelay [
	stepDelay := Delay forMilliseconds: self stepDelayMilliseconds
]

{ #category : #stepping }
BGSSlowedDownExplorationSimulation >> runLoop [
	^ [ [ self autoStopConditionReached or: [ self isPaused ] ] whileFalse: [ 
			self step.
			self stepDelay wait] ]
		ensure: [ self changed ]
]

{ #category : #accessing }
BGSSlowedDownExplorationSimulation >> stepDelay [
	(stepDelay isNil or: [stepDelay beingWaitedOn]) ifTrue: [self resetStepDelay].
	^stepDelay
]

{ #category : #accessing }
BGSSlowedDownExplorationSimulation >> stepDelayMilliseconds [
	^ stepDelayMilliseconds
]

{ #category : #accessing }
BGSSlowedDownExplorationSimulation >> stepDelayMilliseconds: number [
	stepDelayMilliseconds := number.

]
