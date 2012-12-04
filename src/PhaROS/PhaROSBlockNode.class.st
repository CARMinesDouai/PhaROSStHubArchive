Class {
	#name : #PhaROSBlockNode,
	#superclass : #PhaROSNode,
	#instVars : [
		'soul'
	],
	#category : #'PhaROS-Kernel'
}

{ #category : #'as yet unclassified' }
PhaROSBlockNode class >> name: aName domain: aDomain tcpPort: aTcpPort xmlRpcPort: aXmlRpcPort master: aMaster soul: aBlock [
	^ self name: aName domain: aDomain tcpPort: aTcpPort xmlRpcPort: aXmlRpcPort master: aMaster soul: aBlock delegate:[].
	
]

{ #category : #'as yet unclassified' }
PhaROSBlockNode class >> name: aName domain: aDomain tcpPort: aTcpPort xmlRpcPort: aXmlRpcPort master: aMaster soul: aBlock delegate: aReceiverDelegateOrBlock [
	^ (self name: aName domain: aDomain tcpPort: aTcpPort xmlRpcPort: aXmlRpcPort master: aMaster delegate: aReceiverDelegateOrBlock) soul: aBlock ; yourself.
	
]

{ #category : #'as yet unclassified' }
PhaROSBlockNode >> destroy [
	super destroy.
	soul := nil. 
]

{ #category : #'as yet unclassified' }
PhaROSBlockNode >> execute [
	^ soul cull: self.
]

{ #category : #'as yet unclassified' }
PhaROSBlockNode >> soul: aBlock [
	soul := aBlock.
]
