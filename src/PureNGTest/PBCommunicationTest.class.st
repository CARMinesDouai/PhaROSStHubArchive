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
	| bridgeInstancesCount  bridgeSocket |
	bridgeInstancesCount := PNGNetworkBridge allInstances size.
	bridgeSocket := robot bridge socket.
	
	self assert: bridgeSocket isConnected.
	self assert: robot bridge activeObject isStarted.
	robot := nil.
	Smalltalk garbageCollect.
	self giveFinalizationSomeChanceToPerform.
	
	self assert: (bridgeInstancesCount > PNGNetworkBridge allInstances size).
	self deny: bridgeSocket isValid.
	
	

]

{ #category : #testing }
PBCommunicationTest >> testDispatcherFinalization [	
	| dispatcherInstancesCount |
	dispatcherInstancesCount := PNGMessageDispatcher allInstances size.
	self assert: robot dispatcher activeObject isStarted.

	robot := nil.
	Smalltalk garbageCollect.
	
	self assert: (dispatcherInstancesCount > PNGMessageDispatcher allInstances size).
	
	

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
