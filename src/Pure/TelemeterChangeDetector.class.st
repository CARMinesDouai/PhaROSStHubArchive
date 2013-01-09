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
	newDistances withIndexDo: [:index :new| 
		|old|
		old := referenceDistances at: index.
		(new closeTo: old) ifFlase: [changedIndices add: index]].
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
