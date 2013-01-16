Class {
	#name : #PNGRobulabHandcodedFactory,
	#superclass : #Object,
	#category : #'PureNG-Factories'
}

{ #category : #services }
PNGRobulabHandcodedFactory class >> batteryService [
	^PNGBatteryService newWithId: 10
]

{ #category : #services }
PNGRobulabHandcodedFactory class >> diagnosticService [
	^PNGDiagnosticService newWithId: 9
]

{ #category : #services }
PNGRobulabHandcodedFactory class >> differentialService [
	^PNGDifferentialService newWithId: 3
]

{ #category : #services }
PNGRobulabHandcodedFactory class >> directoryService [
	^PNGDirectoryService newWithId: 0
]

{ #category : #services }
PNGRobulabHandcodedFactory class >> driveService [
	^PNGDriveService newWithId: 8
]

{ #category : #services }
PNGRobulabHandcodedFactory class >> ioService [
	^PNGIOService newWithId: 2
]

{ #category : #services }
PNGRobulabHandcodedFactory class >> irTelemeterService [
	^PNGTelemeterService newWithId: 7
]

{ #category : #factory }
PNGRobulabHandcodedFactory class >> kompai2 [
	^self kompaiVersion2010Pure41Ip: #[192 168 1 2] port: 60000 serial: '10-1-6206-2'
	
]

{ #category : #factory }
PNGRobulabHandcodedFactory class >> kompaiVersion2010Pure41Ip: ip port: port serial: serialString [
	|bot|
	bot := PNGRobulab ip: ip port:  port.
	bot serial: serialString.
	bot services: self servicesForKompaiVersion2010Pure41.
	^bot

]

{ #category : #services }
PNGRobulabHandcodedFactory class >> laserService [
	^PNGLaserService newWithId: 4
]

{ #category : #services }
PNGRobulabHandcodedFactory class >> localizationService [
	^PNGLocalizationService newWithId: 5
]

{ #category : #services }
PNGRobulabHandcodedFactory class >> notificationService [
	^PNGNotificationService newWithId: 1
]

{ #category : #services }
PNGRobulabHandcodedFactory class >> servicesForKompaiVersion2010Pure41 [
	^{self batteryService.
	self diagnosticService.
	self differentialService.
	self directoryService.
	self driveService.
	self ioService.
	self laserService.
	self localizationService.
	self notificationService.
	self stepService.
	self sonarTelemeterService.
	self irTelemeterService.
	self trajectoryService}

]

{ #category : #services }
PNGRobulabHandcodedFactory class >> sonarTelemeterService [
	^PNGTelemeterService newWithId: 6
]

{ #category : #services }
PNGRobulabHandcodedFactory class >> stepService [
	^PNGStepService newWithId: 12
]

{ #category : #services }
PNGRobulabHandcodedFactory class >> trajectoryService [
	^PNGTrajectoryService newWithId: 11
]
