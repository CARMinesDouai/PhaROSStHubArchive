Class {
	#name : #BcSpeedRampTest,
	#superclass : #TestCase,
	#instVars : [
		'ramp'
	],
	#category : #'BotController-OLD-Tests'
}

{ #category : #testing }
BcSpeedRampTest >> setUp [
	super setUp.
	ramp := BcSpeedRamp valuesCount: 10.
	ramp body: BcTurtleBotMock new
]

{ #category : #testing }
BcSpeedRampTest >> testRamping [
	ramp leftSpeed: 1 rightSpeed: 1.
	self assert: ramp leftSpeed asFloat equals: 0.1.
	self assert: ramp rightSpeed asFloat equals: 0.1.
	ramp leftSpeed: 1 rightSpeed: 1.
	self assert: ramp leftSpeed asFloat equals: 0.19.
	self assert: ramp rightSpeed asFloat equals: 0.19.

]

{ #category : #testing }
BcSpeedRampTest >> testReset [
	ramp leftSpeed: 1 rightSpeed: 1.
	self assert: ramp leftSpeed asFloat equals: 0.1.
	self assert: ramp rightSpeed asFloat equals: 0.1.
	ramp reset.
	ramp leftSpeed: 1 rightSpeed: 1.
	self assert: ramp leftSpeed asFloat equals: 0.1.
	self assert: ramp rightSpeed asFloat equals: 0.1
]
