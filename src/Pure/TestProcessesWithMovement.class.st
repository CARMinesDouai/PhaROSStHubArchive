Class {
	#name : #TestProcessesWithMovement,
	#superclass : #TestProcesses,
	#traits : 'TLogger',
	#classTraits : 'TLogger classTrait',
	#category : #'Pure-Test-RobotDependent-Withmovement'
}

{ #category : #'as yet unclassified' }
TestProcessesWithMovement >> moveForward: aVelocity [

	robot with: DifferentialDriveService do: [
		: service |
		service load .
		service setTargetLinearSpeed: aVelocity andTargetAngularSpeed: 0.0.	
	].

]

{ #category : #'as yet unclassified' }
TestProcessesWithMovement >> rotate: aVelocity [

	robot with: DifferentialDriveService do: [
		: service |
		service load .
		service setTargetLinearSpeed: 0.0 andTargetAngularSpeed: aVelocity.	
	].

]

{ #category : #'as yet unclassified' }
TestProcessesWithMovement >> testSpawnEnableAndReceiveNoticationAndDestroyRobot [
	| localizationAssert laserAssert localizationNotifications laserNotifications |
	self warn:  'spawning robot'.
	self spawnRobot.

	( Delay forSeconds: 1 ) wait.

	self warn:  'initializing local variables'.	
	localizationAssert := Semaphore new.
	laserAssert := Semaphore new.
	
	localizationNotifications := 0.
	laserNotifications := 0.
	
	self warn:  'enabling notifications for localization'.
	robot enableNotificationsForService: LocalizationService doing: [: n | 
		localizationNotifications := localizationNotifications +1.
		self warn: ' received loc not ' , laserNotifications asString .
		localizationNotifications >= self expectedNotifications ifTrue: [
			self warn: ' disabling loc not '.
			robot disableNotificationsForService: LocalizationService.
			localizationAssert signal.
		].
	]. 
	self warn:  'enabling notifications for laser'.
	robot enableNotificationsForService: LaserService  doing: [: n | 
		laserNotifications := laserNotifications +1.
		self warn: ' received las not ' , laserNotifications asString .
		laserNotifications >= self expectedNotifications ifTrue: [
			self warn: ' disabling las not '.
			robot disableNotificationsForService: LaserService .
			laserAssert signal.
		].
	]. 

	self warn:  'configuring robot movement'.
	2 timesRepeat:[
		self warn: ' beginning movement scene '.
		self moveForward: 0.1	.
		(Delay forMilliseconds: 6000)wait.
		self moveForward: -0.1	.
		(Delay forMilliseconds: 6000)wait.
		self rotate: 0.1	.
		(Delay forMilliseconds: 6000)wait.
		self rotate: -0.1	.
		(Delay forMilliseconds: 6000)wait.
	].


	

	self warn:  'waiting for localization assert'.
	self deny: (localizationAssert  waitTimeoutSeconds: 10). 
	self warn:  'waiting for laser assert'.
	self deny: (laserAssert waitTimeoutSeconds: 10). 
	
	
	self warn:  'destroying robot'.
	self destroyRobot.
	
	
	self warn:  'testing process assertions'.
	PureProcess allSubInstances do: [
		:p | 
		self assert: p isRunning not.	
	].
	
	robot := nil. 	
	Smalltalk garbageCollect.	
	Smalltalk garbageCollect.
	
	self warn:  'testing memory assertions'.
	
	self assert: PureProcess allSubInstances size = 0.
      self assert: PureConnector allInstances size =  0.
	self assert: NotificationConsumerProcess allInstances size = 0.
	self assert: RobulabService allSubInstances size = 0.
	self assert: Robulab  allInstances size = 0.
	

	


]

{ #category : #'as yet unclassified' }
TestProcessesWithMovement >> testSpawnEnableAndReceiveNoticationCrashProcessAndDestroyRobot [
	| localizationAssert laserAssert localizationNotifications laserNotifications |
	
	self spawnRobot.
	
	( Delay forSeconds: 1 ) wait.
	
	localizationAssert := Semaphore new.
	laserAssert := Semaphore new.
	
	localizationNotifications := 0.
	laserNotifications := 0.
	
	
	robot enableNotificationsForService: LocalizationService doing: [: n | 
		localizationNotifications := localizationNotifications +1.
		localizationNotifications >= self expectedNotifications ifTrue: [
			robot disableNotificationsForService: LocalizationService.
			localizationAssert signal.
		].
	]. 
	
	robot enableNotificationsForService: LaserService  doing: [: n | 
		laserNotifications := laserNotifications +1.
		laserNotifications >= self expectedNotifications ifTrue: [
			robot disableNotificationsForService: LaserService .
			laserAssert signal.
		].
	]. 

	
	5 timesRepeat:[
		self moveForward: 0.1	.
		(Delay forMilliseconds: 6000)wait.
		self moveForward: -0.1	.
		(Delay forMilliseconds: 6000)wait.
		self rotate: 0.1	.
		(Delay forMilliseconds: 6000)wait.
		self rotate: -0.1	.
		(Delay forMilliseconds: 6000)wait.
	].


	PureProcess allSubInstances do: #stop.
	


	self deny: (localizationNotifications waitTimeoutSeconds: 10). 
	self deny: (laserAssert waitTimeoutSeconds: 10). 
	
	self destroyRobot.
	
	PureProcess allSubInstances do: [
		:p | 
		self assert: p isRunning not.	
	].
	
	robot := nil. 	
	Smalltalk garbageCollect.	
	Smalltalk garbageCollect.
	
	self assert: PureProcess allSubInstances size = 0.
      self assert: PureConnector allInstances size =  0.
	self assert: NotificationConsumerProcess allInstances size = 0.
	self assert: RobulabService allSubInstances size = 0.
	self assert: Robulab  allInstances size = 0.
	

	


]
