Class {
	#name : #PhaROSWorkspace,
	#superclass : #Object,
	#instVars : [
		'node',
		'master'
	],
	#category : #'PhaROS-Experiments'
}

{ #category : #accessing }
PhaROSWorkspace >> callerId [
	^'/', Smalltalk shortImageName.
]

{ #category : #'as yet unclassified' }
PhaROSWorkspace >> manipulatingHashes [
	(MD5 hashMessage: 'std_msgs/String') asInteger = (Number readFrom:  '128ae49ebb65f1a2ec9baf065647e23c' base: 16)
]

{ #category : #'as yet unclassified' }
PhaROSWorkspace >> master [
	 ^ 	PhaROSMasterProxy id: self callerId url: RoStBaseProtocolTest masterUrl.
]

{ #category : #'as yet unclassified' }
PhaROSWorkspace >> shutdown [

	PhaROSMaster stopAndUnregisterUrl: 'http://127.0.0.1:11311/'.
	PhaROSSystemLauncher instance  shutdownMaster.
	PhaROSSystemLauncher instance  shutdownTurtle.
	
	
	Smalltalk garbageCollect.
	self assert: PhaROSExternalNode allInstances size = 0.
	
	Smalltalk garbageCollect.
	self assert: PhaROSNode allInstances size = 0.
	
	Smalltalk garbageCollect.
	self assert: PhaROSTopic allInstances size = 0.
	
	Smalltalk garbageCollect.
	self assert: PhaROSTcpServer allInstances size = 0.
	
	Smalltalk garbageCollect.
	self assert: PhaROSMaster allInstances size = 0.
	
	Smalltalk garbageCollect.
	self assert: ApplicationService allServices size = 0.
	
	self assert: PhaROSInPutChannel allInstances size = 0.
	self assert: PhaROSOutPutChannel allInstances size = 0.

]

{ #category : #'as yet unclassified' }
PhaROSWorkspace >> startup [


	PhaROSSystemLauncher instance startUpMaster.
	PhaROSSystemLauncher instance startUpTurtle.
	
	master := PhaROSMaster url: 'http://127.0.0.1:11311/' .
]

{ #category : #'as yet unclassified' }
PhaROSWorkspace >> workspacePureMap [
" 
	self new workspacePureMap.
	self new shutdown.
"
	self shutdown.
	self startup.


"	 (RoStMaster url: 'http://127.0.0.1:11311/') lookupNode: '/PureConnector'.  "
		
	node := master create: PhaROSPureKompaiWriterNode named: '/PureConnector' domain: '127.0.0.1' xmlRpcPort:  6123.	
	node interestedIn: '/turtle1/command_velocity'.


	self halt.


]

{ #category : #'as yet unclassified' }
PhaROSWorkspace >> workspaceTurtleAccess [
" 
	self new workspaceTurtleAccess
	self new shutdown.
"
	
	self shutdown.
	self startup.
	
	master := PhaROSMaster url: 'http://127.0.0.1:11311/' .
	node := master  createNodeNamed: '/anArbitraryId' domain: '127.0.0.1' tcpPort:  9999  xmlRpcPort:  6123 soul: [
		: me |
			1 to: 20 do: [ :i |
				me sendTo: '/turtle1/command_velocity' a: [ :msg |
					msg angular: 1.0.
					msg linear: 2.0.
				].
				me sendTo: '/turtle1/command_velocity' a: [ :msg |
					msg angular: 1.0.
					msg linear: -2.0.
				].
				me sendTo: '/turtle1/command_velocity' a: [ :msg |
					msg angular: 10.0.
					msg linear: 20.0.
				].
		].
	].
	node execute.


	node sendTo: '/turtle1/command_velocity' a: [ :msg |
		msg angular: 1.0.
		msg linear: 2.0.
	].



]

{ #category : #'as yet unclassified' }
PhaROSWorkspace >> workspaceTurtleAndPureReading [
" 
	self new workspaceTurtleAndPureReading.
	self new shutdown.
"
	self shutdown.
	self startup.


"	 (RoStMaster url: 'http://127.0.0.1:11311/') lookupNode: '/PureConnector'.  "
		
	node := master  create: PhaROSPureKompaiWriterNode named: '/PureConnector' domain: '127.0.0.1' xmlRpcPort:  6123.	
	node interestedIn: '/turtle1/command_velocity'.


	self halt.


















]

{ #category : #'as yet unclassified' }
PhaROSWorkspace >> workspaceTurtleReading [
" 
	self new workspaceTurtleReading.
	self new shutdown.
"
	self shutdown.
	self startup.
	
	node := master  create: PhaROSNode named: '/ReaderSample' domain: '127.0.0.1' xmlRpcPort:  6123.	
	node interestedIn: '/turtle1/pose'.
	Transcript open.
"     
	node interestedIn: '/turtle1/command_velocity'.
"
	self halt.

]
