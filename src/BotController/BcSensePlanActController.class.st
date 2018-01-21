"
I am a controller that separates behavior in 3 parts:
-sense
-plan
-act

Each materializes as a method. The plan and act  methods do nothing. Subclasses are likely to override them. While the sense method triggers the worldModelBuilder to update the worldModel. 

I am abstract. Subclasses have to override method worldModelBuilderClass.

The order and threading model for executing the three methods above is defined by the runner. 

My default runner is BcSingleThreadSensePlanActRunner (see class-side method defaultRunner).

Instance Variables
	worldModelBuilder:	<BcWorldModelBuilder> takes care of constructing and updating the world model from sensed data

"
Class {
	#name : #BcSensePlanActController,
	#superclass : #BcController,
	#instVars : [
		'worldModelBuilder'
	],
	#category : #'BotController-Controllers'
}

{ #category : #'instance creation' }
BcSensePlanActController class >> defaultRunnerClass [
	^ BcSingleThreadSensePlanActRunner
]

{ #category : #living }
BcSensePlanActController >> act [
	^self
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
