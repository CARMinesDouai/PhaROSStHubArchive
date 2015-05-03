"
A ROS controller is an object that define how to interact with nodes: how to build them, how to register them in the system.
We have two main flavors of controllers, each one with a different approach of usage of the nodes in an image: PhaROSMasiveNodeController and PhaROSHandleController

"
Class {
	#name : #PhaROSSystemController,
	#superclass : #Object,
	#instVars : [
		'master'
	],
	#category : #'PhaROS-NodeControllers'
}

{ #category : #'as yet unclassified' }
PhaROSSystemController class >> for: aMaster [ 
	^ self new master: aMaster; yourself.
]

{ #category : #'as yet unclassified' }
PhaROSSystemController class >> home [
	^self url: (OSEnvironment default at: 'ROS_MASTER_URI').
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
PhaROSSystemController >> asPhaROSController [
	^ self
]

{ #category : #accessing }
PhaROSSystemController >> finalize [ 
	master ifNotNil: 
	[master stop.
	master := nil.]
]

{ #category : #accessing }
PhaROSSystemController >> master [
	^ master
]

{ #category : #accessing }
PhaROSSystemController >> master:aMaster [
	master := aMaster
]
