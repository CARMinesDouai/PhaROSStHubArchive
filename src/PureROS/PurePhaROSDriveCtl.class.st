Class {
	#name : #PurePhaROSDriveCtl,
	#superclass : #PNGController,
	#instVars : [
		'trajectoryController',
		'stepController'
	],
	#category : #'PureROS-Controllers'
}

{ #category : #'as yet unclassified' }
PurePhaROSDriveCtl >> avance: aPoint [
	trajectoryController goToDelta: aPoint.
]

{ #category : #'as yet unclassified' }
PurePhaROSDriveCtl >> avanceTrough: aDeltaCollection [
	trajectoryController goToAllDelta: aDeltaCollection.
]

{ #category : #'as yet unclassified' }
PurePhaROSDriveCtl >> initialize [ 
	trajectoryController := PNGTrajectoryServiceBasedController for: robot.
	stepController := PNGStepServiceBasedController  for: robot.
]

{ #category : #'as yet unclassified' }
PurePhaROSDriveCtl >> moveAt: aPNGDifferentialVelocity [
	^ robot differentialService moveAt: aPNGDifferentialVelocity.
]

{ #category : #'as yet unclassified' }
PurePhaROSDriveCtl >> moveTo: aPoint [
	trajectoryController goTo: aPoint.
]

{ #category : #'as yet unclassified' }
PurePhaROSDriveCtl >> moveTrough: aPointCollection [
	trajectoryController goTo: aPointCollection.
]

{ #category : #'as yet unclassified' }
PurePhaROSDriveCtl >> rotate:  aDistance [
	stepController thenRotate: aDistance.
]

{ #category : #'as yet unclassified' }
PurePhaROSDriveCtl >> step: aPoint [
	trajectoryController goToDelta: aPoint.
]

{ #category : #'as yet unclassified' }
PurePhaROSDriveCtl >> stepForward:  aDistance [
	stepController thenMoveForward: aDistance.
]
