Class {
	#name : #PurePhaROSNode,
	#superclass : #PhaROSNode,
	#instVars : [
		'robot'
	],
	#category : #Pure
}

{ #category : #'as yet unclassified' }
PurePhaROSNode class >> with: aRobot [ 
	^ self new robot: aRobot ; setUp; yourself.
]

{ #category : #'as yet unclassified' }
PurePhaROSNode >> robot: aPureBasedRobot [
	robot := aPureBasedRobot.
	
]
