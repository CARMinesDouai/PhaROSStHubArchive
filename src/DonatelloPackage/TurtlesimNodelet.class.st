Class {
	#name : #TurtlesimNodelet,
	#superclass : #PhaROSStaticNodelet,
	#category : #'DonatelloPackage-Nodelet'
}

{ #category : #handler }
TurtlesimNodelet >> broadcastTFFor: aTurtleHandle [
	self nodelets pose2tf express: aTurtleHandle poseStamped as: aTurtleHandle frame childOf: TurtleHandle frameParent.
]

{ #category : #handler }
TurtlesimNodelet >> chooseAnObjectiveForPursuitFor: aHandle [
	| possible |
	possible := TurtleHandle allInstances reject: [ :h | h == aHandle].
	(possible size > 0 ) ifFalse: [ self error: 'There are not pursuitable targets' ].
	^ possible shuffle  at: 1.
	
]

{ #category : #'initialize-release' }
TurtlesimNodelet >> configure [
	self nodelets use: PhaROSTransformationNodelet as: #transformation.
	self nodelets use: PhaROSPoseToTFNodelet  as: #pose2tf.	

]

{ #category : #handler }
TurtlesimNodelet >> defaultTurtleHandler [
	^ self turtleHandleFor: 'turtle1'.
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
	^ TurtleHandle new initializeWith: aTurtleName and: self; yourself.
]
