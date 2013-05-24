"
This class is a facade  to the three movement services that are available in PNG: Step, Trajectory, Differential Drive. It depends on the kind of message it delegates to the proper service. 
"
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
PurePhaROSDriveCtl >> advance: aPoint [
	"=
		# arguments:
			- aPoint: Point
		# return: Self. 
		# example: 
			[PureROSAMCLBasedPathPlanning/msg][blablabla]
	="


	trajectoryController goToDelta: aPoint.
]

{ #category : #'as yet unclassified' }
PurePhaROSDriveCtl >> advanceTrough: aDeltaCollection [
	trajectoryController goToAllDelta: aDeltaCollection.
]

{ #category : #'as yet unclassified' }
PurePhaROSDriveCtl >> drawSquare [
	^ trajectoryController square.
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
PurePhaROSDriveCtl >> stepController: aController [
	stepController := aController

]

{ #category : #'as yet unclassified' }
PurePhaROSDriveCtl >> stepForward:  aDistance [
	stepController thenMoveForward: aDistance.
]

{ #category : #'as yet unclassified' }
PurePhaROSDriveCtl >> trajectoryController: aController [
	trajectoryController := aController

]
