Class {
	#name : #PhaROSHandleController,
	#superclass : #PhaROSSystemController,
	#instVars : [
		'node',
		'packages'
	],
	#category : #'PhaROS-Controllers'
}

{ #category : #construction }
PhaROSHandleController class >> localhost [
	^ super localhost configureNode; yourself.
]

{ #category : #construction }
PhaROSHandleController class >> url: anUrl [
	^( super url:anUrl) configureNode; yourself.
]

{ #category : #accessing }
PhaROSHandleController >> configureDependencies: aLaunchSpec [
	
	packages do: [:p | p configureDependencies: aLaunchSpec ]
]

{ #category : #'initialize-release' }
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

{ #category : #accessing }
PhaROSHandleController >> domain [
	self flag: #askToTheHost.
	"NetNameResolver"
	^ '127.0.0.1'
]

{ #category : #accessing }
PhaROSHandleController >> handleName [
	^ '/PharoHandle'
]

{ #category : #accessing }
PhaROSHandleController >> installHandleNode: aNode [
	node ifNotNil:[
		self error: ' There is already a node installed! '.
	].
	node := aNode.
]

{ #category : #accessing }
PhaROSHandleController >> node [
	^ node
]

{ #category : #service }
PhaROSHandleController >> stop [
	master stopAndUnregister.
]

{ #category : #accessing }
PhaROSHandleController >> tcpPort [
	^9099
]

{ #category : #accessing }
PhaROSHandleController >> use: aPackage [ 
	self packages add: aPackage.
]

{ #category : #accessing }
PhaROSHandleController >> xmlRpcPort [ 
	^ 6630
]
