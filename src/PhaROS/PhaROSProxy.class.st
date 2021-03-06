"
A RoStProxy is an XML RPC proxy that wraps retrun values of method invokations into instances of RoStReturnValue
"
Class {
	#name : #PhaROSProxy,
	#superclass : #XMLRPCProxy,
	#category : #'PhaROS-Network-XmlRpc'
}

{ #category : #'instance creation' }
PhaROSProxy class >> url: urlString [
	|url|
	url := ZnUrl fromString: urlString.
	^self new
		url: url;
		yourself
]

{ #category : #invoking }
PhaROSProxy >> invokeMethod: method withArgs: args [
	| returnArray |
	
	returnArray := super invokeMethod: method withArgs: args.
	^	(self responseClass elements: returnArray) value.
	
]

{ #category : #invoking }
PhaROSProxy >> responseClass [
	^PhaROSXmlRpcResponse
]
