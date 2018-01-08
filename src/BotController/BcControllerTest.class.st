Class {
	#name : #BcControllerTest,
	#superclass : #TestCase,
	#traits : 'NeTWait',
	#classTraits : 'NeTWait classTrait',
	#instVars : [
		'body',
		'controller'
	],
	#category : #'BotController-Controllers'
}

{ #category : #testing }
BcControllerTest >> controllerClass [
	self subclassResponsibility
]

{ #category : #testing }
BcControllerTest >> setUp [
	super setUp.
	body := BcNullTwoWheelBody new.
	controller := self controllerClass body: body.
	controller start.
	self waitUntilRobotStarted
]

{ #category : #testing }
BcControllerTest >> tearDown [
	super tearDown.
	controller stop. 
]

{ #category : #testing }
BcControllerTest >> waitUntilRobotStarted [
	self
		waitWhile: [ body forwardSpeed isNil ]
		timeout: self defaultTimeoutDuration
]
