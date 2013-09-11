Class {
	#name : #PhaROSHandleController,
	#superclass : #PhaROSSystemController,
	#instVars : [
		'node',
		'handleName',
		'nodelets',
		'tcpPort',
		'xmlPort'
	],
	#category : #'PhaROS-Controllers'
}

{ #category : #construction }
PhaROSHandleController class >> rpcTest [
	| ttb |
	ttb :=  self localhost.
	ttb nodelets use: PhaROSRPCNodelet as: #rpc.
	^ ttb.
]

{ #category : #construction }
PhaROSHandleController class >> stargazer [
	| rbl |
	
	rbl :=  self home.
	rbl nodelets use: SGROSStarGazerNodelet  as: #stargazer.
	rbl nodelets use: PhaROSTransformationNodelet  as: #transformation.
	
	^ rbl .
]

{ #category : #construction }
PhaROSHandleController class >> transformation [
	| rbl |
	
	rbl :=  self home.
	rbl nodelets use: PhaROSTransformationNodelet  as: #transformation.
	
	^ rbl .
]

{ #category : #construction }
PhaROSHandleController class >> turtlebot [
	| ttb |
	ttb :=  self url: 'http://10.1.161.20:11311/'.
	ttb nodelets use: PhaROSTurtlebotNodelet as: #turtlebot.
	^ ttb.
]

{ #category : #construction }
PhaROSHandleController class >> turtlesim [
	| ttb |
	ttb :=  self home.
	ttb nodelets use: PhaROSTurtlesimNodelet as: #turtlesim.
	
	^ ttb.
]

{ #category : #construction }
PhaROSHandleController class >> url: anUrl [
	^( super url:anUrl) configureNode; yourself.
]

{ #category : #accessing }
PhaROSHandleController >> configureDependencies: aLaunchSpec [	
	self flag: #thisShouldChange.
	" now the node is being configured during the instanciation, we need to have an explicit launchtime, when we can ask packages for it launch configuration.  "
	nodelets do: [:p | p configureDependencies: aLaunchSpec ]
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

{ #category : #package }
PhaROSHandleController >> finalize [ 
	super finalize.
	nodelets finalize.

]

{ #category : #accessing }
PhaROSHandleController >> handleName [
	^ handleName ifNil: [ handleName := '/PharoHandle-' ,  DateAndTime now asUnixTime asString  ]. 
]

{ #category : #accessing }
PhaROSHandleController >> initialize [
	super initialize .
	nodelets := PhaROSNodeletContainer new  controller: self; yourself.
	tcpPort := (	(Random seed: DateAndTime now asUnixTime)  next; next; nextInt:1000) + 9000.
	xmlPort  := ((Random seed: DateAndTime now asUnixTime)  next; next; nextInt:1000) + 6000.
]

{ #category : #package }
PhaROSHandleController >> install: aPackage [
	aPackage install.
	aPackage controller: self. 
	aPackage configure
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
PhaROSHandleController >> nodelets [
	^ nodelets 
]

{ #category : #service }
PhaROSHandleController >> stop [
	master stopAndUnregister.
]

{ #category : #accessing }
PhaROSHandleController >> tcpPort [
	^tcpPort
]

{ #category : #accessing }
PhaROSHandleController >> xmlRpcPort [ 
	^ xmlPort
]
