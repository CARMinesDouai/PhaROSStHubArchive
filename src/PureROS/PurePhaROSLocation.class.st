"
This object is really simple, i thinking maybe takeit away. It just a facade about localization. But it almost have no intelligence, is just here to keep the same way to do the things.
"
Class {
	#name : #PurePhaROSLocation,
	#superclass : #PNGController,
	#category : #'PureROS-Controllers'
}

{ #category : #'as yet unclassified' }
PurePhaROSLocation >> setPose: aPNGRobotPose [
	robot localizationService pose: aPNGRobotPose.
]

{ #category : #'as yet unclassified' }
PurePhaROSLocation >> suggestPose: aPNGRobotPose [
	robot localizationService suggest: aPNGRobotPose.
]
