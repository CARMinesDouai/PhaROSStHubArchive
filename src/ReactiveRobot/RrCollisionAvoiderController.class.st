Class {
	#name : #RrCollisionAvoiderController,
	#superclass : #RrController,
	#instVars : [
		'runaway',
		'sonarFeelForce',
		'irFeelForce'
	],
	#category : #'ReactiveRobot-02-CollisionAvoidance'
}

{ #category : #accessing }
RrCollisionAvoiderController >> forwardAt: linearSpeed rotateAt: rotationSpeed [
	runaway speedVector: (VeVector length: linearSpeed angle: rotationSpeed)
]

{ #category : #'initialize-release' }
RrCollisionAvoiderController >> initialize [
	| pi |
	super initialize.
	sonarFeelForce := RrFeelForce new.
	irFeelForce := RrFeelForce new.
	pi := VeAngle pi.
	sonarFeelForce 
		vectorAngles: {pi/12. pi/4. pi/2. 3*pi/4. pi.  -3*pi/4. -1*pi/2. -1*pi/4 . -1*pi/12}.
	irFeelForce 
		vectorAngles: {0.
						pi/12. pi/4. 3*pi/8. pi/2.  5*pi/8. 3*pi/4. 11*pi/12. 
						pi.
						 -11*pi/12. -3*pi/4. -5*pi/8. -1*pi/2. -3*pi/8. -1*pi/4.  -1*pi/12.}.
	runaway := RrRunaway new.
	irFeelForce => runaway.	
	runaway connectTo: #speedVector: of: self.

]

{ #category : #accessing }
RrCollisionAvoiderController >> robot: aRobot [
	super robot: aRobot.
	robot connect: #irPort to: #input: of: irFeelForce.
"	robot connect: #sonarsPort to: #input: of: sonarStopTrigger.
	robot connect: #laserPort to: #input: of: laserStopTrigger.
"	
]

{ #category : #accessing }
RrCollisionAvoiderController >> speedVector: speedVector [
	super forwardAt: speedVector length rotateAt: speedVector angle.
	self startMotion.
]
