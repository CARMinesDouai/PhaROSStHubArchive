Class {
	#name : #RrCollisionAvoiderController,
	#superclass : #RrController,
	#instVars : [
		'runaway',
		'forceFusion',
		'sonarForceBuilder'
	],
	#category : #'ReactiveRobot-CollisionAvoidance'
}

{ #category : #'initialize-release' }
RrCollisionAvoiderController >> initialize [
	| pi leftAngles rightAngles |
	super initialize.
	sonarForceBuilder := RrForceVectorsBuilder new.
	pi := Float pi.
	leftAngles := {pi/12. pi/4. pi/2. 3*pi/4}.
	rightAngles := leftAngles collect: [ :angle| angle negated ].
	sonarForceBuilder 
		sensorAngles: leftAngles, rightAngles, { pi };
		distanceThreshold: 0.5.
	forceFusion := RrForceIntegrator new.
	runaway := RrRunaway new.
	runaway forwardSpeed: 0.1.
	sonarForceBuilder => forceFusion.
	forceFusion => runaway.

]

{ #category : #'initialize-release' }
RrCollisionAvoiderController >> robot: aRobot [
	super robot: aRobot.
	runaway connect: #outputPort to: #speedVector: of: aRobot
]

{ #category : #acting }
RrCollisionAvoiderController >> start [
	self robot
		scanSonarsEvery: 0 
		do: [ :distances| 
			sonarForceBuilder input: distances]

]
