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

	currentLandmark ifNotNil: [
		currentLandmark id = landMark landmark ifTrue: [
			currentGoal cancel.	
			(PNGTrajectoryServiceBasedController for: robulab robot)  goToDelta: landMark pose position x @ landMark pose position y.
		].
	].
	landMark pose position module2d < 20.0 ifTrue: [
		 self halt. 
		robulab nodelets amcl initialPose: #calculateInitialPoseHere.
	].
	

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
