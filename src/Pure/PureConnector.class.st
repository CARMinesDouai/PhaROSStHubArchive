Class {
	#name : #PureConnector,
	#superclass : #Object,
	#instVars : [
		'ip',
		'port',
		'socket',
		'robot',
		'process',
		'notificating'
	],
	#classInstVars : [
		'LastID'
	],
	#category : #'Pure-Kernel'
}

{ #category : #'as yet unclassified' }
PureConnector class >> initialize [ 
	LastID := 0.
]

{ #category : #'as yet unclassified' }
PureConnector class >> ip: anIp port: aPort [
	^ self ip: anIp port: aPort robot: nil.
]

{ #category : #'as yet unclassified' }
PureConnector class >> ip: anIp port: aPort robot: aRobot [
	^ self new ip: anIp ; port: aPort ; robot: aRobot ; yourself.
]

{ #category : #service }
PureConnector >> destroy [
	
	socket destroy.
	process stop.
	robot := nil.
	
]

{ #category : #communication }
PureConnector >> discoverServices [ 
	^ process addWork: [
			self  send: '01000000'.
			 self receiveAnswer.
	].
]

{ #category : #communication }
PureConnector >> forceNotifications [
	notificating ifTrue: [
		[
			self  send: '01000000'.
			self receiveAnswer.
		] on: Error do: [ : e | 
			
		].
	].
]

{ #category : #'reception management' }
PureConnector >> inflateResponse: aByteArray [
	
	| class |
	
	class := PureResponse.
	((aByteArray at: 1) = PureConstants notificationCode) ifTrue: [
		class := PureNotification
	].
	^ class initializeFromArray: (aByteArray copyFrom: 2 to: aByteArray size) forRobot: robot.	
	
]

{ #category : #'initialize-release' }
PureConnector >> initialize [ 
	super initialize.
	socket := Socket newUDP.
	process := PureWorker pickOne.
	notificating := false.
	process onIdleTime: [
		self forceNotifications.	
	].
	process waitTimeoutInSeconds: self timeout.
]

{ #category : #accessing }
PureConnector >> ip [
	^ ip.
]

{ #category : #accessing }
PureConnector >> ip: anIp [
	ip := anIp.
]

{ #category : #accessing }
PureConnector >> notificating: aBoolean [
	notificating := aBoolean.
]

{ #category : #accessing }
PureConnector >> port [
	^port.
]

{ #category : #accessing }
PureConnector >> port: aPort [
	port := aPort. 
]

{ #category : #accessing }
PureConnector >> processName [ 
	^ 'PureConnector-', self id asString. 
]

{ #category : #'communication private' }
PureConnector >> processNotifications: aCollectionOfNotifications [ 
	(aCollectionOfNotifications size > 0 and: [ notificating ]) ifTrue: [
		robot with: NotificationManagerService do: [ :n | n notificate: aCollectionOfNotifications ].
	]
]

{ #category : #'communication private' }
PureConnector >> receiveAnswer [
  | response intent responses |
	 
	responses := OrderedCollection new.
	
	[ response := responses add: (self receiveResponse: 0). ] doWhileTrue: [
		response receivedBy: robot.
		response isNotification.
	].
	responses remove: response.
	self processNotifications: responses.
	
	^ response.  
	








]

{ #category : #'communication private' }
PureConnector >> receiveResponse: intent [
 
  | buffer responseSize response   |
	
	intent > 3 ifTrue: [ PureTooMuchTime signal. ].
	
	buffer := ByteArray new: 4096.	
		
	responseSize := (self socket receiveUDPDataInto: buffer withTimeOut: self timeout) at:1.
	
	^ responseSize = 0 ifTrue: [ 
		self receiveResponse: intent + 1 
	 ] ifFalse: [
		self inflateResponse: (buffer copyFrom: 1 to: 	responseSize)
	 ].
		
]

{ #category : #accessing }
PureConnector >> robot [
	^robot
]

{ #category : #accessing }
PureConnector >> robot: aRobotManager [
	robot := aRobotManager.
]

{ #category : #'communication private' }
PureConnector >> send: aStringMessage [
	^self socket sendData: (ByteArray readHexFrom: aStringMessage)
		toHost: self ip
		port: self port.	

]

{ #category : #communication }
PureConnector >> sendMessage: aMessage [ 
	^ process addWork: [
			| id |
			id := PureSequencer instance consumeRequestId.
			self send: id, aMessage asHex.
			self receiveAnswer. 
		].
]

{ #category : #communication }
PureConnector >> sendNotification: aMessage [ 
	process addWork:( 
		[
			self send: (PureConstants notificationCode printStringBase: 16), aMessage asHex.	
		] asWorkAt: PureWorkUnit highPriority
	).
]

{ #category : #accessing }
PureConnector >> socket [ 
	^ socket.
]

{ #category : #'communication private' }
PureConnector >> timeout [ 
	^ 0.6.
 
]
