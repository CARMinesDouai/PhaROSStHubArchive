Class {
	#name : #TurtlesimNodelet,
	#superclass : #PhaROSStaticNodelet,
	#instVars : [
		'turtles'
	],
	#category : #'DonatelloPackage-Nodelet'
}

{ #category : #'initialize-release' }
TurtlesimNodelet >> configure [
	self nodelets use: PhaROSTransformationNodelet as: #transformation.
	self nodelets use: PhaROSPoseToTFNodelet  as: #pose2tf.	

]

{ #category : #handler }
TurtlesimNodelet >> defaultTurtleHandler [
	^ self turtleHandleFor: 'turtle1'.
]

{ #category : #handler }
TurtlesimNodelet >> existantTurtleHandleFor: aTurtleName [ 
	^ turtles at: aTurtleName.
]

{ #category : #'initialize-release' }
TurtlesimNodelet >> initialize [

	super initialize.
	turtles := Dictionary new.
]

{ #category : #spawner }
TurtlesimNodelet >> spawnTurtle: aName [ 
	
	
	^ self spawnTurtle: aName at: 10@10.
]

{ #category : #spawner }
TurtlesimNodelet >> spawnTurtle: aName at: aPoint [
	
	(self controller node service: '/spawn' ) call: [ : rqst | 
		rqst x: aPoint x. 
		rqst y: aPoint y. 
		rqst name: aName 
	] .
	^ self turtleHandleFor: aName.
]

{ #category : #handler }
TurtlesimNodelet >> turtleHandleFor: aTurtleName [
	^ turtles at: aTurtleName ifAbsent:[
		 TurtleHandle new initializeWith: aTurtleName and: self; yourself.
	]
]
