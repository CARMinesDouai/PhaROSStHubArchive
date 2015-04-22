Class {
	#name : #RrCollisionAvoiderController,
	#superclass : #RrController,
	#instVars : [
		'runaway',
		'forceFusion',
		'sonarForceBuilder',
		'vectorDisplay',
		'irForceBuilder'
	],
	#category : #'ReactiveRobot-CollisionAvoidance'
}

{ #category : #'initialize-release' }
RrCollisionAvoiderController >> initialize [
	| pi |
	super initialize.
	vectorDisplay := VectorDisplay new.
	sonarForceBuilder := RrFilteredForceVectorsBuilder new.
	irForceBuilder := RrFilteredForceVectorsBuilder new.
	pi := VeAngle pi.
	sonarForceBuilder 
		sensorAngles: {pi/12. pi/4. pi/2. 3*pi/4. pi.  -3*pi/4. -1*pi/2. -1*pi/4 . -1*pi/12}.
	irForceBuilder 
		sensorAngles: {pi/12. pi/4. 3*pi/8. pi/2.  5*pi/8. 3*pi/4. 11*pi/12. 
						pi.
						 -11*pi/12. -3*pi/4. -5*pi/8. -1*pi/2. -3*pi/8. -1*pi/4.  -1*pi/12.}.
	forceFusion := RrForceIntegrator new.
	runaway := RrRunaway new.
	self forwardSpeed: 0.1.
	
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

{ #category : #'initialize-release' }
RrCollisionAvoiderController >> speedVector: aVector [
	runaway speedVector: aVector.
	sonarForceBuilder distanceThreshold: (aVector length min: 0.3).
	
]

{ #category : #acting }
RrCollisionAvoiderController >> start [
	vectorDisplay start.
	self robot
		scanIrEvery: 0 
		do: [ :distances| 
			sonarForceBuilder input: distances]

]

{ #category : #acting }
RrCollisionAvoiderController >> stop [
	super stop.
	vectorDisplay stop
]
