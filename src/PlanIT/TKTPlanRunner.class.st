Class {
	#name : #TKTPlanRunner,
	#superclass : #TKTPlanVisitor,
	#instVars : [
		'sequencer',
		'previousSequencer'
	],
	#category : #PlanIT
}

{ #category : #'as yet unclassified' }
TKTPlanRunner class >> sequence: aPlanned [ 	
	| sequencer |
	sequencer := self new.
	aPlanned accept: sequencer.
	^ sequencer.
]

{ #category : #visiting }
TKTPlanRunner >> acceptCollection: aPlannedCollection [
	aPlannedCollection units do:[ : u | u accept:self ].
]

{ #category : #visiting }
TKTPlanRunner >> acceptIndependantUnits: anPlannedIndependantUnits [ 	
	self beginIndependants.
	self acceptCollection: anPlannedIndependantUnits.
	self endIndependants.
]

{ #category : #visiting }
TKTPlanRunner >> acceptInterDependantUnits: anPlannedInterDependantUnits [
	self beginInterDependants.
	self acceptUnit: anPlannedInterDependantUnits first.
	self acceptUnit: anPlannedInterDependantUnits second.
	self endInterDependants.
]

{ #category : #visiting }
TKTPlanRunner >> acceptSequencedUnits: aPlannedSequencedUnits [
	self beginSequence.
	self acceptCollection: aPlannedSequencedUnits.
	self endSequence.
]

{ #category : #visiting }
TKTPlanRunner >> acceptUnit: aPlannedUnit [
	sequencer sequence: aPlannedUnit.
]

{ #category : #signaling }
TKTPlanRunner >> beginIndependants [
	self installSequencer: TKTPlanIndependant  new.
]

{ #category : #signaling }
TKTPlanRunner >> beginInterDependants [
	self installSequencer: TKTPlanInterDependant  new.
]

{ #category : #signaling }
TKTPlanRunner >> beginSequence [
	self installSequencer: TKTPlanSequence new.
]

{ #category : #signaling }
TKTPlanRunner >> endIndependants [
	self uninstallSequencer.
]

{ #category : #signaling }
TKTPlanRunner >> endInterDependants [
	self uninstallSequencer.
	
]

{ #category : #signaling }
TKTPlanRunner >> endSequence [
	self uninstallSequencer.
	
]

{ #category : #signaling }
TKTPlanRunner >> initialize [
	sequencer := TKTPlanUnitSequencer new.
]

{ #category : #signaling }
TKTPlanRunner >> installSequencer: aSequencer [
	aSequencer previousSequencer: sequencer .
	
	sequencer thereIsResult ifTrue: [
		aSequencer result: sequencer resultObject. 
	].
	sequencer := aSequencer. 
	sequencer begin. 
	
]

{ #category : #signaling }
TKTPlanRunner >> result [
	^ sequencer result.
]

{ #category : #signaling }
TKTPlanRunner >> uninstallSequencer [
	
	sequencer previousSequencer ifNil: [  self error: 'You cannot uninstall the las sequencer ' ].
	sequencer end.
	sequencer thereIsResult ifTrue: [
		sequencer previousSequencer result: sequencer resultObject.
	].
	
	sequencer := sequencer previousSequencer. 

	
]
