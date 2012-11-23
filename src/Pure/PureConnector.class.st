Class {
	#name : #PureConnector,
	#superclass : #PureProcess,
	#instVars : [
		'ip',
		'port',
		'socket',
		'robot',
		'queue',
		'forWork',
		'queueMutex',
		'keepReceiving'
	],
	#category : #'Pure-Kernel'
}

{ #category : #'as yet unclassified' }
PureConnector class >> ip: anIp port: aPort [
	^ self new ip: anIp ; port: aPort ; startUp; yourself.
]

{ #category : #processing }
PureConnector >> addWork: aWork [
	queueMutex critical: [
		queue add: aWork.
	].
	forWork signal.
	^ aWork.
]

{ #category : #service }
PureConnector >> destroy [
	self stop.
	socket destroy.
	robot := nil.
]

{ #category : #communication }
PureConnector >> discoverServices [ 

	^ self addWork: 
		(PureWorkUnit do: [
			self  send: '01000000'.
			 self receiveAnswer.
		]).
]

{ #category : #'reception management' }
PureConnector >> inflateResponse: aByteArray [
	| class |
	class := PureResponse.
	((aByteArray at: 1) = self notificationCode) ifTrue: [
		class := PureNotification
	].
	^ class initializeFromArray: (aByteArray copyFrom: 2 to: aByteArray size) forRobot: robot.	
	
]

{ #category : #'initialize-release' }
PureConnector >> initialize [ 
	super initialize.
	socket := Socket newUDP.
	queueMutex := Mutex new.
	queue := SortedCollection sortBlock: [ :w1 :w2 | w1 < w2 ].
	forWork  := Semaphore new.
	keepReceiving := true.
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
PureConnector >> keepReceiving [ 
	| val |
	processMutex  critical: [
		val := keepReceiving.
	].
	^val. 
]

{ #category : #constants }
PureConnector >> notificationCode [
	^ 16rFF.
]

{ #category : #processing }
PureConnector >> peekWork [
	| work |
	queueMutex critical: [
		work := queue at:1. 
		queue remove: work.
	].

	^ work.
]

{ #category : #accessing }
PureConnector >> port [
	^port.
]

{ #category : #accessing }
PureConnector >> port: aPort [
	port := aPort. 
]

{ #category : #'communication private' }
PureConnector >> receiveAnswer [
  | buffer responseSize response |
	[
		buffer := ByteArray new: 3000.
		self socket waitForData.
		responseSize := (self socket receiveUDPDataInto:  buffer) at:1.
		response := self inflateResponse: (buffer copyFrom: 1 to: 	responseSize).
	] doWhileTrue: [
		response received.
		response isNotification & self keepReceiving.
	].

	^ response. 
]

{ #category : #accessing }
PureConnector >> robot [
	^robot
]

{ #category : #accessing }
PureConnector >> robot: aRobotManager [
	robot := aRobotManager.
]

{ #category : #processing }
PureConnector >> run [
	| job |
	forWork wait.
	job := self peekWork.
	job execute: self. 
	
]

{ #category : #'communication private' }
PureConnector >> send: aStringMessage [
	self socket sendData: (ByteArray readHexFrom: aStringMessage)
		toHost: self ip
		port: self port.	

	
		
]

{ #category : #communication }
PureConnector >> sendMessage: aMessage [ 
	^ self addWork: 
		(PureWorkUnit do: [
			| id |
			id := PureSequencer instance consumeRequestId.
			self send: id, aMessage asHex.
			self receiveAnswer. 
		]).
]

{ #category : #communication }
PureConnector >> sendNotification: aMessage [ 
	self addWork: 
		(PureWorkUnit do: [
			self send: (self notificationCode printStringBase: 16), aMessage asHex.	
		] at: PureWorkUnit highPriority).
]

{ #category : #accessing }
PureConnector >> socket [ 
	^ socket.
]

{ #category : #accessing }
PureConnector >> stopReception [ 
	processMutex  critical: [
		keepReceiving := false.
	].
]
