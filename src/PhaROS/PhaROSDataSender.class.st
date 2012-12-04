Class {
	#name : #PhaROSDataSender,
	#superclass : #Object,
	#instVars : [
		'owner'
	],
	#category : #'PhaROS-Kernel'
}

{ #category : #'as yet unclassified' }
PhaROSDataSender class >> for: aNode [
	^ self new owner: aNode; yourself.
]

{ #category : #'as yet unclassified' }
PhaROSDataSender >> addToMessagesQueue: aBinaryMessage [
	| rt |
	rt := owner socket sendData:  aBinaryMessage.
	self delayBetweenMessages .
	^ rt. 

]

{ #category : #'as yet unclassified' }
PhaROSDataSender >> delayBetweenMessages [ 
	"(Delay forMilliseconds: 1000) wait."
]

{ #category : #'as yet unclassified' }
PhaROSDataSender >> owner: aNode [
	owner := aNode.
]
