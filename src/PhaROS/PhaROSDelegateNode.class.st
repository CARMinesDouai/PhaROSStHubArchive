Class {
	#name : #PhaROSDelegateNode,
	#superclass : #PhaROSInternalNode,
	#instVars : [
		'receiverDelegate'
	],
	#category : #'PhaROS-Kernel-InternalNodes'
}

{ #category : #accessing }
PhaROSDelegateNode >> initialize [ 
	receiverDelegate := []

]

{ #category : #'topic-consume' }
PhaROSDelegateNode >> interestedIn: aTopicName typedAs: aTypeId [
	^ self subscriber: aTopicName typedAs: aTypeId
]

{ #category : #service }
PhaROSDelegateNode >> receive: aMessage from: aChannel [
	^ receiverDelegate receive: aMessage from: aChannel

]

{ #category : #accessing }
PhaROSDelegateNode >> receiverDelegate: aReceiverDelegateOrBlock [
	receiverDelegate := aReceiverDelegateOrBlock
	
]
