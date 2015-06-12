Class {
	#name : #RrRobulabBody,
	#superclass : #ChaComponent,
	#instVars : [
		'driver',
		'laserPort',
		'irPort',
		'sonarsPort',
		'forwardSpeed',
		'rotationSpeed',
		'canMove'
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
RrRobulabBody >> enableMotion: aBoolean [
	aBoolean ifTrue: [ ^self startMotion ].
	self stopMotion
]

{ #category : #moving }
RrRobulabBody >> forwardAt: linearSpeed [ 
	self forwardAt: linearSpeed rotateAt: 0
]

{ #category : #moving }
RrRobulabBody >> forwardAt: metersPerSecond rotateAt: radiansPerSecond [
	forwardSpeed := metersPerSecond.
	rotationSpeed := radiansPerSecond.
]

{ #category : #'initialize-release' }
RrRobulabBody >> initialize [
	super initialize.
	forwardSpeed := 0.
	rotationSpeed := 0.
	canMove := false
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
	"The actual range is (-135 to: 135) but since some values are faulty, we work with a smaller range.
	See method #startLaserNotifyEvery:
	"
	^ (-130 to: 130) collect: [ :degree | degree degreesToRadians radians ]
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

{ #category : #'initialize-release' }
RrRobulabBody >> shutdown [
	driver finalize
]

{ #category : #'forwarding-generated' }
RrRobulabBody >> sonarTelemeterService [
	"Generated method. If you edit it please remove this comment and the pragma below"
	<forwardToIv: #driver>

	^driver sonarTelemeterService
]

{ #category : #'robot structure' }
RrRobulabBody >> sonarsAngles [
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

{ #category : #moving }
RrRobulabBody >> speedVector: aVector [
	self forwardAt: aVector length rotateAt: aVector angle
]

{ #category : #acting }
RrRobulabBody >> start [
	self startAllSensors
]

{ #category : #sensing }
RrRobulabBody >> startAllSensors [
	self startSonars.
	self startIr.
	self startLaser
]

{ #category : #sensing }
RrRobulabBody >> startIr [
	self startIrNotifyEvery: 0
]

{ #category : #sensing }
RrRobulabBody >> startIrNotifyEvery: cycles [
	self stopIr.
	self irTelemeterService 
		enableNotificationsEvery: cycles;
		onNotificationDo: [ :notif| 
			irPort set: notif distances
		]
]

{ #category : #sensing }
RrRobulabBody >> startLaser [
	self startLaserNotifyEvery: 0
]

{ #category : #sensing }
RrRobulabBody >> startLaserNotifyEvery: cycles [
	self stopLaser.
	self laserService 
		enableNotificationsEvery: cycles;
		onNotificationDo: [ : notif | 
			laserPort set: (notif distances copyFrom: 6 to: notif distances size - 5) "We filter out some values that are faulty due to the robot structure"
		]
]

{ #category : #moving }
RrRobulabBody >> startMotion [
	canMove := true.
	self differentialService moveAt: forwardSpeed and: rotationSpeed 
]

{ #category : #sensing }
RrRobulabBody >> startSonars [
	self startSonarsNotifyEvery: 0
]

{ #category : #sensing }
RrRobulabBody >> startSonarsNotifyEvery: cycles [
	self stopSonars.
	self sonarTelemeterService 
		enableNotificationsEvery: cycles;
		onNotificationDo: [ :notif| 
			sonarsPort set: notif distances
		]
]

{ #category : #acting }
RrRobulabBody >> stop [
	self stopMotion.
	self stopAllSensors
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

{ #category : #moving }
RrRobulabBody >> stopMotion [
	self differentialService moveAt: 0 and: 0.
	canMove := false.

]

{ #category : #sensing }
RrRobulabBody >> stopSonars [
	self notificationService delete: self sonarTelemeterService 
]
