Class {
	#name : #PureActionMessage,
	#superclass : #PureMessage,
	#instVars : [
		'action'
	],
	#category : #'Pure-Messages'
}

{ #category : #accessing }
PureActionMessage >> action [
	^ action
]

{ #category : #accessing }
PureActionMessage >> action: anObject [
	action := anObject
]

{ #category : #accessing }
PureActionMessage >> isNotification [
	^false
]
