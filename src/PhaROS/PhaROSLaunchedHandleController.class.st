Class {
	#name : #PhaROSLaunchedHandleController,
	#superclass : #PhaROSHandleController,
	#instVars : [
		'launch'
	],
	#category : #'PhaROS-Controllers'
}

{ #category : #'as yet unclassified' }
PhaROSLaunchedHandleController class >> url: anURL [
	| launch |
	launch := PhaROSSystemLauncher  instance launch: [: v | ].
	^ (super url: anURL) launch: launch; yourself . 
	
]

{ #category : #'as yet unclassified' }
PhaROSLaunchedHandleController >> finalize [ 
	super finalize.
	launch := nil.
]

{ #category : #'as yet unclassified' }
PhaROSLaunchedHandleController >> launch: aProcess [
	launch := aProcess 
]
