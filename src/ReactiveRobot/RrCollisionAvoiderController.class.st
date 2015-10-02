Class {
	#name : #RrCollisionAvoiderController,
	#superclass : #RrController,
	#instVars : [
		'runaway',
		'sonarFeelForce',
		'irFeelForce',
		'laserFeelForce'
	],
	#category : #'ReactiveRobot-02-CollisionAvoidance'
}

{ #category : #accessing }
RrCollisionAvoiderController >> forwardAt: linearSpeed rotateAt: rotationSpeed [
	laserFeelForce threshold: (linearSpeed max: 0.3).
	runaway speedVector: (VeVector length: linearSpeed angle: rotationSpeed)
]

{ #category : #'initialize-release' }
RrCollisionAvoiderController >> initialize [
	super initialize.
	sonarFeelForce := RrFeelForce new.
	irFeelForce := RrFeelForce new.
	laserFeelForce := RrFeelForce new.
	runaway := RrRunaway new.
	laserFeelForce => runaway.	
	runaway connectTo: #speedVector: of: self.

]

{ #category : #accessing }
RrCollisionAvoiderController >> robot: aRobot [
	super robot: aRobot.
	sonarFeelForce  vectorAngles: robot sonarsAngles.
	irFeelForce vectorAngles: robot irAngles.
	laserFeelForce vectorAngles: robot laserAngles.
	robot connect: #irPort to: #input: of: irFeelForce.
	robot connect: #sonarsPort to: #input: of: sonarFeelForce.
	robot connect: #laserPort to: #input: of: laserFeelForce.
	
]

{ #category : #accessing }
RrCollisionAvoiderController >> speedVector: speedVector [
	super forwardAt: speedVector length rotateAt: speedVector angle.
	self startMotion.
	Transcript cr; show: speedVector.
]
