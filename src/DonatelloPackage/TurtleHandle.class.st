Class {
	#name : #TurtleHandle,
	#superclass : #Object,
	#instVars : [
		'name',
		'velocityOut',
		'color',
		'pose',
		'processHandler',
		'turtlesimNodelet'
	],
	#category : #'DonatelloPackage-Nodelet'
}

{ #category : #'as yet unclassified' }
TurtleHandle class >> frameParent [
	^ '/world'
]

{ #category : #control }
TurtleHandle >> algorithm: aBlock [
	processHandler ifNotNil:[
		processHandler finalize.
	].

	 processHandler := [aBlock cull: self cull: turtlesimNodelet ] shootIt asStickyReference.
]

{ #category : #accessing }
TurtleHandle >> color [
	^ color.
]

{ #category : #accessing }
TurtleHandle >> currentColor: aColor [
	color := aColor. 
]

{ #category : #accessing }
TurtleHandle >> currentPose: aPose [
	pose := PhaROSPose fromTurtlesimPose: aPose.
]

{ #category : #finalization }
TurtleHandle >> finalize [ 
	processHandler := nil.
]

{ #category : #control }
TurtleHandle >> forwardAt: aSpeed [
	self moveAt: aSpeed and: 0.0. 
]

{ #category : #accessing }
TurtleHandle >> frame [

	^ '/', name normalizeFrame.
]

{ #category : #'initialize-release' }
TurtleHandle >> initializeWith: aName and: aTurtlesimNodelet [
	name:= aName.
	turtlesimNodelet := aTurtlesimNodelet.
	
	velocityOut := turtlesimNodelet rosnode topicPublisher: '/', aName, '/command_velocity' typedAs: 'turtlesim/Velocity'.
	(turtlesimNodelet rosnode buildConnectionFor: '/',aName,'/color_sensor') 
			typedAs: 'turtlesim/Color'; 
			for: [ : aColor | self currentColor: aColor ];
	 		connect.
			
	(turtlesimNodelet rosnode buildConnectionFor: '/',aName,'/pose') 
			typedAs: 'turtlesim/Pose'; 
			for: [ : aPose | self currentPose: aPose ];
			connect.
	
	self moveAt: 0.0 and: 0.0. 
]

{ #category : #control }
TurtleHandle >> moveAt: aLinearSpeed and: anAngularSpeed [
	velocityOut send: [ :msg | 
		msg linear: aLinearSpeed.
		msg angular: anAngularSpeed.	
	].
]

{ #category : #accessing }
TurtleHandle >> pose [
	^ pose.
]

{ #category : #'topic-reading' }
TurtleHandle >> poseStamped [
		^(turtlesimNodelet rosnode buildConnectionFor: '/',name,'/pose') 
			typedAs: 'turtlesim/Pose'; 
			adapted: PhaROSPose;
			connect.
	
]

{ #category : #control }
TurtleHandle >> rotateAt: aSpeed [
	self moveAt: 0.0 and: aSpeed. 
]

{ #category : #control }
TurtleHandle >> tf [
	turtlesimNodelet broadcastTFFor: self.
]

{ #category : #'as yet unclassified' }
TurtleHandle >> transformationTo: aTurtleHandle [
 	^ turtlesimNodelet nodelets transformation transformBetween: aTurtleHandle frame and: self frame.
]
