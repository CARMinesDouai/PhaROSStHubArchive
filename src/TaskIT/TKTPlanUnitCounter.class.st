Class {
	#name : #TKTPlanUnitCounter,
	#superclass : #TKTPlanVisitor,
	#instVars : [
		'units'
	],
	#category : #'TaskIT-Tasks-Plan'
}

{ #category : #'as yet unclassified' }
TKTPlanUnitCounter class >> count: aPlanned [ 	
	| counter  |
	counter := self new.
	aPlanned accept: counter.
	^ counter units.
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
