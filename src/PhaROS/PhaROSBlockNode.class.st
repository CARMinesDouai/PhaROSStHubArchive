Class {
	#name : #PhaROSBlockNode,
	#superclass : #PhaROSDelegateNode,
	#instVars : [
		'soul'
	],
	#category : #'PhaROS-Kernel-InternalNodes'
}

{ #category : #'as yet unclassified' }
PhaROSBlockNode class >> name: aName domain: aDomain tcpPort: aTcpPort xmlRpcPort: aXmlRpcPort master: aMaster soul: aBlock [
	 ^ (self name: aName domain: aDomain tcpPort: aTcpPort xmlRpcPort: aXmlRpcPort master: aMaster ) soul: aBlock ; yourself.
	
	
]

{ #category : #'as yet unclassified' }
PhaROSBlockNode >> destroy [
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
