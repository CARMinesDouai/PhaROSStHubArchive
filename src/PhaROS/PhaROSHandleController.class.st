"
PhaROSHandleController approach consist in use nodelets to add functionalities to a node throught the controller. This controller has a reference to the related master and also to a nodelet container, where all the nodelets can be registered.
	Diametricly different, this approach does not let create nodes but just one of class PhaROSNodeHandle, which is accessible by an accessor, and its used for all the registered nodelets to configure it needs of topics as subscribers or publishers, it allows also to define dependencies between nodelets and ROS packages in order to have enough meta data to allow dynamic spawning of foreign processes from the image using the launch facilities.
	
	The common way to register a nodelet inside this controller is talking with the nodelet container directly:
	
	+ nodelets use: ANodeletClass as: #aName
	
	The name that this controller use to register the handle node into the ROS system is a name of the form: '/PharoHandle-' ,  DateAndTime now asUnixTime asString . 
"
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
	#category : #'PhaROS-NodeControllers'
}

{ #category : #construction }
PhaROSHandleController class >> homeWithNodeNamed: aString [

	^self url: (OSProcessAccessor forThisOSProcess  environmentAt:'ROS_MASTER_URI') nodeNamed: aString.
	
]

{ #category : #construction }
PhaROSHandleController class >> url: anUrl [
	^( super url:anUrl) configureNode; yourself.
]

{ #category : #construction }
PhaROSHandleController class >> url: anUrl nodeNamed: nodeName [
	^ ( super url:anUrl) configureNodeNamed: nodeName ; yourself.
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

{ #category : #'initialize-release' }
PhaROSHandleController >> configureNodeNamed: nodeName [

	handleName := '/PharoHandle-' , nodeName.	
	self configureNode.

]

{ #category : #accessing }
PhaROSHandleController >> domain [
	| hostName |
	self flag: #askToTheHost.
	hostName := OSProcess thisOSProcess environmentAt: 'ROS_HOSTNAME'.
	hostName ifNotNil: [ ^hostName ].
	^NetNameResolver localHostName 
]

{ #category : #package }
PhaROSHandleController >> finalize [ 
	super finalize.
	nodelets finalize.
	node finalize.
	node := nil.
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

{ #category : #accessing }
PhaROSHandleController >> installHandleNode: aNode [
	node ifNotNil:[
		self error: 'This node is already installed! ' ].
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
	master stop.
]

{ #category : #accessing }
PhaROSHandleController >> tcpPort [
	^tcpPort
]

{ #category : #accessing }
PhaROSHandleController >> xmlRpcPort [ 
	^ xmlPort
]
