Class {
	#name : #BcControllerTest,
	#superclass : #TestCase,
	#instVars : [
		'body',
		'controller',
		'runner'
	],
	#category : #'BotController-Tests'
}

{ #category : #testing }
BcControllerTest >> bodyClass [
	^ BcNullTwoWheelBody
]

{ #category : #testing }
BcControllerTest >> controllerClass [
	self subclassResponsibility
]

{ #category : #testing }
BcControllerTest >> setUp [
	super setUp.
	body := self bodyClass new.
	controller := self controllerClass
		body: body
		runnerClass: BcNullSensePlanActRunner.
	runner := controller runner.
	controller start
]

{ #category : #testing }
BcControllerTest >> tearDown [
	super tearDown.
	controller stop. 
]
