Class {
	#name : #PNGRobulab,
	#superclass : #Object,
	#instVars : [
		'ip',
		'port',
		'serial',
		'services'
	],
	#category : #'PureNG-Kernel'
}

{ #category : #'instance creation' }
PNGRobulab class >> ip: aByteArray port: portNumber [ 
	^self new
		ip: aByteArray port: portNumber;
		yourself

]

{ #category : #services }
PNGRobulab >> directoryService [
	^self services detect: [:each| each isKindOf: PNGDirectoryService]
]

{ #category : #accessing }
PNGRobulab >> ip [
	^ip
]

{ #category : #'initialize-release' }
PNGRobulab >> ip: aByteArray port: portNumber [ 
	ip := aByteArray.
	port := portNumber.

]

{ #category : #services }
PNGRobulab >> laserService [
	^self services detect: [:each| each isKindOf: PNGLaserService]
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
PNGRobulab >> sendAndWaitForResult: commandString [
	| responseBuffer receptionInformation rawSize responseStream encodedResponse |
	
	responseBuffer := ByteArray new: 1024.
	receptionInformation := self sendAndWaitForResult: commandString withAnswer:  responseBuffer.
	rawSize := receptionInformation at: 1.
	responseStream := (ReadStream on: responseBuffer from: 1 to: rawSize).
	
	encodedResponse := PNGEncodedMessage createResponseOrNotificationForData: responseStream.
	
	encodedResponse isSuccess ifFalse:[PNGMessageError signal: encodedResponse responseMessage].
	^encodedResponse
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
