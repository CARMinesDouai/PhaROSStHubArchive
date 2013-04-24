Class {
	#name : #PNGStepServiceBasedController,
	#superclass : #PNGController,
	#instVars : [
		'differentials',
		'speed',
		'mutex',
		'status',
		'notificating',
		'props',
		'angularSpeed'
	],
	#category : #'PureNG-Controllers'
}

{ #category : #commands }
PNGStepServiceBasedController >> add: aDistance of: aMotionType [ 
	differentials nextPut: aDistance -> aMotionType .
	self monitorNotification.
	
	
]

{ #category : #accessing }
PNGStepServiceBasedController >> angularSpeed [
	^ angularSpeed
]

{ #category : #accessing }
PNGStepServiceBasedController >> angularSpeed: anAngularSpeed [
	angularSpeed := anAngularSpeed 
]

{ #category : #control }
PNGStepServiceBasedController >> applyNextStep [ 
	| next |
	
	next := differentials nextOrNil.
	next ifNotNil: [
		| targetSpeed |
		targetSpeed := 0. 
		next value = PNGStepProperties rotation ifTrue: [ targetSpeed := self angularSpeed ].
		next value = PNGStepProperties translation  ifTrue: [ targetSpeed := self speed ].
		self stepService move: next key at: targetSpeed as: next value.
	] ifNil: [
		self monitorNotification.
	].
	
	
]

{ #category : #'initialize-release' }
PNGStepServiceBasedController >> initialize [ 
	differentials := SharedQueue new. 
	self speed: 0.25.
	self angularSpeed: 1.
	notificating := false.
	mutex := Mutex new.

]

{ #category : #accessing }
PNGStepServiceBasedController >> isWorking [
	^ notificating 
]

{ #category : #control }
PNGStepServiceBasedController >> manageNotification: aNotification [

		| currentStatus |
		currentStatus :=  aNotification stepProperties status.
		self status: currentStatus.
		
		((aNotification stepProperties targetDistance closeTo: aNotification stepProperties traveledDistance) or: [ aNotification stepProperties motionType = PNGStepProperties stop]) ifTrue: [
			self applyNextStep.
		].
]

{ #category : #control }
PNGStepServiceBasedController >> monitorNotification [
	
	mutex critical: [
		"(differentials isEmpty and: notificating ) ifTrue:[
			notificating := false. 
			self stepService disableNotifications.
		]."
		(differentials isEmpty not and: notificating not ) ifTrue:[
			self stepService onNotificationDo: self notificationCallback.
			self stepService enableNotificationsEvery: 40.
			notificating := true.
		]	
	].
	
]

{ #category : #control }
PNGStepServiceBasedController >> notificationCallback [ 
	^ [	: notification | self manageNotification: notification. ].
]

{ #category : #accessing }
PNGStepServiceBasedController >> speed [
	^ speed
]

{ #category : #accessing }
PNGStepServiceBasedController >> speed: aSpeed [
	self assert: aSpeed <= 2.0.
	speed := aSpeed.
]

{ #category : #accessing }
PNGStepServiceBasedController >> status [
	^ status
]

{ #category : #accessing }
PNGStepServiceBasedController >> status: aStatus [
	status := aStatus 
]

{ #category : #printing }
PNGStepServiceBasedController >> statusLabel [
	^ PNGStepProperties statusDictionary at: self status.
]

{ #category : #commands }
PNGStepServiceBasedController >> stop [
	differentials removeAll.
	self stepService stop.
	self stepService disableNotifications.
	
			


]

{ #category : #commands }
PNGStepServiceBasedController >> thenMoveForward: aDistance [
	self add: aDistance of: PNGStepProperties translation. 


]

{ #category : #commands }
PNGStepServiceBasedController >> thenRotate: aDistance [
	self add: aDistance of: PNGStepProperties rotation. 


]

{ #category : #commands }
PNGStepServiceBasedController >> thenStop [
	self add: 0.0 of: PNGStepProperties stop. 


]
