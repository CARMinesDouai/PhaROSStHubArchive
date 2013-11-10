Class {
	#name : #TKTPlanUnitCounter,
	#superclass : #TKTPlanVisitor,
	#instVars : [
		'units'
	],
	#category : #'TaskIT-Tasks-Plan'
}

{ #category : #'as yet unclassified' }
TKTPlanUnitCounter >> acceptImplication: anImplication [
	anImplication object accept: self.
"We come from the consequent."
]

{ #category : #'as yet unclassified' }
TKTPlanUnitCounter >> acceptUnit: aUnit [
	units := units + 1 .
]

{ #category : #'as yet unclassified' }
TKTPlanUnitCounter >> initialize [ 
	super initialize.
	units := 0.
]

{ #category : #'as yet unclassified' }
TKTPlanUnitCounter >> units [
	^ units.
]
