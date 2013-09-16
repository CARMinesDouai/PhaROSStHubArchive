Class {
	#name : #PureROSKompaiDifferentialState,
	#superclass : #PureROSKompaiActionState,
	#instVars : [
		'lastStmp'
	],
	#category : #'PureROS-Nodelets'
}

{ #category : #'as yet unclassified' }
PureROSKompaiDifferentialState >> goTo: aDeltaPose [
	(DateAndTime now - lastStmp ) asSeconds > 5 ifTrue: [
		kompai state: self trajectoryState.
		^kompai goTo: aDeltaPose.
	].
	self error: 'Currently under DDrive manage'.
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
