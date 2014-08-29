"
BGSSimulation is the main entry point to perform simulations. It deploys robots on a terrain and make them perform their actions. A simulation has its own process that drives robots (step message). It can be paused any time (message pause) and it automatically stops when reaching a stop condition.

Subclasses should implement methods:
-deployRobots
-robotClass
-robotCount

Subclasses are likely to override method:
-terrainClass
-name

Instance Variables:
	robots	<Collection of: BGSRobot>
	terrain	<BGSTerrain>
	pauseFlagLock	<Mutex>
	isPaused	<Boolean>
	stepCounter	<Integer> is incremented on every simulation step
"
Class {
	#name : #BGSSimulation,
	#superclass : #Object,
	#instVars : [
		'robotsDict',
		'terrain',
		'pauseFlagLock',
		'isPaused',
		'stepCount'
	],
	#category : #'BOSS-Kernel'
}

{ #category : #'initialize-release' }
BGSSimulation >> addRobot: bot [
	self robotsDict at: bot id put: bot
]

{ #category : #testing }
BGSSimulation >> autoStopConditionReached [
	^false
]

{ #category : #'initialize-release' }
BGSSimulation >> createRobots [
	(1 to: self robotCount) collect: [:botNumber | 
			self addRobot: (self robotClass number: botNumber)].

]

{ #category : #'initialize-release' }
BGSSimulation >> createTerrain [
	^self terrainClass new
]

{ #category : #'initialize-release' }
BGSSimulation >> deployRobots [
	self subclassResponsibility 
]

{ #category : #'initialize-release' }
BGSSimulation >> initialize [ 
	super initialize.
	pauseFlagLock := Mutex new.
	self reset.

]

{ #category : #testing }
BGSSimulation >> isPaused [
	^pauseFlagLock critical: [isPaused]
]

{ #category : #accessing }
BGSSimulation >> isPaused: aBoolean [
	pauseFlagLock critical: [
		isPaused := aBoolean.
		self changed]
]

{ #category : #testing }
BGSSimulation >> isRunning [
	^((pauseFlagLock critical: [self isPaused]) or: [self autoStopConditionReached]) not
]

{ #category : #stepping }
BGSSimulation >> pause [
	self isPaused: true
]

{ #category : #accessing }
BGSSimulation >> removeRobot: aBGSRobot [ 
	^self robotsDict removeKey: aBGSRobot id ifAbsent: [nil]
]

{ #category : #'initialize-release' }
BGSSimulation >> reset [
	self pause.
	self stepCount: 0.
	self terrain reset.
	self robotsDict: Dictionary new.
	self createRobots.
	self deployRobots.
	self changed
]

{ #category : #accessing }
BGSSimulation >> robot: robotId [
	^self robotsDict at: robotId
]

{ #category : #'initialize-release' }
BGSSimulation >> robotClass [
	^self subclassResponsibility
]

{ #category : #'initialize-release' }
BGSSimulation >> robotCount [
	self subclassResponsibility
]

{ #category : #accessing }
BGSSimulation >> robots [
	^self robotsDict values
]

{ #category : #accessing }
BGSSimulation >> robotsDict [
	^ robotsDict
]

{ #category : #accessing }
BGSSimulation >> robotsDict: anObject [
	robotsDict := anObject
]

{ #category : #stepping }
BGSSimulation >> run [
	pauseFlagLock
		critical: [ 
			self isPaused
				ifFalse: [ ^ self ].
			self isPaused: false ].
	[ self runLoop ] forkAt: Processor userBackgroundPriority
]

{ #category : #stepping }
BGSSimulation >> runLoop [
	^ [ [ self autoStopConditionReached or: [ self isPaused ] ] whileFalse: [ self step] ]
		ensure: [ self changed ]
]

{ #category : #stepping }
BGSSimulation >> step [
	self stepCount: self stepCount + 1.
	self robots do: [ :r | r step ].

]

{ #category : #accessing }
BGSSimulation >> stepCount [
	^ stepCount
]

{ #category : #accessing }
BGSSimulation >> stepCount: newCount [
	stepCount := newCount.
	self changed
]

{ #category : #stepping }
BGSSimulation >> stepIfPaused [
	self isRunning ifTrue: [^self].
	self autoStopConditionReached ifTrue: [^self].
	self step
]

{ #category : #accessing }
BGSSimulation >> terrain [
	^ terrain ifNil: [terrain := self createTerrain]
]

{ #category : #accessing }
BGSSimulation >> terrain: anObject [
	terrain := anObject
]

{ #category : #'initialize-release' }
BGSSimulation >> terrainClass [
	^BGSGrid
]

{ #category : #accessing }
BGSSimulation >> tracePositionFor: robotId [ 
	^self robotsDict at: robotId ifAbsent: [nil]
]
