Class {
	#name : #PhaROSDelegateNode,
	#superclass : #PhaROSNode,
	#instVars : [
		'receiverDelegate'
	],
	#category : #'PhaROS-Kernel'
}

{ #category : #accessing }
PhaROSDelegateNode >> initialize [ 
	receiverDelegate := [].

]

{ #category : #'as yet unclassified' }
PhaROSDelegateNode >> interestedIn: aTopicName typedAs: aTypeId [
	^ self subscriber: aTopicName typedAs: aTypeId.
]

{ #category : #service }
PhaROSDelegateNode >> receive: aMessage from: aChannel [
	^ receiverDelegate receive: aMessage from: aChannel.

]

{ #category : #'as yet unclassified' }
PhaROSDelegateNode >> receiverDelegate: aReceiverDelegateOrBlock [
	receiverDelegate := aReceiverDelegateOrBlock. 
	
]
