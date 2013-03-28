Class {
	#name : #PNGActiveObject,
	#superclass : #Object,
	#instVars : [
		'robot',
		'activeObject'
	],
	#category : #'PureNG-Kernel'
}

{ #category : #'instance creation' }
PNGActiveObject class >> forRobot: aRobot [
	^self new
		robot: aRobot;
		start;
		yourself 
]

{ #category : #accessing }
PNGActiveObject >> activeObject [
	^ activeObject 
]

{ #category : #accessing }
PNGActiveObject >> activeObject: anObject [
	activeObject := anObject
]

{ #category : #testing }
PNGActiveObject >> isStarted [ 
	self activeObject ifNil: [^false].
	^self activeObject isStarted 
]

{ #category : #accessing }
PNGActiveObject >> port [
	^self robot port
]

{ #category : #accessing }
PNGActiveObject >> robot [
	^ robot first
]

{ #category : #accessing }
PNGActiveObject >> robot: anObject [
	robot := WeakArray with: anObject
]

{ #category : #activity }
PNGActiveObject >> start [
	self isStarted
		ifTrue: [ ^ self ].
	
	
]

{ #category : #activity }
PNGActiveObject >> stop [
	self activeObject stop
]
