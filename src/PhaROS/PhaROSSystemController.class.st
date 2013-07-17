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
	^self url: 'http://127.0.0.1:11311/'.
]

{ #category : #'as yet unclassified' }
PhaROSSystemController class >> url: anUrl [
	^self for: (PhaROSMaster url: anUrl ).
]

{ #category : #accessing }
PhaROSSystemController >> finalize [ 
	master stopAndUnregister.
]

{ #category : #accessing }
PhaROSSystemController >> master:aMaster [
	master := aMaster
]
