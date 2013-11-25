Class {
	#name : #PureROSKompaiTrajectoryState,
	#superclass : #PureROSKompaiActionState,
	#instVars : [
		'tcontroller'
	],
	#category : #PureROSNodeletsKompai
}

{ #category : #'as yet unclassified' }
PureROSKompaiTrajectoryState >> controller [
	^ tcontroller ifNil: [tcontroller := PNGTrajectoryServiceBasedController for: kompai robot].
]

{ #category : #'as yet unclassified' }
PureROSKompaiTrajectoryState >> goTo: aDeltaPose [
	self controller goTo: aDeltaPose.
]

{ #category : #'as yet unclassified' }
PureROSKompaiTrajectoryState >> moveAt: aDifferentialVelocity [
	aDifferentialVelocity linear > 0 ifTrue: [
		kompai state: self differentialState.
		kompai moveAt: aDifferentialVelocity.
		self stopDriving.
	]
]

{ #category : #'as yet unclassified' }
PureROSKompaiTrajectoryState >> stopDriving [ 
	tcontroller ifNotNil: [ tcontroller  clearTrajectory ].
]
