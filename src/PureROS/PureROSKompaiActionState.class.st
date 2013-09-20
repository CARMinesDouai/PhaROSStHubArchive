Class {
	#name : #PureROSKompaiActionState,
	#superclass : #Object,
	#instVars : [
		'kompai'
	],
	#category : #'PureROS-Nodelets-Kompai'
}

{ #category : #'as yet unclassified' }
PureROSKompaiActionState class >> for: aKompaiNodelet [ 
	^ self new kompai: aKompaiNodelet; yourself.
]

{ #category : #'as yet unclassified' }
PureROSKompaiActionState >> differentialState [
	^ PureROSKompaiDifferentialState for: kompai.
]

{ #category : #'as yet unclassified' }
PureROSKompaiActionState >> goTo: aDeltaPose [
	kompai state: self trajectoryState.
	^ kompai goTo: aDeltaPose.
]

{ #category : #'as yet unclassified' }
PureROSKompaiActionState >> kompai: aKompaiNodelet [
	kompai := aKompaiNodelet.
]

{ #category : #'as yet unclassified' }
PureROSKompaiActionState >> moveAt: aDifferentialVelocity [
	kompai state: self differentialState.
	^ kompai moveAt: aDifferentialVelocity.
]

{ #category : #'as yet unclassified' }
PureROSKompaiActionState >> trajectoryState [
	^ PureROSKompaiTrajectoryState for: kompai.
]
