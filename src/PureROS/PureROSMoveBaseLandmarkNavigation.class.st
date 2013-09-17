Class {
	#name : #PureROSMoveBaseLandmarkNavigation,
	#superclass : #PhaROSStaticNodelet,
	#instVars : [
		'robulab',
		'currentGoal'
	],
	#category : #'PureROS-Nodelets'
}

{ #category : #'as yet unclassified' }
PureROSMoveBaseLandmarkNavigation class >> baseLandmarksTopicName [ 
	^ '/stargazer/baselink'
]

{ #category : #'as yet unclassified' }
PureROSMoveBaseLandmarkNavigation >> baseLandmark [
	^ self rosnode topicPublisher: PureROSMoveBaseLandmarkNavigation baseLandmarksTopicName typedAs: SGROSStarGazerNodelet absoluteLandmarkTopicType.
]

{ #category : #'as yet unclassified' }
PureROSMoveBaseLandmarkNavigation >> baseLandmarks [

	^ (self rosnode buildConnectionFor: PureROSMoveBaseLandmarkNavigation baseLandmarksTopicName  ) 
					typedAs: SGROSStarGazerNodelet absoluteLandmarkTopicType ; 
					connect.
					
]

{ #category : #'as yet unclassified' }
PureROSMoveBaseLandmarkNavigation >> goTo: anEntity [
	| destinationPose |
	
	currentGoal ifNotNil: [ currentGoal cancel. currentGoal := nil ].
	
	
	currentGoal := PureROSRobulabGoal new entity: anEntity; robulab: robulab ; configure; yourself .
	
	^ currentGoal.
]

{ #category : #'as yet unclassified' }
PureROSMoveBaseLandmarkNavigation >> robulab:  aRobulabNodelet [
	robulab := aRobulabNodelet.
	robulab nodelets use: SGStargazerEventManager as: #sgevents.
	
	
	
	 
]
