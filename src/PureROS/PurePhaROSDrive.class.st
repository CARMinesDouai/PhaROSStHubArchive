Class {
	#name : #PurePhaROSDrive,
	#superclass : #PurePhaROSNode,
	#instVars : [
		'currentId'
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
PurePhaROSDrive >> initialize [ 
	super initialize.
	currentId := 1.
]

{ #category : #'as yet unclassified' }
PurePhaROSDrive >> moveTo: aPose [
	| array | 

	self sendTo: '/move_base/goal' typedAs: 'move_base_msgs/MoveBaseActionGoal' a: [ :msg | 
		
		msg goal_id id: self consumeId.
		msg goal target_pose pose position x: aPose x.
		msg goal target_pose pose position y: aPose y.
		msg goal target_pose pose position z: 0.0.
		
		array := PhaROSGeometryTransformations new quaternationFromEulerFor: 0.0 and: 0.0 and: aPose orientation .
		msg goal target_pose pose orientation x: (array at:1).
		msg goal target_pose pose orientation y: (array at:2).
		msg goal target_pose pose orientation z: (array at:3).
		msg goal target_pose pose orientation w: (array at:4).

	].
]

{ #category : #'as yet unclassified' }
PurePhaROSDrive >> setUp [
]
