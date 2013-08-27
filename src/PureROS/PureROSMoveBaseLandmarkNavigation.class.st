Class {
	#name : #PureROSMoveBaseLandmarkNavigation,
	#superclass : #PhaROSStaticNodelet,
	#instVars : [
		'currentGoal',
		'robulab',
		'currentEvent'
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
	currentEvent ifNotNil: [ currentEvent cancel. currentEvent := nil ].
	
	currentGoal := PureROSRobulabGoal new entity: anEntity; goal: (robulab nodelets movebase client goTo: anEntity center asPose); robulab: robulab ; yourself .
	
	currentEvent := robulab nodelets sgevents whenLandmark: [ :lmk | currentGoal hasArrived: lmk. ] doOnce: [ : lmk | currentGoal onArrivalToLandmark: lmk ].
]

{ #category : #'as yet unclassified' }
PureROSMoveBaseLandmarkNavigation >> robulab:  aRobulabNodelet [
	robulab := aRobulabNodelet.
	robulab nodelets use: SGStargazerEventManager as: #sgevents.
	robulab nodelets use: PureROSBaseLandmarkEvent  as: #baseevents.
	robulab nodelets stargazer mergeWithPose: robulab poseStamped  to: self baseLandmark.
	
	 
]
