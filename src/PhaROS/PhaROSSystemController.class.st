"
A ROS controller is an object that define how to interact with nodes: how to build them, how to register them in the system.
We have two main flavors of controllers, each one with a different approach of usage of the nodes in an image.


* PhaROSMasiveNodeController approach consist in subclass PhaROSNode (or subclass) for each needed functionality, as the main idea of the ROS system, in order to do this, Masive controller expose some Node building methods, all of this methods receive as first parameter the class to instantiate, also name and domain of the node. The rest of the parameters change in terms of specific building:

	+ create: aNodeClass named: name domain: aDomain tcpPort: aTcpPort xmlRpcPort: aXmlRpcPort  --- Spawn any kind of node for publishing and subscribing
	+ create: aNodeClass named: name domain: aDomain tcpPort: aTcpPort xmlRpcPort: aXmlRpcPort delegate: aReceiverDelegateOrBlock  --- Spawn any kind of node for publishing and subscribing with a specific delegate
	+ create: aSouledNodeClass named: name domain: aDomain tcpPort: aTcpPort xmlRpcPort: aXmlRpcPort soul: aBlock  --- Spawn a node with soul block (PhaROSBlockNode or subclass) for publish and subscribing
	+ create: aSouledNodeClass named: name domain: aDomain tcpPort: aTcpPort xmlRpcPort: aXmlRpcPort soul: aBlock delegate: aReceiverDelegateOrBlock --- Spawn a node with soul block (PhaROSBlockNode or subclass) for publish and subscribing  with a specific delegate
	+ create: aNodeClass named: name domain: aDomain xmlRpcPort: aXmlRpcPort  --- Spawn any kind of node for subscribing
	+ create: aSouledNodeClass named: name domain: aDomain xmlRpcPort: aXmlRpcPort delegate: aReceiverDelegateOrBlock --- Spawn a node with soul block (PhaROSBlockNode or subclass)  for subscribing.
	


* PhaROSHandleController approach consist in use nodelets to add functionalities to a node throught the controller. This controller has a reference to the related master and also to a nodelet container, where all the nodelets can be registered.
	Diametricly different, this approach does not let create nodes but just one of class PhaROSNodeHandle, which is accessible by an accessor, and its used for all the registered nodelets to configure it needs of topics as subscribers or publishers, it allows also to define dependencies between nodelets and ROS packages in order to have enough meta data to allow dynamic spawning of foreign processes from the image using the launch facilities.
	
	The common way to register a nodelet inside this controller is talking with the nodelet container directly:
	
	+ nodelets use: ANodeletClass as: #aName
	
	The name that this controller use to register the handle node into the ROS system is a name of the form: '/PharoHandle-' ,  DateAndTime now asUnixTime asString . 
"
Class {
	#name : #PhaROSSystemController,
	#superclass : #Object,
	#instVars : [
		'master'
	],
	#category : #'PhaROS-Controllers'
}

{ #category : #'as yet unclassified' }
PhaROSSystemController class >> for: aMaster [ 
	^ self new master: aMaster; yourself.
]

{ #category : #'as yet unclassified' }
PhaROSSystemController class >> home [
	^self url: (OSProcessAccessor forThisOSProcess  environmentAt:'ROS_MASTER_URI').
]

{ #category : #'as yet unclassified' }
PhaROSSystemController class >> localhost [
	^self url: 'http://127.0.0.1:11311/'.
]

{ #category : #'as yet unclassified' }
PhaROSSystemController class >> url: anUrl [

	^self for: (PhaROSMaster url: anUrl ).
]

{ #category : #accessing }
PhaROSSystemController >> asPhaROSController [
	^ self
]

{ #category : #accessing }
PhaROSSystemController >> finalize [ 
	master stop.
	master := nil.
]

{ #category : #accessing }
PhaROSSystemController >> master:aMaster [
	master := aMaster
]
