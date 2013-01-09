"
detector := TelemeterChangeDetector new.
detector setupReferenceDistances.
detector changedTelemeterIndices. 
"
Class {
	#name : #TelemeterChangeDetector,
	#superclass : #TestService,
	#instVars : [
		'referenceDistances'
	],
	#category : #'Pure-RobotModelExtraction'
}

{ #category : #measuring }
TelemeterChangeDetector >> changedTelemeterIndices [
	| newDistances changedIndices |
	newDistances := self distances.
	changedIndices := Set new.
	newDistances withIndexDo: [:new :index | 
		|reference|
		reference := referenceDistances at: index.
		(new - reference) abs > 0.2 ifTrue: [changedIndices add: index]].
	^changedIndices
]

{ #category : #measuring }
TelemeterChangeDetector >> distances [
	^(self notificationForService: TelemeterService forNotification: TelemeterNotification) distances
]

{ #category : #measuring }
TelemeterChangeDetector >> initialize [ 
	super initialize.
	self setUp
]

{ #category : #measuring }
TelemeterChangeDetector >> setupReferenceDistances [
	referenceDistances := self distances 
]
