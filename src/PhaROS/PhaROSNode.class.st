Class {
	#name : #PhaROSNode,
	#superclass : #Object,
	#instVars : [
		'transport',
		'name'
	],
	#category : #'PhaROS-Kernel'
}

{ #category : #'as yet unclassified' }
PhaROSNode class >> name: aName domain: aDomain tcpPort: aTcpPort xmlRpcPort: aXmlRpcPort master: aMaster [
	
	^ super new name: aName ;  
				transport: (PhaROSTransport domain: aDomain  xml: aXmlRpcPort tcp: aTcpPort master: aMaster);
				yourself.
	
]

{ #category : #'as yet unclassified' }
PhaROSNode class >> new [ 
	self error: ' You must used #name:domain:tcpPort:xmlRpcPort:master:  in order to instanciate a PhaROSNode. ' 
]

{ #category : #'as yet unclassified' }
PhaROSNode >> finalize [ 
	transport finalize.
	transport := nil.
]

{ #category : #'as yet unclassified' }
PhaROSNode >> name [
	^ name
]

{ #category : #'as yet unclassified' }
PhaROSNode >> name: aName [
	name := aName
]

{ #category : #'as yet unclassified' }
PhaROSNode >> onSubscribe: aNode to: aTopic [
	"when a node is subscribed to a topic that is broadcasted by this node, you receive this message"
]

{ #category : #'as yet unclassified' }
PhaROSNode >> printOn: aStream [
	aStream nextPutAll: 'Node-', (self name ifNil:'').
]

{ #category : #'as yet unclassified' }
PhaROSNode >> publisher: aTopicID typedAs: aTypeID [
	^ transport publisher: aTopicID typedAs: aTypeID
	
]

{ #category : #'as yet unclassified' }
PhaROSNode >> receive: aMessage from: aChannel [
]

{ #category : #output }
PhaROSNode >> sendTo: aTopicName typedAs: aTypeId a: aMessageConfigurationBlock [
	^ (self publisher: aTopicName typedAs: aTypeId) send: aMessageConfigurationBlock.
	
]

{ #category : #'as yet unclassified' }
PhaROSNode >> subscriber: aTopicID typedAs: aTypeID [

	^ transport subscriber: aTopicID typedAs: aTypeID
	
]

{ #category : #'as yet unclassified' }
PhaROSNode >> transport: aTransport [
	transport := aTransport.
	aTransport node: self.
]
