Class {
	#name : #PureROSLandmarkNavigator,
	#superclass : #Object,
	#instVars : [
		'currentGoal',
		'currentLandmark',
		'robulab'
	],
	#category : #'PureROS-Nodelet'
}

{ #category : #'as yet unclassified' }
PureROSLandmarkNavigator >> checkGoal: landMark at: tstmp [
	| pose  |
	
	pose := PhaROSPose fromGeometry_msgsPose: landMark pose.
	
	currentLandmark ifNotNil: [
		(currentLandmark id = landMark landmark and:[ (DateAndTime now - tstmp ) asMilliSeconds < 300]) ifTrue: [
			
			|  th rotated |
			
			currentGoal cancel.	
			th := robulab robot localizationService currentPosition orientation.
			
			rotated := pose position rotate: th.
			
			(PNGTrajectoryServiceBasedController for: robulab robot)  goToDelta: rotated x @ rotated y.
		].
	].


"	pose := PhaROSPose fromGeometry_msgsPose: landMark pose.
	pose position  module2d < 1.0 ifTrue: [
		 self halt. 
		robulab initialPose: (self computeCurrentPose: pose relatedTo: landMark landmark  ).
	].
	
"
]

{ #category : #'as yet unclassified' }
PureROSLandmarkNavigator >> computeCurrentPose: aPose relatedTo: aLandmarkID [ 
	^ (robulab nodelets localizer entity: aLandmarkID) locate: aPose.
]

{ #category : #'as yet unclassified' }
PureROSLandmarkNavigator >> goTo: anEntity [
	currentLandmark := anEntity.
	currentGoal := robulab nodelets movebase client goTo: anEntity center asPose.
	
]

{ #category : #'as yet unclassified' }
PureROSLandmarkNavigator >> robulab:  aRobulabNodelet [
	robulab := aRobulabNodelet.
	robulab nodelets stargazer landmarks for: [ : landMark :chn :tstmp | self checkGoal: landMark at: tstmp ]
]
