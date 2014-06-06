Class {
	#name : #TKTPlanVisitor,
	#superclass : #Object,
	#category : #PlanIT
}

{ #category : #visiting }
TKTPlanVisitor >> acceptCollection: aPlannedCollection [
	aPlannedCollection units do:[ : u | u accept: self ].
]

{ #category : #visiting }
TKTPlanVisitor >> acceptIndependantUnits: aPlannedCollection [
	self acceptCollection: aPlannedCollection.
]

{ #category : #visiting }
TKTPlanVisitor >> acceptSequencedUnits: aPlannedCollection [
	self acceptCollection: aPlannedCollection.
]

{ #category : #visiting }
TKTPlanVisitor >> acceptUnit: aTKTPlannedUnit [
	
]
