Class {
	#name : #PurePhaROSNode,
	#superclass : #PhaROSNode,
	#instVars : [
		'robot',
		'pureRos'
	],
	#category : #'PureROS-Deprecated'
}

{ #category : #'as yet unclassified' }
PurePhaROSNode class >> with: aRobot [ 
	^ self new robot: aRobot ; setUp; yourself.
]

{ #category : #'as yet unclassified' }
PurePhaROSNode >> pureRos [ 
	^ pureRos 
]

{ #category : #'as yet unclassified' }
PurePhaROSNode >> pureRos: aPureROS [
	pureRos := aPureROS 
]

{ #category : #'as yet unclassified' }
PurePhaROSNode >> robot: aPureBasedRobot [
	robot := aPureBasedRobot.
	
]
