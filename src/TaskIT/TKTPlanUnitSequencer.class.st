Class {
	#name : #TKTPlanUnitSequencer,
	#superclass : #TKTPlanSequencer,
	#instVars : [
		'result'
	],
	#category : #'TaskIT-Tasks-Plan'
}

{ #category : #'as yet unclassified' }
TKTPlanUnitSequencer >> deployResult: aResult [
	self result: (TKTPlanResult for: aResult) .
]

{ #category : #'as yet unclassified' }
TKTPlanUnitSequencer >> initialize [
	super initialize.
	result := TKTPlanResult new.
]

{ #category : #'as yet unclassified' }
TKTPlanUnitSequencer >> result [
	| r |
	self flag:#mmmmm. 
	" Ok this is awfull. I dont like the fact that i don't know how many wrappes i expect here. I should be able to end alltimes in one "
	r := result.
	[r := r result ] doWhileTrue: [  r isKindOf: TKTPlanResult ].
	
	((r isKindOf: OrderedCollection ) and: [  r allSatisfy: [ : rslt | rslt isKindOf: TKTPlanResult ] ] ) ifTrue: [ 
		^ r collect: #result.
	 ].
	^ r.
]

{ #category : #'as yet unclassified' }
TKTPlanUnitSequencer >> result: aResult [
	(aResult isKindOf: TKTPlanResult )ifFalse:[ self halt ].
	result := aResult
]

{ #category : #'as yet unclassified' }
TKTPlanUnitSequencer >> resultObject [
	^ result
]

{ #category : #'as yet unclassified' }
TKTPlanUnitSequencer >> sequence: aPlanned [
	self deployResult: (aPlanned reduce:{}).
	^ self result.
]
