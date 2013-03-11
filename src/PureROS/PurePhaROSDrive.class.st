Class {
	#name : #PurePhaROSDrive,
	#superclass : #PurePhaROSNode,
	#instVars : [
		'currentId',
		'trajectoryController',
		'currentPlanIndex',
		'pathItarator'
	],
	#category : #PureROS
}

{ #category : #'as yet unclassified' }
PurePhaROSDrive >> consumeId [ 
	| anId |
	anId := currentId.
	currentId := currentId + 1.
	^ 'pharo-',self name, anId asString.
]

{ #category : #'as yet unclassified' }
PurePhaROSDrive >> goToAll: waypoints [ 

	| error |
	
	5 timesRepeat: [
		[
			trajectoryController stopMotion.	
			trajectoryController trajectoryService clearTrajectory.
			trajectoryController goToAll: waypoints.
			^ self.
		] on: PNGConnectionTimeOut do: [ 	:e | error := e.  Transcript show: 'Retrying plan'; cr. 	(Delay forMilliseconds: 1000)wait. trajectoryController trajectoryService  emergencyStop.]
	].

	error signal.
]

{ #category : #'as yet unclassified' }
PurePhaROSDrive >> initialize [ 
	super initialize.
	currentId := 1.
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
PurePhaROSDrive >> receive: aMessage from: aChannel [
	| waypoints |

	pathItarator path: aMessage value. 
	
	waypoints := OrderedCollection new. 
	[pathItarator hasNext] whileTrue: [ waypoints add: pathItarator next position ].

	[	
		self goToAll: waypoints.
	] on: Error do: [
		:e | 
		pathItarator resetToLastCalculatedIndex.
		e signal.
	]
]

{ #category : #'as yet unclassified' }
PurePhaROSDrive >> setUp [

	trajectoryController := PNGTrajectoryServiceBasedController for: robot.
	pathItarator := PhaRosPathIterator new.
	

]
