Class {
	#name : #PhaROSTestNode,
	#superclass : #PhaROSBlockNode,
	#instVars : [
		'expectedSystemState',
		'subscriberBehavior'
	],
	#category : #'PhaROS-Kernel-Test'
}

{ #category : #'as yet unclassified' }
PhaROSTestNode >> receive: aMessage from: aChannel [ 
	subscriberBehavior value: aMessage value: aChannel.
]

{ #category : #'as yet unclassified' }
PhaROSTestNode >> subscriberBehavior: aBlockClosure [ 
	subscriberBehavior := aBlockClosure.
	
]
