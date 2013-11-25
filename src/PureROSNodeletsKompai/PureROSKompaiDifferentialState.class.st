Class {
	#name : #PureROSKompaiDifferentialState,
	#superclass : #PureROSKompaiActionState,
	#instVars : [
		'lastStmp'
	],
	#category : #PureROSNodeletsKompai
}

{ #category : #'as yet unclassified' }
PureROSKompaiDifferentialState >> goTo: aDeltaPose [

		kompai state: self trajectoryState.
		^kompai goTo: aDeltaPose.

]

{ #category : #'as yet unclassified' }
PureROSKompaiDifferentialState >> initialize [
	lastStmp := DateAndTime now - 5 seconds.
]

{ #category : #'as yet unclassified' }
PureROSKompaiDifferentialState >> moveAt: aDifferentialVelocity [
	lastStmp := DateAndTime now.
	^ kompai robot differentialService moveAt: aDifferentialVelocity. 
	
]
