Class {
	#name : #PNGRobulabOld,
	#superclass : #Object,
	#instVars : [
		'ip',
		'port',
		'directoryService',
		'services'
	],
	#category : #'PureNG-Kernel'
}

{ #category : #'instance creation' }
PNGRobulabOld class >> ip: aByteArray port: portNumber [ 
	^self new
		ip: aByteArray port: portNumber;
		yourself

]

{ #category : #'instance creation' }
PNGRobulabOld class >> kompai2 [
	^self kompaiVersion2010Pure41Ip: #[192 168 1 2] port: 60000 serial: '10-1-6206-2'
	
]

{ #category : #'instance creation' }
PNGRobulabOld class >> kompaiVersion2010Pure41Ip: ip port: port serial: serialString [
	|bot|
	bot := self ip: ip port:  port.
	bot serial: serialString.
	bot services: self servicesForKompaiVersion2010Pure41.
	^bot

]

{ #category : #'instance creation' }
PNGRobulabOld class >> servicesForKompaiVersion2010Pure41 [
	^{PNGBatteryService new.
	PNGDiagnosticService new.
	PNGDifferentialService new.
	PNGDirectoryService new.
	PNGDriveService new.
	PNGIOService new.
	PNGLaserService new.
	PNGLocalizationService new.
	PNGNotificationService new.
	PNGStepService new.
	PNGTelemeterService new. "Sonar"
	PNGTelemeterService new. "IR"
	PNGTrajectoryService new}

]

{ #category : #accessing }
PNGRobulabOld >> directoryService [
	^directoryService
]

{ #category : #accessing }
PNGRobulabOld >> directoryService: aDirectoryService [
	directoryService := aDirectoryService
]

{ #category : #accessing }
PNGRobulabOld >> ip [
	^ip
]

{ #category : #'initialize-release' }
PNGRobulabOld >> ip: aByteArray port: portNumber [ 
	ip := aByteArray.
	port := portNumber.
	directoryService := PNGDirectoryService for: self
]

{ #category : #accessing }
PNGRobulabOld >> port [
	^port
]

{ #category : #communication }
PNGRobulabOld >> sendAndWaitForResult: commandString [
	| responseBuffer receptionInformation rawSize responseStream |
	
	responseBuffer := ByteArray new: 1024.
	receptionInformation := self sendAndWaitForResult: PNGCommandStrings directoryServiceGetEntries withAnswer:  responseBuffer.
	rawSize := receptionInformation at: 1.
	responseStream := (ReadStream on: responseBuffer from: 1 to: rawSize).
	
	^ PNGEncodedMessage createResponseOrNotificationForData: responseStream
	

]

{ #category : #communication }
PNGRobulabOld >> sendAndWaitForResult: commandString withAnswer:  resultBuffer [
	| socket |
	socket := Socket newUDP.
	socket  sendData: (ByteArray readHexFrom: commandString)
		toHost: self ip
		port: self port.
	^ socket receiveWithTimeOutUDPDataInto: resultBuffer.
	 
]

{ #category : #accessing }
PNGRobulabOld >> serviceWithId: anInstanceID [
	^ self directoryService serviceWithId: anInstanceID.
]

{ #category : #accessing }
PNGRobulabOld >> services [
	^directoryService services
]
