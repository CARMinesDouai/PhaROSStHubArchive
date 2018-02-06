"
I aam an action peformed by a robot. I am perfomed typically whe it is time to Act, for example in a controller that does Sense-Plan-Act.

A robot controller can have multiple actions and decide which one to perform depending on some rule.

 I include one or more commands to actuators via the body. The commandes can be computed based on the world model

I am an abstract class. My subclasses must override:
- perform
Send commands to actuators

"
Class {
	#name : #BcAction,
	#superclass : #BcControllerPart,
	#category : #'BotController-Actions'
}

{ #category : #'instance creation' }
BcAction class >> controller: aController [
	^self new
		controller: aController;
		yourself
]

{ #category : #stepping }
BcAction >> perform [
	self subclassResponsibility
]

{ #category : #accessing }
BcAction >> worldModel [
	^self controller worldModel
]
