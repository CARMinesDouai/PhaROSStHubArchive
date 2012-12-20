Class {
	#name : #PurePhaROSNode,
	#superclass : #PhaROSNode,
	#traits : 'TLogger',
	#classTraits : 'TLogger classTrait',
	#instVars : [
		'robot'
	],
	#category : #PureROS
}

{ #category : #'as yet unclassified' }
PurePhaROSNode class >> with: aRobot [ 
	^ self new robot: aRobot ; setUp; yourself.
]

{ #category : #'as yet unclassified' }
PurePhaROSNode >> robot: aPureBasedRobot [
	robot := aPureBasedRobot.
	
]
