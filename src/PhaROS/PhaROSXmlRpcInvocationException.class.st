"
A RoStXmlRpcInvocationException is an exception signaled when the response obtained after an XML RPC invocation is either a failure or an error.

Instance Variables
	response:		<RoStXmlRpcResponse>

response
	- The response with error or failure information

"
Class {
	#name : #PhaROSXmlRpcInvocationException,
	#superclass : #PhaROSError,
	#instVars : [
		'response'
	],
	#category : #'PhaROS-Error'
}

{ #category : #signaling }
PhaROSXmlRpcInvocationException class >> signalWithResponse: response [
	self new
		response: response;
		signal
]

{ #category : #accessing }
PhaROSXmlRpcInvocationException >> response [
	^ response
]

{ #category : #accessing }
PhaROSXmlRpcInvocationException >> response: anObject [
	response := anObject. 
	response statusMessage ifEmpty: [^self].
	self messageText: response statusMessage
]
