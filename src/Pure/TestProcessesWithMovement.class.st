Class {
	#name : #TestProcessesWithMovement,
	#superclass : #TestProcesses,
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
	
	self spawnRobot.
	
	( Delay forSeconds: 1 ) wait.
	
	localizationAssert := Semaphore new.
	laserAssert := Semaphore new.
	
	localizationNotifications := 0.
	laserNotifications := 0.
	
	
	robot enableNotificationsForService: LocalizationService doing: [: n | 
		localizationNotifications := localizationNotifications +1.
		localizationNotifications >= 3000 ifTrue: [
			robot disableNotificationsForService: LocalizationService.
			localizationAssert signal.
		].
	]. 
	
	robot enableNotificationsForService: LaserService  doing: [: n | 
		laserNotifications := laserNotifications +1.
		laserNotifications >= 3000 ifTrue: [
			robot disableNotificationsForService: LaserService .
			laserAssert signal.
		].
	]. 

	
	200 timesRepeat:[
		self moveForward: 0.1	.
		(Delay forMilliseconds: 6000)wait.
		self moveForward: -0.1	.
		(Delay forMilliseconds: 6000)wait.
		self rotate: 0.1	.
		(Delay forMilliseconds: 6000)wait.
		self rotate: -0.1	.
		(Delay forMilliseconds: 6000)wait.
	].


	


	self deny: (localizationNotifications waitTimeoutSeconds: 20). 
	self deny: (laserAssert waitTimeoutSeconds: 20). 
	
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
		localizationNotifications >= 3000 ifTrue: [
			robot disableNotificationsForService: LocalizationService.
			localizationAssert signal.
		].
	]. 
	
	robot enableNotificationsForService: LaserService  doing: [: n | 
		laserNotifications := laserNotifications +1.
		laserNotifications >= 3000 ifTrue: [
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
