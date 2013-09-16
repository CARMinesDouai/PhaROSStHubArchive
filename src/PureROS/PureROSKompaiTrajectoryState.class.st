Class {
	#name : #PureROSKompaiTrajectoryState,
	#superclass : #PureROSKompaiActionState,
	#instVars : [
		'tcontroller'
	],
	#category : #'PureROS-Nodelets'
}

{ #category : #'as yet unclassified' }
PureROSKompaiTrajectoryState >> controller [
	^ tcontroller ifNil: [tcontroller := PNGTrajectoryServiceBasedController for: kompai robot].
]

{ #category : #'as yet unclassified' }
PureROSKompaiTrajectoryState >> goTo: aDeltaPose [
	self controller goToDelta: aDeltaPose.
]

{ #category : #'as yet unclassified' }
PureROSKompaiTrajectoryState >> moveAt: aDifferentialVelocity [
	self stopDriving.
	kompai state: self differentialState.
	kompai moveAt: aDifferentialVelocity.
]

{ #category : #'as yet unclassified' }
PureROSKompaiTrajectoryState >> stopDriving [ 
	tcontroller ifNotNil: [ tcontroller stopMotion].
]
