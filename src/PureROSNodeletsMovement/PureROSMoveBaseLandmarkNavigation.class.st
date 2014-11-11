Class {
	#name : #PureROSMoveBaseLandmarkNavigation,
	#superclass : #PhaROSStaticNodelet,
	#instVars : [
		'robulab',
		'currentGoal'
	],
	#category : #PureROSNodeletsMovement
}

{ #category : #'as yet unclassified' }
PureROSMoveBaseLandmarkNavigation class >> baseLandmarksTopicName [ 
	^ '/stargazer/baselink'
]

{ #category : #'topic-consume' }
PureROSMoveBaseLandmarkNavigation >> baseLandmark [
	^ self rosnode topicPublisher: PureROSMoveBaseLandmarkNavigation baseLandmarksTopicName typedAs: SGROSStarGazerNodelet absoluteLandmarkTopicType.
]

{ #category : #'topic-subscription' }
PureROSMoveBaseLandmarkNavigation >> baseLandmarks [

	^ (self rosnode buildConnectionFor: PureROSMoveBaseLandmarkNavigation baseLandmarksTopicName  ) 
					typedAs: SGROSStarGazerNodelet absoluteLandmarkTopicType ; 
					connect.
					
]

{ #category : #'topic-consume' }
PureROSMoveBaseLandmarkNavigation >> goTo: anEntity [
	| destinationPose |
	
	currentGoal ifNotNil: [ currentGoal cancel. currentGoal := nil ].
	currentGoal := PureROSRobulabGoal new entity: anEntity; robulab: robulab ; configure; yourself .
	currentGoal onSucceeded: [ currentGoal := nil ].
	^ currentGoal.
]

{ #category : #'topic-consume' }
PureROSMoveBaseLandmarkNavigation >> robulab:  aRobulabNodelet [
	robulab := aRobulabNodelet.
	robulab nodelets use: PhaROSSpaceEventManager as: #spaceEvents.
	self flag: #flag.
	" REMEMBER TO CONFIGURE THE SPACE SENSOR "
]
