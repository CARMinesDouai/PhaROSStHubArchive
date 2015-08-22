"
In order to allow userconfortably watch simulation (avoid the flashing simulation effect), I introduce a delay to suspend the simulation process every step for a short duration (milliseconds). See references to variable stepDelay

Instance Variables:
	stepDelay	<Delay>
	stepDelayMilliseconds	<ProtoObject | PseudoContext>
"
Class {
	#name : #BGSSlowedDownSimulation,
	#superclass : #BGSSimulation,
	#instVars : [
		'stepDelay',
		'stepDelayMilliseconds'
	],
	#category : #'BOSS-Kernel'
}

{ #category : #'initialize-release' }
BGSSlowedDownSimulation >> defaultStepDelayMilliseconds [
	^100
]

{ #category : #'initialize-release' }
BGSSlowedDownSimulation >> initialize [ 
	super initialize.
	self stepDelayMilliseconds: self defaultStepDelayMilliseconds
]

{ #category : #'initialize-release' }
BGSSlowedDownSimulation >> resetStepDelay [
	stepDelay := Delay forMilliseconds: self stepDelayMilliseconds
]

{ #category : #stepping }
BGSSlowedDownSimulation >> runLoop [
	^ [ [ self autoStopConditionReached or: [ self isPaused ] ] whileFalse: [ 
			self step.
			self stepDelay wait] ]
		ensure: [ self changed ]
]

{ #category : #accessing }
BGSSlowedDownSimulation >> stepDelay [
	(stepDelay isNil or: [stepDelay schedulerBeingWaitedOn]) ifTrue: [self resetStepDelay].
	^stepDelay
]

{ #category : #accessing }
BGSSlowedDownSimulation >> stepDelayMilliseconds [
	^ stepDelayMilliseconds
]

{ #category : #accessing }
BGSSlowedDownSimulation >> stepDelayMilliseconds: number [
	stepDelayMilliseconds := number.

]
