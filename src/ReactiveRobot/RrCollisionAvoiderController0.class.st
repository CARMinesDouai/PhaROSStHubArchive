Class {
	#name : #RrCollisionAvoiderController0,
	#superclass : #RrController,
	#instVars : [
		'runaway',
		'forceFusion',
		'sonarForceBuilder',
		'vectorDisplay',
		'irForceBuilder'
	],
	#category : #'ReactiveRobot-02-CollisionAvoidance'
}

{ #category : #'initialize-release' }
RrCollisionAvoiderController0 >> forwardAt: aNumber [
	self speedVector: (VeVector length: aNumber)
]

{ #category : #'initialize-release' }
RrCollisionAvoiderController0 >> initialize [
	| pi |
	super initialize.
	sonarForceBuilder := RrFilteredForceVectorsBuilder new.
	irForceBuilder := RrFilteredForceVectorsBuilder new.
	pi := VeAngle pi.
	sonarForceBuilder 
		vectorAngles: {pi/12. pi/4. pi/2. 3*pi/4. pi.  -3*pi/4. -1*pi/2. -1*pi/4 . -1*pi/12}.
	irForceBuilder 
		vectorAngles: {pi/12. pi/4. 3*pi/8. pi/2.  5*pi/8. 3*pi/4. 11*pi/12. 
						pi.
						 -11*pi/12. -3*pi/4. -5*pi/8. -1*pi/2. -3*pi/8. -1*pi/4.  -1*pi/12.}.
	forceFusion := RrForceIntegrator new.
	runaway := RrRunaway new.
	self forwardAt: 0.1.
	
	sonarForceBuilder => forceFusion.
	forceFusion => runaway.

]

{ #category : #'initialize-release' }
RrCollisionAvoiderController0 >> robot: aRobot [
	super robot: aRobot.
	self robot connect: #sonarsPort to: #input: of: sonarForceBuilder
]

{ #category : #'initialize-release' }
RrCollisionAvoiderController0 >> speedVector: aVector [
	runaway speedVector: aVector.
	sonarForceBuilder threshold: ((2* aVector length) max: 0.3).
	
]
