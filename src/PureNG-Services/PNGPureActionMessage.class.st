Class {
	#name : #PNGPureActionMessage,
	#superclass : #PNGPureEncodedMessage,
	#instVars : [
		'action'
	],
	#category : #'PureNG-Kernel'
}

{ #category : #accessing }
PNGPureActionMessage >> action [
	^ action
]

{ #category : #accessing }
PNGPureActionMessage >> action: anObject [
	action := anObject
]
