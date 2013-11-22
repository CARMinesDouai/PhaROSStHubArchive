Class {
	#name : #PhaROSTurtlesimNodelet,
	#superclass : #PhaROSStaticNodelet,
	#instVars : [
		'turtles'
	],
	#category : #PhaROSNodeletsTurtlesim
}

{ #category : #'as yet unclassified' }
PhaROSTurtlesimNodelet >> broadcastTFFor: aTurtleHandle [
	self nodelets pose2tf express: aTurtleHandle poseStamped as: aTurtleHandle frame childOf: PhaROSTurtleHandle frameParent.
]

{ #category : #'as yet unclassified' }
PhaROSTurtlesimNodelet >> callServiceFor: aName [
	| x y |
	x := (Random seed: DateAndTime now asUnixTime)  next; next; nextInt:9 + ((Random seed: DateAndTime now asUnixTime)  next; nextInt:9) / 10.
	
	y := (Random seed: DateAndTime now asUnixTime)  next;next; next; nextInt:9 + ((Random seed: DateAndTime now asUnixTime)  next; next; nextInt:9) / 10.

	^ PhaROSSystemLauncher instance rosserviceCall: {'/spawn' .  x asString  . y asString . '0.0' . '''' , aName, '''' } .
 
]

{ #category : #'as yet unclassified' }
PhaROSTurtlesimNodelet >> configure [
	self nodelets use: PhaROSTransformationNodelet as: #transformation.
	self nodelets use: PhaROSPoseToTFNodelet  as: #pose2tf.	

]

{ #category : #'as yet unclassified' }
PhaROSTurtlesimNodelet >> defaultTurtleHandler [
	^ self turtleHandleFor: 'turtle1'.
]

{ #category : #'as yet unclassified' }
PhaROSTurtlesimNodelet >> initialize [

	super initialize.
	launch := Dictionary new.
]

{ #category : #'as yet unclassified' }
PhaROSTurtlesimNodelet >> spawnTurtle: aName [
	launch at: aName ifAbsentPut: [ 
		self callServiceFor: aName.
	].
	
]

{ #category : #'as yet unclassified' }
PhaROSTurtlesimNodelet >> turtleHandleFor: aTurtleName [
	^ PhaROSTurtleHandle new initializeWith: aTurtleName and: self; yourself.
	
]
