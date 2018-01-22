"
I am a controller that separates behavior in 3 parts:
-sense
-plan
-act

The order and threading model for executing the three methods above is defined by the runner. 

My default runner is BcSingleThreadSensePlanActRunner (see class-side method defaultRunner).

Each materializes as a method. 
-sense 
Triggers the worldModelBuilder to update the worldModel. 
-plan 
Does nothing. Subclasses are likely to override it. 
-act
Performs the currentAction

Instance Variables
	currentAction:		<BcAction> action eformed at the act step (see act message)
	worldModelBuilder:	<BcWorldModelBuilder> takes care of constructing and updating the world model from sensed data

I am abstract. Subclasses have to override method worldModelBuilderClass.
Subclasses are also likely to override the plan method that is left empty here.


"
Class {
	#name : #BcSensePlanActController,
	#superclass : #BcController,
	#instVars : [
		'worldModelBuilder',
		'currentAction'
	],
	#category : #'BotController-Controllers'
}

{ #category : #'instance creation' }
BcSensePlanActController class >> defaultRunnerClass [
	^ BcSingleThreadSensePlanActRunner
]

{ #category : #living }
BcSensePlanActController >> act [
	self currentAction perform
]

{ #category : #accessing }
BcSensePlanActController >> currentAction [
	^ currentAction
]

{ #category : #accessing }
BcSensePlanActController >> currentAction: anObject [
	^ currentAction := anObject
]

{ #category : #'initialize-release' }
BcSensePlanActController >> initialize [
	super initialize.
	self worldModelBuilder: (self worldModelBuilderClass controller: self)
]

{ #category : #living }
BcSensePlanActController >> plan [
	^self
]

{ #category : #living }
BcSensePlanActController >> sense [
	self worldModelBuilder updateWorldModel
]

{ #category : #accessing }
BcSensePlanActController >> worldModel [
	^self worldModelBuilder worldModel
]

{ #category : #accessing }
BcSensePlanActController >> worldModelBuilder [
	^ worldModelBuilder
]

{ #category : #accessing }
BcSensePlanActController >> worldModelBuilder: anObject [
	worldModelBuilder := anObject
]

{ #category : #'initialize-release' }
BcSensePlanActController >> worldModelBuilderClass [
	self subclassResponsibility
]
