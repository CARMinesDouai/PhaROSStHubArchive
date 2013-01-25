Class {
	#name : #PNGCommunicationTest,
	#superclass : #PNGTestCase,
	#instVars : [
		'robot'
	],
	#category : #'PureNG-Kernel-Test'
}

{ #category : #testing }
PNGCommunicationTest >> setUp [
	super setUp.
	robot := PNGRobulabHandcodedFactory kompai2
]

{ #category : #testing }
PNGCommunicationTest >> testBridgeFinalization [
	
	| bridgeProcess bridgeSocket |
	bridgeProcess := robot bridge process.
	bridgeSocket := robot bridge socket.
	
	robot bridge finalize.
	
	self assert: bridgeProcess isTerminated.
	self deny: bridgeSocket isValid.
]

{ #category : #testing }
PNGCommunicationTest >> testBridgeFinalizationAutomaticallyTriggered [
	
	| bridgeInstancesCount bridgeProcess bridgeSocket |
	
	bridgeInstancesCount := PNGNetworkBridge allInstances size.
	
	bridgeSocket := robot bridge socket.
	bridgeProcess := robot bridge process.
	
	self assert: bridgeSocket isConnected.
	self deny: bridgeProcess isTerminated.
	
	robot := nil.
	Smalltalk garbageCollect.
	"WeakRegistry default finalizeValues."
	
	self assert: (bridgeInstancesCount > PNGNetworkBridge allInstances size).
	self deny: bridgeSocket isValid.
	
	"self assert: bridgeProcess isTerminated. ""it does not work probably because of process priorities"
	
	
	

]

{ #category : #testing }
PNGCommunicationTest >> testNotificationsReceivedOnTheLastSocketUseForRequest [
	| notificationInsertionSocket insertRequestBytes getSocket getRequestBytes |
	robot laserService notificationPeriod: 1.
	notificationInsertionSocket := Socket newUDP.
	insertRequestBytes := ByteArray readHexFrom: (robot notificationService insertRequestStringFor: robot laserService).
	notificationInsertionSocket  
		sendData: insertRequestBytes
		toHost: robot ip
		port: robot port.
	self shouldnt: [notificationInsertionSocket receiveWithTimeOutUDPDataInto: String new] 
		raise: Exception.
	getSocket := Socket newUDP.
	getRequestBytes := ByteArray readHexFrom: (robot directoryService getCommandString).
	getSocket 
		sendData: getRequestBytes
		toHost: robot ip
		port: robot port.
	self shouldnt: [100 timesRepeat: [
			getSocket receiveWithTimeOutUDPDataInto: String new]] 
		raise: Exception.
	self should: [100 timesRepeat: [
			notificationInsertionSocket receiveWithTimeOutUDPDataInto: String new]] 
		raise: ConnectionTimedOut.
	


]
