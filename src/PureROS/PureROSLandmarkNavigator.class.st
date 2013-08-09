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
	| pose |
	currentLandmark ifNotNil: [
		currentLandmark id = landMark landmark ifTrue: [
			currentGoal cancel.	
			(PNGTrajectoryServiceBasedController for: robulab robot)  goToDelta: landMark pose position x @ landMark pose position y.
		].
	].
	pose := PhaROSPose fromGeometry_msgsPose: landMark pose.
	pose position  module2d < 1.0 ifTrue: [
		 self halt. 
		robulab initialPose: (self computeCurrentPose: pose relatedTo: landMark landmark  ).
	].
	

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
	self halt.
	robulab nodelets stargazer landmarks for: [ : landMark :chn :tstmp | self checkGoal: landMark at: tstmp ]
]
