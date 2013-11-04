Class {
	#name : #TKTPlanVisitor,
	#superclass : #Object,
	#category : #'TaskIT-Tasks-Plan'
}

{ #category : #visiting }
TKTPlanVisitor >> acceptElement: aPlanElement [
	
]

{ #category : #visiting }
TKTPlanVisitor >> acceptImplication: aTKTPlannedImplication [
	self acceptElement: aTKTPlannedImplication.
	
]

{ #category : #visiting }
TKTPlanVisitor >> acceptImplicationSequence: aTKTSequence [
	self acceptImplication: aTKTSequence 
]

{ #category : #visiting }
TKTPlanVisitor >> acceptUnit: aTKTPlannedUnit [
	self acceptElement: aTKTPlannedUnit.
]
