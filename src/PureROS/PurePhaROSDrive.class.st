Class {
	#name : #PurePhaROSDrive,
	#superclass : #PurePhaROSNode,
	#instVars : [
		'currentId',
		'trajectoryController',
		'currentPlanIndex',
		'pathItarator',
		'lastPlannedPosition',
		'stepController',
		'lastMeasure'
	],
	#category : #PureROS
}

{ #category : #'as yet unclassified' }
PurePhaROSDrive >> commandVelocity: aMessage [

"	dd based "

	self assert: aMessage value linear y = 0.0.
	self assert: aMessage value linear z = 0.0.
	self assert: aMessage value angular y = 0.0.
	self assert: aMessage value angular x = 0.0.
	
	robot differentialService moveAt: aMessage value linear x  and: aMessage value angular z.
	
]

{ #category : #'as yet unclassified' }
PurePhaROSDrive >> commandVelocityVelocity: aMessage [

	(lastMeasure notNil and: [ lastMeasure closeTo: aMessage value ]) ifTrue: [^ self].
	lastMeasure := aMessage value.
	

"	step based "
	aMessage value linear y = 0.0 ifFalse: [ Transcript show: 'Y: ', aMessage value linear y asString; cr. ].
	self assert: aMessage value linear y = 0.0.
	self assert: aMessage value linear z = 0.0.
	self assert: aMessage value angular y = 0.0.
	self assert: aMessage value angular x = 0.0.
	
	aMessage value angular z ~= 0 ifTrue: [ stepController thenRotate: (aMessage value angular z) ].	
	aMessage value linear x ~= 0 ifTrue: [ stepController thenMoveForward: aMessage value linear x ].
	

"	

	 aMessage value linear y ~= 0 ifTrue: [
		trajectoryController goToDelta: (aMessage value linear x @ aMessage value linear y).	
	]. 

	(aMessage value linear y = 0 and: [aMessage value linear x ~= 0] )ifTrue: [
		trajectoryController stopMotion; clearTrajectory.
		stepController thenMoveForward: aMessage value linear x .
	].
	(aMessage value linear y = 0 and: [aMessage value linear x = 0] ) ifTrue: [
		trajectoryController stopMotion; clearTrajectory.
		aMessage value angular z ~= 0 ifTrue: [ stepController thenRotate: (aMessage value angular z) ].		
	]

"
]

{ #category : #'as yet unclassified' }
PurePhaROSDrive >> consumeId [ 
	| anId |
	anId := currentId.
	currentId := currentId + 1.
	^ 'pharo-',self name, anId asString.
]

{ #category : #'as yet unclassified' }
PurePhaROSDrive >> followPath: aCollectionOfPoints [
	
	[
	
		trajectoryController stopMotion ;	clearTrajectory .
		trajectoryController goToAll: aCollectionOfPoints.
		self halt.
	] on: Error do: [
		: e| self halt.
	].
	
]

{ #category : #'as yet unclassified' }
PurePhaROSDrive >> globalPlaning: aMessage [

| delta currentPosition newPosition |	
			
			currentPosition := pureRos currentRosPose position.
			currentPosition := currentPosition x @ currentPosition y
			.	
			newPosition := aMessage value poses last pose position.
			newPosition := newPosition x @ newPosition y. 
			
			((newPosition closeTo: lastPlannedPosition) and: [trajectoryController status ~= PNGTrajectoryState followingStatusValue]) ifFalse: [
				delta := newPosition - currentPosition.
				
				trajectoryController status = PNGTrajectoryState errorStatusValue ifTrue: [ 
					trajectoryController stopMotion; clearTrajectory.	
				].
				trajectoryController goToDelta: delta. 	
			].
			Transcript show: trajectoryController status.
			lastPlannedPosition := newPosition.
]

{ #category : #'as yet unclassified' }
PurePhaROSDrive >> goToAll: waypoints [ 

	| error |

	5 timesRepeat: [
		[
			trajectoryController stopMotion.	
			trajectoryController trajectoryService clearTrajectory.
			trajectoryController goToAllDelta: waypoints.
			^ self.
		] on: PNGConnectionTimeOut do: [ 	:e | error := e.  Transcript show: 'Retrying plan'; cr. 	(Delay forMilliseconds: 1000)wait. trajectoryController trajectoryService  emergencyStop.]
	].

	error signal.
]

{ #category : #'as yet unclassified' }
PurePhaROSDrive >> initialize [ 
	super initialize.
	currentId := 1.
	lastPlannedPosition := 0@0.
]

{ #category : #'as yet unclassified' }
PurePhaROSDrive >> localPlaning: aMessage [

| delta currentPosition newPosition |	
			
			currentPosition := pureRos currentRosPose position.
			currentPosition := currentPosition x @ currentPosition y
			.	
			newPosition := aMessage value poses last pose position.
			newPosition := newPosition x @ newPosition y. 
			
			((newPosition closeTo: lastPlannedPosition) and: [trajectoryController status ~= PNGTrajectoryState followingStatusValue]) ifFalse: [
				delta := newPosition - currentPosition.
				
				trajectoryController status = PNGTrajectoryState errorStatusValue ifTrue: [ 
					trajectoryController stopMotion; clearTrajectory.	
				].
				(delta closeTo: (0.0 @ 0.0) )ifTrue: [
					Transcript show: ' asked for a small delta! ', delta asString ; cr.
				] ifFalse: [
					trajectoryController goToDelta: delta. 	
				]
			].
			
			
		
"			Transcript show: trajectoryController status."
			lastPlannedPosition := newPosition.
]

{ #category : #'as yet unclassified' }
PurePhaROSDrive >> moveTo: aPose [
	| array | 

	currentPlanIndex := 1.
	self sendTo: '/move_base/goal' typedAs: 'move_base_msgs/MoveBaseActionGoal' a: [ :msg | 
		
		msg header frame_id: '/base_link'.
		msg goal_id id: self consumeId.
		msg goal target_pose pose position x: aPose x.
		msg goal target_pose pose position y: aPose y.
		msg goal target_pose pose position z: 0.0.
		
		array := PhaROSGeometryTransformations new quaternationFromEulerFor: 0.0 and: 0.0 and: aPose orientation .

		msg goal target_pose header frame_id: '/map'.
		msg goal target_pose pose orientation x: (array at:1).
		msg goal target_pose pose orientation y: (array at:2).
		msg goal target_pose pose orientation z: (array at:3).
		msg goal target_pose pose orientation w: (array at:4).

	].
]

{ #category : #'as yet unclassified' }
PurePhaROSDrive >> navigationPlanning: aMessage [
	| waypoints currentPosition |


	currentPosition := pureRos currentRosPose position.
	currentPosition := currentPosition x @ currentPosition y.
	pathItarator path: aMessage value. 

	waypoints := OrderedCollection new. 
	[pathItarator hasNext] whileTrue: [ 
		| position delta |
		position := pathItarator next position .
		position := position x @ position y.
		delta := position - currentPosition.	
		waypoints add: delta.
	 ].
	[	
		self goToAll: waypoints.
	] on: Error do: [
		:e | 
		pathItarator resetToLastCalculatedIndex.
		e signal.
	]
	
	
]

{ #category : #'as yet unclassified' }
PurePhaROSDrive >> receive: aMessage from: aChannel [


		aChannel topic name = '/move_base/TrajectoryPlannerROS/global_plan' ifTrue: [
			self globalPlaning: aMessage.
		].
		aChannel topic name = '/move_base/TrajectoryPlannerROS/local_plan' ifTrue: [
			self localPlaning: aMessage.
		].
		aChannel topic name=  '/move_base/NavfnROS/plan' ifTrue: [
			self navigationPlanning: aMessage.
		].
		aChannel topic name=  '/command_velocity' ifTrue: [
			self commandVelocity: aMessage.
		].
]

{ #category : #'as yet unclassified' }
PurePhaROSDrive >> setUp [

	trajectoryController := PNGTrajectoryServiceBasedController for: robot.
	stepController := PNGStepServiceBasedController  for: robot.
	pathItarator := PhaRosPathIterator new.
	

]
