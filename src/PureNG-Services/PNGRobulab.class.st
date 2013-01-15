Class {
	#name : #PNGRobulab,
	#superclass : #Object,
	#instVars : [
		'ip',
		'port',
		'directoryService'
	],
	#category : #'PureNG-Kernel'
}

{ #category : #'instance creation' }
PNGRobulab class >> ip: aByteArray port: portNumber [ 
	^self new
		ip: aByteArray port: portNumber;
		yourself

]

{ #category : #accessing }
PNGRobulab >> directoryService [
	^directoryService
]

{ #category : #accessing }
PNGRobulab >> directoryService: aDirectoryService [
	directoryService := aDirectoryService
]

{ #category : #accessing }
PNGRobulab >> instanceRelatedTo: anInstanceID [
	^ self directoryService instanceRelatedTo: anInstanceID.
]

{ #category : #accessing }
PNGRobulab >> ip [
	^ip
]

{ #category : #'initialize-release' }
PNGRobulab >> ip: aByteArray port: portNumber [ 
	ip := aByteArray.
	port := portNumber.
	directoryService := PNGDirectoryService for: self
]

{ #category : #accessing }
PNGRobulab >> port [
	^port
]

{ #category : #communication }
PNGRobulab >> sendAndWaitForResult: commandString [
	| responseBuffer receptionInformation rawSize responseBytes |
	
	responseBuffer := ByteArray new: 1024.
	receptionInformation := self sendAndWaitForResult: PNGCommandStrings directoryServiceGetEntries withAnswer:  responseBuffer.
	rawSize := receptionInformation at: 1.
	responseBytes := (responseBuffer copyFrom: 1 to: rawSize).
	
	^ PNGPureEncodedMessage createResponseOrNotificationForData: responseBytes andRobot: self 
	

]

{ #category : #communication }
PNGRobulab >> sendAndWaitForResult: commandString withAnswer:  resultBuffer [
	| socket |
	socket := Socket newUDP.
	socket  sendData: (ByteArray readHexFrom: commandString)
		toHost: self ip
		port: self port.
	^ socket receiveWithTimeOutUDPDataInto: resultBuffer.
	 
]

{ #category : #accessing }
PNGRobulab >> services [
	^directoryService services
]
