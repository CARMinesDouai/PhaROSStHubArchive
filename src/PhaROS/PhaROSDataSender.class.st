Class {
	#name : #PhaROSDataSender,
	#superclass : #Object,
	#instVars : [
		'owner'
	],
	#category : #'PhaROS-Kernel-ExternalNodes'
}

{ #category : #'as yet unclassified' }
PhaROSDataSender class >> for: aNode [
	^ self new owner: aNode; yourself.
]

{ #category : #'as yet unclassified' }
PhaROSDataSender >> addToMessagesQueue: aBinaryMessage [
	| rt |
	rt := owner socket sendData:  aBinaryMessage.
	^ rt. 

]

{ #category : #'as yet unclassified' }
PhaROSDataSender >> owner: aNode [
	owner := aNode.
]
