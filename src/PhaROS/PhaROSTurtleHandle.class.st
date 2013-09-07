Class {
	#name : #PhaROSTurtleHandle,
	#superclass : #Object,
	#instVars : [
		'sim',
		'name',
		'velocityOut',
		'color',
		'pose',
		'processHandler'
	],
	#category : #'PhaROS-Nodelets-Turtlebot'
}

{ #category : #'as yet unclassified' }
PhaROSTurtleHandle >> algorithm: aBlock [
	 processHandler := [aBlock cull: self ] doIt asStickyReference.
]

{ #category : #'as yet unclassified' }
PhaROSTurtleHandle >> color [
	^ color.
]

{ #category : #'as yet unclassified' }
PhaROSTurtleHandle >> currentColor: aColor [
	color := aColor. 
]

{ #category : #'as yet unclassified' }
PhaROSTurtleHandle >> currentPose: aPose [
	pose := PhaROSPose fromTurtlesimPose: aPose.
]

{ #category : #'as yet unclassified' }
PhaROSTurtleHandle >> finalize [ 
	processHandler := nil.
]

{ #category : #'as yet unclassified' }
PhaROSTurtleHandle >> forwardAt: aSpeed [
	self moveAt: aSpeed and: 0.0. 
]

{ #category : #'as yet unclassified' }
PhaROSTurtleHandle >> initializeWith: aName and: aSim [
	name:= aName.
	sim := aSim.
	
	velocityOut := sim rosnode topicPublisher: '/', aName, '/command_velocity' typedAs: 'turtlesim/Velocity'.
	(sim rosnode buildConnectionFor: '/',aName,'/color_sensor') 
			typedAs: 'turtlesim/Color'; 
			for: [ : aColor | self currentColor: aColor ];
	 		connect.
			
	(sim rosnode buildConnectionFor: '/',aName,'/pose') 
			typedAs: 'turtlesim/Pose'; 
			for: [ : aPose | self currentPose: aPose ];
			connect.
	
	self moveAt: 0.0 and: 0.0. 
]

{ #category : #'as yet unclassified' }
PhaROSTurtleHandle >> moveAt: aLinearSpeed and: anAngularSpeed [
	velocityOut send: [ :msg | 
		msg linear: aLinearSpeed.
		msg angular: anAngularSpeed.	
	].
]

{ #category : #'as yet unclassified' }
PhaROSTurtleHandle >> pose [
	^ pose.
]

{ #category : #'as yet unclassified' }
PhaROSTurtleHandle >> rotateAt: aSpeed [
	self moveAt: 0.0 and: aSpeed. 
]
