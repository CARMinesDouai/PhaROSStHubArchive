"
A RoStProxy is an XML RPC proxy that wraps retrun values of method invokations into instances of RoStReturnValue
"
Class {
	#name : #PhaROSProxy,
	#superclass : #XMLRPCProxy,
	#traits : 'TLogger',
	#classTraits : 'TLogger classTrait',
	#category : #'PhaROS-Kernel-XmlRpc'
}

{ #category : #'instance creation' }
PhaROSProxy class >> url: urlString [
	|url|
	url := Url absoluteFromText: urlString.
	^self new
		url: url;
		yourself
]

{ #category : #invoking }
PhaROSProxy >> invokeMethod: method withArgs: args [
	| returnArray response |
	
	self debug: [ 'Calling to [' , method, '] with: [', args asString , '] to: [' , self url asString ,']' ].
	returnArray := super invokeMethod: method withArgs: args.
	response := self responseClass elements: returnArray.
	response isSuccess ifTrue: [^response value].
	PhaROSXmlRpcInvocationException signalWithResponse: response
]

{ #category : #invoking }
PhaROSProxy >> responseClass [
	^PhaROSXmlRpcResponse
]

{ #category : #service }
PhaROSProxy >> stop [
	self flag: #GTFO.
]
