Class {
	#name : #PureROSValueTracker,
	#superclass : #Object,
	#instVars : [
		'values'
	],
	#category : #'PureROS-Util'
}

{ #category : #'as yet unclassified' }
PureROSValueTracker >> initialize [ 
	values := Dictionary new.
]

{ #category : #'as yet unclassified' }
PureROSValueTracker >> track: aValue from: aTopicID [

	(self tracker: aTopicID) value: aValue.
	
	
]

{ #category : #'as yet unclassified' }
PureROSValueTracker >> tracker: aTopicID [

	^ values at: aTopicID ifAbsent:  [ PureROSValueBind new ]. 
		
]
