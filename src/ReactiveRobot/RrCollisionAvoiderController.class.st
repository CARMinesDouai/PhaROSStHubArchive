Class {
	#name : #RrCollisionAvoiderController,
	#superclass : #RrController,
	#instVars : [
		'runaway',
		'forceFusion',
		'sonarForceBuilder',
		'vectorDisplay',
		'sonarValuesFilter'
	],
	#category : #'ReactiveRobot-CollisionAvoidance'
}

{ #category : #'initialize-release' }
RrCollisionAvoiderController >> initialize [
	| pi |
	super initialize.
	vectorDisplay := VectorDisplay new.
	sonarValuesFilter := RrAverageFilter new.
	sonarForceBuilder := RrForceVectorsBuilder new.
	pi := Float pi.
	sonarForceBuilder 
		sensorAngles: {pi/12. pi/4. pi/2. 3*pi/4. pi.  -3*pi/4. -1*pi/2. -1*pi/4 . -1*pi/12};
		distanceThreshold: 0.4.
	forceFusion := RrForceIntegrator new.
	runaway := RrRunaway new.
	runaway forwardSpeed: 0.1.
	
	sonarValuesFilter => sonarForceBuilder.
	sonarForceBuilder => forceFusion.
	forceFusion => runaway.
	forceFusion connect: #outputPort to: #drawObstacle:  of: vectorDisplay.
	runaway connect: #outputPort to: #drawSpeed:  of: vectorDisplay 

]

{ #category : #'initialize-release' }
RrCollisionAvoiderController >> robot: aRobot [
	super robot: aRobot.
	runaway connect: #outputPort to: #speedVector: of: aRobot
]

{ #category : #acting }
RrCollisionAvoiderController >> start [
	vectorDisplay start.
	self robot
		scanSonarsEvery: 0 
		do: [ :distances| 
			sonarValuesFilter input: distances]

]

{ #category : #acting }
RrCollisionAvoiderController >> stop [
	super stop.
	vectorDisplay stop
]
