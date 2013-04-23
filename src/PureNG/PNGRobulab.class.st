Class {
	#name : #PNGRobulab,
	#superclass : #Object,
	#instVars : [
		'ip',
		'port',
		'serial',
		'services',
		'bridge',
		'dispatcher',
		'latestResponse',
		'commandResultSemaphore'
	],
	#category : #'PureNG-Kernel'
}

{ #category : #'instance creation' }
PNGRobulab class >> ip: aByteArray port: portNumber [ 
	^self new
		ip: aByteArray port: portNumber;
		defaultConfiguration;
		yourself.

]

{ #category : #'instance creation' }
PNGRobulab class >> recordingInstanceForIp: aByteArray port: portNumber [ 
	^self new
		ip: aByteArray port: portNumber;
		recordingConfiguration;
		yourself.

]

{ #category : #accessing }
PNGRobulab >> bridge [
	^ bridge
]

{ #category : #'initialize-release' }
PNGRobulab >> defaultConfiguration [
	bridge := PNGNetworkBridge forRobot: self.
	self dispatcher: (PNGMessageDispatcher forRobot: self).
	self finalizationRegistry add: self
]

{ #category : #'initialize-release' }
PNGRobulab >> deleteAllNotifyingServices [
	self notificationService deleteAllNotifyingServices
]

{ #category : #services }
PNGRobulab >> directoryService [
	^self services detect: [:each| each isKindOf: PNGDirectoryService]
]

{ #category : #accessing }
PNGRobulab >> dispatcher [
	^ dispatcher
]

{ #category : #accessing }
PNGRobulab >> dispatcher: anObject [
	dispatcher := anObject
]

{ #category : #'initialize-release' }
PNGRobulab >> finalize [
	self bridge stop.
	self dispatcher stop.
]

{ #category : #'initialize-release' }
PNGRobulab >> initialize [ 
	super initialize.
	commandResultSemaphore := Semaphore new
]

{ #category : #accessing }
PNGRobulab >> ip [
	^ip
]

{ #category : #accessing }
PNGRobulab >> ip: aByteArray port: portNumber [ 
	ip := aByteArray.
	port := portNumber.

]

{ #category : #services }
PNGRobulab >> irTelemeterService [
	^self services detect: [:each| (each isKindOf: PNGTelemeterService) and:[each id = 6]].
]

{ #category : #services }
PNGRobulab >> laserService [
	^self services detect: [:each| each isKindOf: PNGLaserService]
]

{ #category : #communication }
PNGRobulab >> latestResponse [
	| result |
	result := latestResponse.
	latestResponse := nil.
	commandResultSemaphore initSignals. "Consume any excess signals"
	^result
]

{ #category : #services }
PNGRobulab >> localizationService [
	^self services detect: [:each| each isKindOf: PNGLocalizationService ]
]

{ #category : #services }
PNGRobulab >> notificationService [
	^self services detect: [:each| each isKindOf: PNGNotificationService]
]

{ #category : #accessing }
PNGRobulab >> port [
	^port
]

{ #category : #communication }
PNGRobulab >> receiveCommandResult: aResponse [
	latestResponse := aResponse.
	commandResultSemaphore signal
]

{ #category : #'initialize-release' }
PNGRobulab >> recordingConfiguration [
	bridge := PNGMultipleDispatcherNetworkBridge forRobot: self.
	self dispatcher: (PNGMessageDispatcher forRobot: self).
	self finalizationRegistry add: self
]

{ #category : #communication }
PNGRobulab >> sendAndWaitForResult: commandString [
	|   response encodedResponse |
	bridge send: commandString.
	(commandResultSemaphore waitTimeoutMSecs: 1500) ifTrue: [PNGConnectionTimeOut signal].
	response := self latestResponse.
	response isSuccess ifFalse: [  PNGMessageError signal: response responseMessage ].
	^response
]

{ #category : #communication }
PNGRobulab >> sendNotification: commandString [
	bridge send: commandString.
	
]

{ #category : #accessing }
PNGRobulab >> serial [
	^ serial
]

{ #category : #accessing }
PNGRobulab >> serial: anObject [
	serial := anObject
]

{ #category : #services }
PNGRobulab >> serviceWithId: id [

	^self services detect:[:aService | aService id = id]
]

{ #category : #accessing }
PNGRobulab >> services [
	^services
]

{ #category : #accessing }
PNGRobulab >> services: collectionOfServices [
	services := collectionOfServices.
	services do: [:each| each robot: self]
]

{ #category : #services }
PNGRobulab >> sonarTelemeterService [
	^self services detect: [:each| (each isKindOf: PNGTelemeterService) and:[each id = 7]].
]

{ #category : #services }
PNGRobulab >> stepService [
	^self services detect: [:each| each isKindOf: PNGStepService]
]

{ #category : #accessing }
PNGRobulab >> timestamp [
	^self trajectoryService get timestamp
]

{ #category : #services }
PNGRobulab >> trajectoryService [
	^self services detect: [:each| each isKindOf: PNGTrajectoryService]
]
