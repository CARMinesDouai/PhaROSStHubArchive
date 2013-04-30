Class {
	#name : #PhaROSSystemController,
	#superclass : #Object,
	#instVars : [
		'master'
	],
	#category : #'PhaROS-Controllers'
}

{ #category : #'as yet unclassified' }
PhaROSSystemController class >> for: aMaster [ 
	^ self new master: aMaster; yourself.
]

{ #category : #'as yet unclassified' }
PhaROSSystemController class >> localhost [
	^self new master: PhaROSMaster localhost; yourself.
]

{ #category : #'as yet unclassified' }
PhaROSSystemController class >> url: anUrl [
	^self new master: (PhaROSMaster url: anUrl ); yourself.
]

{ #category : #accessing }
PhaROSSystemController >> finalize [ 
	master stopAndUnregister.
]

{ #category : #accessing }
PhaROSSystemController >> master:aMaster [
	master := aMaster
]
