Class {
	#name : #PureROSLandmarkLocator,
	#superclass : #Object,
	#instVars : [
		'robulab'
	],
	#category : #PureROSNodeletsMovement
}

{ #category : #'as yet unclassified' }
PureROSLandmarkLocator >> relocate: landMark at: tstmp [
	| pose  |
	
	pose := PhaROSPose fromGeometry_msgsPose: landMark pose.
	pose position module2d < 0.03 ifTrue: [
		self halt. 
		self initialPose: (PhaROSPose position: (robulab nodelets localizer entity: landMark landmark) orientation: (robulab nodelets transformation frame: '/base_link') pose orientation).
		
	].
]

{ #category : #'as yet unclassified' }
PureROSLandmarkLocator >> robulab: aRobulabNodelet [
	robulab := aRobulabNodelet.
	robulab nodelets stargazer landmarks for: [ : landMark :chn :tstmp | self relocate: landMark at: tstmp ].
	
]
