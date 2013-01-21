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
		'keepReceiving',
		'id'
	],
	#classInstVars : [
		'LastID'
	],
	#category : #'PureNoLog-Kernel'
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
	LastID:= LastID +1.
	^ self new ip: anIp ; port: aPort ; robot: aRobot ; id: LastID ; startUp ; yourself.
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
	queue removeAll.
	queue := nil.
]

{ #category : #communication }
PureConnector >> discoverServices [ 

	^ self addWork: 
		(PureWorkUnit do: [
			self  send: '01000000'.
			 self receiveAnswer.
		]).
]

{ #category : #accessing }
PureConnector >> id [
	^ id.
]

{ #category : #accessing }
PureConnector >> id: anID [
	id := anID.
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

{ #category : #accessing }
PureConnector >> processName [ 
	^ 'PureConnector-', self id asString. 
]

{ #category : #'communication private' }
PureConnector >> receiveAnswer [
  | buffer responseSize response intent responses |

	intent := 0. 
	responses := OrderedCollection new.
	[
		
		buffer := ByteArray new: 4096.	
		[	
			intent := intent +1.
			responseSize := (self socket receiveUDPDataInto: buffer withTimeOut: self receptionTimeOutSeconds) at:1.
		] doWhileTrue: [
			responseSize = 0 and:[ intent < 3]
		].
		
		responseSize = 0 ifTrue: [
			PureTooMuchTime signal.
		].
		response := self inflateResponse: (buffer copyFrom: 1 to: 	responseSize).
		responses add: response.
			
	] doWhileTrue: [
		response isNotification & self keepReceiving.
	].
     "Get out the lastone, which is the response"

	self keepReceiving ifTrue: [
		responses remove: response.
		[ 
			responses :=
			responses reversed inject: OrderedCollection new into: [ :acc :it | 
				acc detect: [ :e | e class = it class ] ifNone: [ acc add: it].
				acc.
			].
		
			(Delay forMilliseconds: 500) wait.
			responses do: #received.		
		] forkAt: Processor userBackgroundPriority  named: 'NotificationDispatcher'.
		
	].

	response received.
	^ response.  
	








]

{ #category : #'communication private' }
PureConnector >> receptionTimeOutSeconds [ 
	^2
 
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
	| size |
	

	size := self socket sendData: (ByteArray readHexFrom: aStringMessage)
		toHost: self ip
		port: self port.	


]

{ #category : #communication }
PureConnector >> sendMessage: aMessage [ 
	^ self addWork: 
		(PureWorkUnit do: [
			| id |
			id := PureSequencer instance consumeRequestId.
			Transcript show: (id, aMessage asHex) asString.
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
