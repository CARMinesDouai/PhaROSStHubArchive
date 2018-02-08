"
I build and update a world model based on some sensory data I get from the robot body.

Public API and Key Messages

-worldModel
The latest ready to use world model
-updateWorldModel
Trigger refreshing the world model

I am an abstract class. Subclasses should define:
-newWorldModel
Build a new world model based on the latest sensory data read from the robot body.
-worldModelClass
Answers the class for creating a new world model

    Instance Variables
	worldModel:		<BcWorldModel> The latest ready to use world model


    Implementation Points
"
Class {
	#name : #BcWorldModelBuilder,
	#superclass : #BcControllerPart,
	#instVars : [
		'worldModel'
	],
	#category : #'BotController-WorldModel'
}

{ #category : #building }
BcWorldModelBuilder >> newWorldModel [
	self subclassResponsibility
]

{ #category : #building }
BcWorldModelBuilder >> updateWorldModel [
	self worldModel: self newWorldModel
]

{ #category : #accessing }
BcWorldModelBuilder >> worldModel [
	^ worldModel
]

{ #category : #accessing }
BcWorldModelBuilder >> worldModel: anObject [
	worldModel := anObject
]

{ #category : #building }
BcWorldModelBuilder >> worldModelClass [
	self subclassResponsibility
]
