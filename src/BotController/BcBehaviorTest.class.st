Class {
	#name : #BcBehaviorTest,
	#superclass : #TestCase,
	#instVars : [
		'body',
		'behavior'
	],
	#category : #'BotController-Tests'
}

{ #category : #testing }
BcBehaviorTest >> behaviorClass [
	self subclassResponsibility 
]

{ #category : #testing }
BcBehaviorTest >> setUp [
	super setUp.
	behavior := self behaviorClass new.
	body := BcTurtleBotMock new.
	behavior body: body
]
