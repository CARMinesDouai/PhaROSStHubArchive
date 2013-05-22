"
This object is really simple, i thinking maybe takeit away. It just a facade about localization. But it almost have no intelligence, is just here to keep the same way to do the things.
"
Class {
	#name : #PurePhaROSLocation,
	#superclass : #PNGController,
	#category : #'PureROS-Controllers'
}

{ #category : #'as yet unclassified' }
PurePhaROSLocation >> isInMergeable: aLocalizationNotification  with: aTimeStamp [ 


"	Transcript show:  aTimeStamp timestamp asSeconds asString;cr.
	Transcript show:  aLocalizationNotification timestamp asString;cr. 
	Transcript show:  (aTimeStamp timestamp asSeconds - aLocalizationNotification timestamp) asString; cr.
"
	^ true.
	"^ (aTimeStamp timestamp asSeconds - aLocalizationNotification timestamp) abs < 2."
]

{ #category : #'as yet unclassified' }
PurePhaROSLocation >> makeARobotPoseWith: aPosition and: anIMUOrientation [
	| imuOrientation |
	imuOrientation := (PhaROSGeometryTransformations new eulerFromQuaternation: {anIMUOrientation x . anIMUOrientation y . anIMUOrientation z . anIMUOrientation w }).
	
	
	^ PNGRobotPose x:  aPosition x y:  aPosition y o: (imuOrientation at:3) .

]

{ #category : #'as yet unclassified' }
PurePhaROSLocation >> merge: anIMUOrientation with: lastLocalization received: aTimeStamp [
	^ (self isInMergeable: lastLocalization with: aTimeStamp) ifTrue: [
		self makeARobotPoseWith: lastLocalization and: anIMUOrientation.	
	  ].
]

{ #category : #'as yet unclassified' }
PurePhaROSLocation >> setPose: aPNGRobotPose [
	[
	robot localizationService pose: aPNGRobotPose.  Transcript show: ':)'; cr.] on: Error do:  [ :e | self halt. Transcript show: ':('; cr. ].
]

{ #category : #'as yet unclassified' }
PurePhaROSLocation >> suggestPose: aPNGRobotPose [
	robot localizationService suggest: aPNGRobotPose.
]
