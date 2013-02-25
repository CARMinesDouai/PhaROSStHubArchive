Class {
	#name : #PurePhaROSDrive,
	#superclass : #PurePhaROSNode,
	#instVars : [
		'currentId',
		'current',
		'pngBot'
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
PurePhaROSDrive >> current: aPose [
	current := aPose.
]

{ #category : #'as yet unclassified' }
PurePhaROSDrive >> initialize [ 
	super initialize.
	currentId := 1.
	current := Pose new. 
]

{ #category : #'as yet unclassified' }
PurePhaROSDrive >> moveTo: aPose [
	| array | 

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
	
	
	aChannel topic name = '/command_velocity' ifTrue: [
		| twist |
		twist := aMessage value.

		Transcript show: twist asString; cr.
		robot with: DifferentialDriveService  do: [: ds |  ds setTargetLinearSpeed:  0.0 andTargetAngularSpeed: (twist angular z / 10)].

"		(Delay forMilliseconds: 500) wait.		"
	] ifFalse: [ self halt.] 
	
]

{ #category : #'as yet unclassified' }
PurePhaROSDrive >> setUp [

	robot with: LocalizationService  do: [
		: localization  |
		
		localization whenANotificationArrivesDo:  [ :notif |			 
			self current: notif pose.
		].
	
		localization enableNotifications.
	].

	self interestedIn: '/command_velocity'.
"	self interestedIn: '/move_base/NavfnROS/plan'."

]
