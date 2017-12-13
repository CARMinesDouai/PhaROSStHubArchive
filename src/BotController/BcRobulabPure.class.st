Class {
	#name : #BcRobulabPure,
	#superclass : #BcTwoWheelBody,
	#instVars : [
		'serviceRegistry'
	],
	#category : #'BotController-Body'
}

{ #category : #'instance creation' }
BcRobulabPure class >> robulab1 [
	"self robulab1"
	^self serviceRegistry: PNGRobulab kompai1
]

{ #category : #'instance creation' }
BcRobulabPure class >> robulab2 [
	"self robulab2"
	^self serviceRegistry: PNGRobulab kompai2
]

{ #category : #'instance creation' }
BcRobulabPure class >> serviceRegistry: aPNGRobulab [
	^self new
		serviceRegistry: aPNGRobulab;
		yourself
]

{ #category : #actions }
BcRobulabPure >> interWheelsDistance [
	^0.4
]

{ #category : #accessing }
BcRobulabPure >> maxForwardLateralSpeed [
	^1
]

{ #category : #accessing }
BcRobulabPure >> minBackwardLateralSpeed [
	^-0.1
	
]

{ #category : #accessing }
BcRobulabPure >> minForwardLateralSpeed [
	self shouldBeImplemented
]

{ #category : #actions }
BcRobulabPure >> velocityForward: forwardSpeed rotation: rotationSpeed [
	serviceRegistry differentialService moveAt: forwardSpeed and: rotationSpeed
]
