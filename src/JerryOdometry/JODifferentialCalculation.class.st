"
Based on the following equations

	X t+1 = X t + V t * delta T * cos(theta t).
	Y t+1 = Y t + V t * delta T * sen(theta t).
	theta t+1 = theta t + A * delta T.
	

	(
	
	V : linear velocity
	A : angular velocity 
	theta:  rotation angle 
	)
"
Class {
	#name : #JODifferentialCalculation,
	#superclass : #Object,
	#instVars : [
		'lastTimeMeasure',
		'position',
		'orientation',
		'linearAcceleration',
		'linearVelocity',
		'angularAcceleration',
		'angularVelocity'
	],
	#category : #JerryOdometry
}

{ #category : #'as yet unclassified' }
JODifferentialCalculation >> angularAcceleration [
	^ angularAcceleration
]

{ #category : #'as yet unclassified' }
JODifferentialCalculation >> angularVelocity [
	^  angularVelocity
]

{ #category : #'as yet unclassified' }
JODifferentialCalculation >> distanceThreshold [ 
	^ 1.
]

{ #category : #'as yet unclassified' }
JODifferentialCalculation >> linearAcceleration [ 	
	^ linearAcceleration.
]

{ #category : #'as yet unclassified' }
JODifferentialCalculation >> linearVelocity [ 
	^ linearVelocity
]

{ #category : #'as yet unclassified' }
JODifferentialCalculation >> noticeMovementFrom: aPoint to: aNewPoint [ 

	| currentTimeMeasure enlapedTime currentAngularVelocity currentLinearVelocity currentPosition  | 
	
	currentTimeMeasure := DateAndTime now. 
	
	lastTimeMeasure ifNotNil: [
		
		enlapedTime := (currentTimeMeasure - lastTimeMeasure) asNanoSeconds * 1000000. 	
		currentLinearVelocity := (aNewPoint x - aPoint x) / enlapedTime.	" pixels per second "
		currentAngularVelocity := (aNewPoint y - aPoint y) / enlapedTime. " pixels per second "
		
		linearAcceleration := (currentLinearVelocity - linearVelocity ) / enlapedTime.
		angularAcceleration := (currentAngularVelocity - angularVelocity) / enlapedTime.
		
		currentPosition := (position x + (currentLinearVelocity * enlapedTime  * orientation cos )) @ 
						    (position y + (currentLinearVelocity * enlapedTime  * orientation sin )).
						
		
		(position dist: currentPosition ) < self distanceThreshold ifTrue: [
			linearVelocity := currentLinearVelocity.
			angularVelocity := currentAngularVelocity.
			position := currentPosition.
		].
		
	].

	lastTimeMeasure := currentTimeMeasure.
]

{ #category : #'as yet unclassified' }
JODifferentialCalculation >> orientation [ 
^orientation
]

{ #category : #'as yet unclassified' }
JODifferentialCalculation >> position [
^position
]
