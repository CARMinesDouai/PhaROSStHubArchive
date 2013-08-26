Class {
	#name : #PhaROSMasiveNodeController,
	#superclass : #PhaROSSystemController,
	#category : #'PhaROS-Controllers'
}

{ #category : #constructor }
PhaROSMasiveNodeController >> create: aNodeClass named: name domain: aDomain tcpPort: aTcpPort xmlRpcPort: aXmlRpcPort [ 
	| node |
	master verifyName: name.
	node := aNodeClass name: name domain: aDomain tcpPort: aTcpPort xmlRpcPort: aXmlRpcPort master: master .
	master registerNode: node.
	^ node.
	
]

{ #category : #constructor }
PhaROSMasiveNodeController >> create: aSouledNodeClass named: name domain: aDomain tcpPort: aTcpPort xmlRpcPort: aXmlRpcPort soul: aBlock [
	| node |
	master verifyName: name.
	node := aSouledNodeClass name: name domain: aDomain tcpPort: aTcpPort xmlRpcPort: aXmlRpcPort master: master soul: aBlock.
	master registerNode: node.

	^ node.
	
]

{ #category : #constructor }
PhaROSMasiveNodeController >> master [
	^ master
]
