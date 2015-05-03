Class {
	#name : #PhaROSInternalNodeLink,
	#superclass : #Object,
	#instVars : [
		'channel',
		'xmlurl'
	],
	#category : #'PhaROS-Kernel-InternalNodes'
}

{ #category : #'as yet unclassified' }
PhaROSInternalNodeLink >> channel [ 
	^ channel 
]

{ #category : #'as yet unclassified' }
PhaROSInternalNodeLink >> channel: aChn [
	channel := aChn.
]

{ #category : #'as yet unclassified' }
PhaROSInternalNodeLink >> close [
	channel unsubscribe: self. 
]

{ #category : #'as yet unclassified' }
PhaROSInternalNodeLink >> receive: aMessage from: aChannel [
	channel send: aMessage value.
]

{ #category : #'as yet unclassified' }
PhaROSInternalNodeLink >> xmlurl [ 
	^ xmlurl 
]

{ #category : #'as yet unclassified' }
PhaROSInternalNodeLink >> xmlurl: anUrl [
	 xmlurl := anUrl 
]
