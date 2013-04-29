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
	robot localizationService pose: aPNGRobotPose.
]
