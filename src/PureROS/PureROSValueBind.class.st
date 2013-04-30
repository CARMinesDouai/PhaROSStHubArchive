Class {
	#name : #PureROSValueBind,
	#superclass : #Object,
	#instVars : [
		'value'
	],
	#category : #'PureROS-Util'
}

{ #category : #construction }
PureROSValueBind class >> for: aValue [
	^ self new value: aValue ; yourself .
]

{ #category : #'as yet unclassified' }
PureROSValueBind >> value [
	^ value.
]

{ #category : #'as yet unclassified' }
PureROSValueBind >> value: aValue [
	value := aValue.
]
