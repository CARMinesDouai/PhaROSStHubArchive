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
PhaROSHandleController class >> turtlebot [
	^ self url: 'http://10.1.161.20:11311'
]

{ #category : #construction }
PhaROSHandleController class >> url: anUrl [
	^( super url:anUrl) configureNode; yourself.
]

{ #category : #accessing }
PhaROSHandleController >> configureDependencies: aLaunchSpec [	
	self flag: #thisShouldChange.
	" now the node is being configured during the instanciation, we need to have an explicit launchtime, when we can ask packages for it launch configuration.  "
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

{ #category : #trash }
PhaROSHandleController >> connectGoal [
	| connection |
	connection := node buildConnectionFor: '/move_base/goal'.
	connection typedAs: 'move_base_msgs/MoveBaseActionGoal'; for: [ :msg | 
		Transcript show: msg; cr.
	]; connect.
	
]

{ #category : #trash }
PhaROSHandleController >> connectTF [
	| connection |
	connection := node buildConnectionFor: '/tf'.
	connection typedAs: 'tf/tfMessage'; for: [ :msg | 
		Transcript show: msg; cr.
	]; connect.
	
]

{ #category : #accessing }
PhaROSHandleController >> domain [
	self flag: #askToTheHost.
	"NetNameResolver"
	^ '127.0.0.1'
]

{ #category : #package }
PhaROSHandleController >> finalize [ 
	super finalize.
	packages finalize.
]

{ #category : #accessing }
PhaROSHandleController >> handleName [
	^ '/PharoHandle'
]

{ #category : #accessing }
PhaROSHandleController >> initialize [
	super initialize .
	packages := PhaROSPackageContainer new  controller: self; yourself.
]

{ #category : #package }
PhaROSHandleController >> install: aPackage [
	aPackage install.
	aPackage configure: self.
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

{ #category : #accessing }
PhaROSHandleController >> packages [
	^ packages 
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
PhaROSHandleController >> xmlRpcPort [ 
	^ 6630
]
