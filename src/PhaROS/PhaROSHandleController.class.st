Class {
	#name : #PhaROSHandleController,
	#superclass : #PhaROSSystemController,
	#instVars : [
		'node'
	],
	#category : #'PhaROS-Controllers'
}

{ #category : #'as yet unclassified' }
PhaROSHandleController class >> localhost [
	^ super localhost configureNode; yourself.
]

{ #category : #'as yet unclassified' }
PhaROSHandleController class >> url: anUrl [
	^( super url:anUrl) configureNode; yourself.
]

{ #category : #'as yet unclassified' }
PhaROSHandleController >> configureNode [ 
	| handle |
	
	handle := (PhaROSMasiveNodeController for: master) 
				create: PhaROSNodeHandle  
				named: self handleName 
				domain: self domain 
				tcpPort:  self tcpPort 
				xmlRpcPort: self xmlRpcPort .
				
	self installHandleNode: handle. 
	

]

{ #category : #'as yet unclassified' }
PhaROSHandleController >> domain [
	self flag: #askToTheHost.
	"NetNameResolver"
	^ '127.0.0.1'
]

{ #category : #'as yet unclassified' }
PhaROSHandleController >> handleName [
	^ '/PharoHandle'
]

{ #category : #'as yet unclassified' }
PhaROSHandleController >> installHandleNode: aNode [
	node ifNotNil:[
		self error: ' There is already a node installed! '.
	].
	node := aNode.
]

{ #category : #'as yet unclassified' }
PhaROSHandleController >> node [
	^ node
]

{ #category : #'as yet unclassified' }
PhaROSHandleController >> stop [
	master stopAndUnregister.
]

{ #category : #'as yet unclassified' }
PhaROSHandleController >> tcpPort [
	^9099
]

{ #category : #'as yet unclassified' }
PhaROSHandleController >> xmlRpcPort [ 
	^ 6630
]
