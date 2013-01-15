Class {
	#name : #PNGActionMessage,
	#superclass : #PNGEncodedMessage,
	#instVars : [
		'action'
	],
	#category : #'PureNG-Kernel'
}

{ #category : #accessing }
PNGActionMessage >> action [
	^ action
]

{ #category : #accessing }
PNGActionMessage >> action: anObject [
	action := anObject
]
