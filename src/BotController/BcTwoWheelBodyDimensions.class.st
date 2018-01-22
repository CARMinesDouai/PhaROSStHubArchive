Class {
	#name : #BcTwoWheelBodyDimensions,
	#superclass : #BcBodyDimensions,
	#instVars : [
		'interWheelsDistance',
		'laserToSideDistance'
	],
	#category : #'BotController-Bodies'
}

{ #category : #'instance creation' }
BcTwoWheelBodyDimensions class >> robulab [
	^self new
		interWheelsDistance: 0.39;
		laserToSideDistance: 0.2;
		yourself
]

{ #category : #'instance creation' }
BcTwoWheelBodyDimensions class >> turtleBot [
	^self new
		interWheelsDistance: 0.23;
		laserToSideDistance: 0.13;
		yourself
]

{ #category : #accessing }
BcTwoWheelBodyDimensions >> interWheelsDistance [
	^interWheelsDistance
]

{ #category : #accessing }
BcTwoWheelBodyDimensions >> interWheelsDistance: anObject [
	interWheelsDistance := anObject
]

{ #category : #accessing }
BcTwoWheelBodyDimensions >> laserToSideDistance [
	^laserToSideDistance
]

{ #category : #accessing }
BcTwoWheelBodyDimensions >> laserToSideDistance: anObject [
	laserToSideDistance := anObject
]
