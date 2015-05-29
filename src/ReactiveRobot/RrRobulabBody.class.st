Class {
	#name : #RrRobulabBody,
	#superclass : #MfForwarder,
	#instVars : [
		'driver'
	],
	#category : #'ReactiveRobot-Robulab'
}

{ #category : #'instance creation' }
RrRobulabBody class >> for: aRobot [
	^ self new driver: aRobot ; yourself.
]

{ #category : #'instance creation' }
RrRobulabBody class >> kompai1 [
	^self for: PNGRobulabHandcodedFactory kompai1
]

{ #category : #'instance creation' }
RrRobulabBody class >> kompai2 [
	^self for: PNGRobulabHandcodedFactory kompai2
]

{ #category : #'forwarding-generated' }
RrRobulabBody >> differentialService [
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #driver>

	^driver differentialService
]

{ #category : #accessing }
RrRobulabBody >> driver [
	^driver
]

{ #category : #accessing }
RrRobulabBody >> driver: robotDriver [
	driver := robotDriver
]

{ #category : #moving }
RrRobulabBody >> forwardAt: linearSpeed [ 
	self forwardAt: linearSpeed rotateAt: 0
]

{ #category : #moving }
RrRobulabBody >> forwardAt: linearSpeed rotateAt: angularSpeed [
	self differentialService moveAt: linearSpeed and: angularSpeed 
]

{ #category : #'robot structure' }
RrRobulabBody >> irAngles [
	| pi |
	pi := VeAngle pi.
	^ {(pi / 12).
	(pi / 4).
	(3 * pi / 8).
	(pi / 2).
	(5 * pi / 8).
	(3 * pi / 4).
	(11 * pi / 12).
	pi.
	(-11 * pi / 12).
	(-3 * pi / 4).
	(-5 * pi / 8).
	(-1 * pi / 2).
	(-3 * pi / 8).
	(-1 * pi / 4).
	(-1 * pi / 12).
	(0 radians)}
]

{ #category : #'forwarding-generated' }
RrRobulabBody >> irTelemeterService [
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #driver>

	^driver irTelemeterService
]

{ #category : #'robot structure' }
RrRobulabBody >> laserAngles [
	^ (-135 to: 135) collect: [ :degree | degree degreesToRadians radians ]
]

{ #category : #'forwarding-generated' }
RrRobulabBody >> laserService [
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #driver>

	^driver laserService
]

{ #category : #'forwarding-generated' }
RrRobulabBody >> localizationService [
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #driver>

	^driver localizationService
]

{ #category : #'forwarding-generated' }
RrRobulabBody >> notificationService [
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #driver>

	^driver notificationService
]

{ #category : #moving }
RrRobulabBody >> rotateAt: angularSpeed [
	self forwardAt: 0 rotateAt: angularSpeed
]

{ #category : #sensing }
RrRobulabBody >> scanIrEvery: cycles do: aBlock [
	self stopIr.
	self irTelemeterService 
		enableNotificationsEvery: cycles;
		onNotificationDo: [ :notif| 
			aBlock cull: notif distances
		]
]

{ #category : #sensing }
RrRobulabBody >> scanLaserEvery: cycles do: aBlock [
	self stopLaser.
	self laserService 
		enableNotificationsEvery: cycles;
		onNotificationDo: [ :notif| 
			aBlock cull: notif distances
		]
]

{ #category : #sensing }
RrRobulabBody >> scanSonarsEvery: cycles do: aBlock [
	self stopSonars.
	self sonarTelemeterService 
		enableNotificationsEvery: cycles;
		onNotificationDo: [ :notif| 
			aBlock cull: notif distances
		]
]

{ #category : #'initialize-release' }
RrRobulabBody >> shutdown [
	driver finalize
]

{ #category : #'robot structure' }
RrRobulabBody >> sonarAngles [
	| pi |
	pi := VeAngle pi.
	^ {(pi / 12).
	(pi / 4).
	(pi / 2).
	(3 * pi / 4).
	pi.
	(-3 * pi / 4).
	(-1 * pi / 2).
	(-1 * pi / 4).
	(-1 * pi / 12)}
]

{ #category : #'forwarding-generated' }
RrRobulabBody >> sonarTelemeterService [
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #driver>

	^driver sonarTelemeterService
]

{ #category : #moving }
RrRobulabBody >> speedVector: aVector [
	self forwardAt: aVector length rotateAt: aVector angle
]

{ #category : #moving }
RrRobulabBody >> stop [
	self forwardAt: 0 rotateAt: 0
]

{ #category : #sensing }
RrRobulabBody >> stopAllSensors [
	self notificationService deleteAllNotifyingServices
]

{ #category : #sensing }
RrRobulabBody >> stopIr [
	self notificationService delete: self irTelemeterService 
]

{ #category : #sensing }
RrRobulabBody >> stopLaser [
	self notificationService delete: self laserService 
]

{ #category : #sensing }
RrRobulabBody >> stopSonars [
	self notificationService delete: self sonarTelemeterService 
]
