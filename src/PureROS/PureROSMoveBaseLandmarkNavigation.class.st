Class {
	#name : #PureROSMoveBaseLandmarkNavigation,
	#superclass : #PhaROSStaticNodelet,
	#instVars : [
		'currentGoal',
		'currentLandmark',
		'robulab',
		'currentEvent'
	],
	#category : #'PureROS-Nodelets'
}

{ #category : #'as yet unclassified' }
PureROSMoveBaseLandmarkNavigation >> checkGoal: landMark at: tstmp [
	| pose  |
	
	pose := PhaROSPose fromGeometry_msgsPose: landMark pose.
	Transcript show: pose position module2d; show: 'distance'; cr; cr.
	
	currentLandmark ifNotNil: [
		(currentLandmark id = landMark landmark and:[ (DateAndTime now - tstmp ) asMilliSeconds < 300] and:[ currentGoal status = Actionlib_msgsGoalStatus active ]) ifTrue: [
			pose position module2d < 0.5 ifTrue:[
				currentGoal cancel.	
				self halt.
				self manualDifferentialGoal: pose.
			].	
		].
	].
	
"if we are less than 3 cm, we use the landmark position as position with the current orientation. Is a first approach, poor, but first.

	i should check that we have error and do nothing if we dont have a big enough error. 
	i should save a 0 orientation related to the landmark in order to know which is the orientation shift and check that error also, which is the most important.
""
	pose position module2d < 0.03 ifTrue: [
		self halt. 
		self initialPose: (PhaROSPose position: (robulab nodelets localizer entity: landMark landmark) orientation: (robulab nodelets transformation frame: '/base_link') pose orientation).
		
	]."
	

]

{ #category : #'as yet unclassified' }
PureROSMoveBaseLandmarkNavigation >> computeCurrentPose: aPose relatedTo: aLandmarkID [ 
	^ (robulab nodelets localizer entity: aLandmarkID) locate: aPose.
]

{ #category : #'as yet unclassified' }
PureROSMoveBaseLandmarkNavigation >> goTo: anEntity [

	currentEvent ifNotNil: [ currentEvent cancel. currentEvent := nil ].
	currentLandmark := anEntity.
	currentGoal := robulab nodelets movebase client goTo: anEntity center asPose.
	currentEvent := robulab nodelets sgevents whenLandmark: [ :lmk |  anEntity id = lmk landmark and: [ (PhaROSPose fromGeometry_msgsPose: lmk pose) position module2d < 1.0 ] ] doOnce: [ : lmk | self onArrivalToLandmark: lmk ].
]

{ #category : #'as yet unclassified' }
PureROSMoveBaseLandmarkNavigation >> manualDifferentialGoal: aPose [ 
	| rotated |			
				
		self halt.
	"		
			rotated := pose position rotate: robulab robot localizationService currentPosition orientation.
			(PNGTrajectoryServiceBasedController for: robulab robot)  goToDelta: rotated x @ rotated y."
	
]

{ #category : #'as yet unclassified' }
PureROSMoveBaseLandmarkNavigation >> onArrivalToLandmark: aLandmark [ 
	currentEvent := nil.
	currentGoal cancel. 
	self manualDifferentialGoal: (PhaROSPose fromGeometry_msgsPose: aLandmark pose )
]

{ #category : #'as yet unclassified' }
PureROSMoveBaseLandmarkNavigation >> robulab:  aRobulabNodelet [
	robulab := aRobulabNodelet.
	robulab nodelets use: SGStargazerEventManager as: #sgevents.

]
