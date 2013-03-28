Class {
	#name : #PBCommunicationTest,
	#superclass : #PBTestCase,
	#category : #'PureNGTest-Kernel'
}

{ #category : #testing }
PBCommunicationTest >> giveFinalizationSomeChanceToPerform. [
	(Delay forMilliseconds: 500) wait
]

{ #category : #testing }
PBCommunicationTest >> testBridgeFinalization [	
	| bridgeInstancesCount bridgeProcess bridgeSocket |
	bridgeInstancesCount := PNGNetworkBridge allInstances size.
	bridgeSocket := robot bridge socket.
	bridgeProcess := robot bridge activeObject process. "Get the process of the activeObject"
	
	self assert: bridgeSocket isConnected.
	self deny: bridgeProcess isTerminated.
	robot := nil.
	Smalltalk garbageCollect.
	self giveFinalizationSomeChanceToPerform.
	
	self assert: (bridgeInstancesCount > PNGNetworkBridge allInstances size).
	self deny: bridgeSocket isValid.
	self assert: bridgeProcess isTerminated. 
	
	
	

]

{ #category : #testing }
PBCommunicationTest >> testDispatcherFinalization [	
	| dispatcherInstancesCount dispatcherProcess |
	dispatcherInstancesCount := PNGMessageDispatcher allInstances size.
	dispatcherProcess := robot dispatcher activeObject process. "Get the process of the activeObject"
	
	self deny: dispatcherProcess isTerminated.
	robot := nil.
	Smalltalk garbageCollect.
	
	self assert: (dispatcherInstancesCount > PNGMessageDispatcher allInstances size).
	(Delay forMilliseconds: 100) wait. "Give dispatcher process a chance to terminate"
	self assert: dispatcherProcess isTerminated. 
	
	
	

]

{ #category : #testing }
PBCommunicationTest >> testNotificationsReceivedOnTheLastSocketUseForRequest [
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
	self shouldnt: [30 timesRepeat: [
			getSocket receiveWithTimeOutUDPDataInto: String new]] 
		raise: Exception.
	self should: [30 timesRepeat: [
			notificationInsertionSocket receiveWithTimeOutUDPDataInto: String new]] 
		raise: ConnectionTimedOut.
	


]
