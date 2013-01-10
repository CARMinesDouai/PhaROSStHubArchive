Class {
	#name : #TestConnector,
	#superclass : #TestCase,
	#instVars : [
		'robot',
		'connector'
	],
	#category : #'Pure-Test-RobotDependent'
}

{ #category : #'as yet unclassified' }
TestConnector >> destroyConnector [
	connector destroy.
	
	
	
]

{ #category : #'as yet unclassified' }
TestConnector >> destroyRobot [
	robot destroy.
]

{ #category : #'as yet unclassified' }
TestConnector >> spawnConnector [ 
	connector := PureConnector ip: #[192 168 1 2] port: 60000.
]

{ #category : #'as yet unclassified' }
TestConnector >> spawnRobot [
	robot := Robulab newWith: #[192 168 1 2] and: 60000.
]

{ #category : #'as yet unclassified' }
TestConnector >> testSpawnAndDestroyConnector [

	self spawnConnector.
	(Delay forSeconds: 1) wait.
	self destroyConnector.

	self assert: connector isRunning not.
	connector := nil. 
	
	Smalltalk garbageCollect.	
	Smalltalk garbageCollect.
	self assert: (PureConnector allInstances size = 0).
	



]

{ #category : #'as yet unclassified' }
TestConnector >> testSpawnAndDestroyRobot [

	self spawnRobot.
	( Delay forSeconds: 1 ) wait.
	self destroyRobot.
	
	PureProcess allSubInstances do: [
		: p | 
		self assert: p isRunning not.	
	].
	
	robot := nil. 	
	Smalltalk garbageCollect.	
	Smalltalk garbageCollect.
	
	self assert: PureProcess allSubInstances size = 0.
	self assert: RobulabService allSubInstances size = 0.
	self assert: Robulab  allInstances size = 0.
	

	


]

{ #category : #'as yet unclassified' }
TestConnector >> testSpawnEnableAndReceiveNoticationAndDestroyRobot [
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
TestConnector >> testSpawnEnableAndReceiveNoticationCrashProcessAndDestroyRobot [
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

	
	(Delay forSeconds: 1) wait.
	
	PureProcess allSubInstances do: #stop.
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
TestConnector >> testSpawnEnableDisableNoticationAndDestroyRobot [
	| lockAssert |
	
	self spawnRobot.
	
	( Delay forSeconds: 1 ) wait.
	
	lockAssert := Semaphore new.
	
	robot enableNotificationsForService: LocalizationService doing: [: n | 
	      self assert: PureConnector allInstances size =  2.
		self assert: NotificationConsumerProcess allInstances size = 1.
		robot disableNotificationsForService: LocalizationService.
		lockAssert signal.	
	]. 
	

	self deny: (lockAssert waitTimeoutSeconds: 2). 
	
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
TestConnector >> testSpawnEnableNoticationAndDestroyRobot [
	| lockAssert |
	
	self spawnRobot.
	
	( Delay forSeconds: 1 ) wait.
	
	lockAssert := Semaphore new.
	
	robot enableNotificationsForService: LocalizationService doing: [: n | 
	      self assert: PureConnector allInstances size =  2.
		self assert: NotificationConsumerProcess allInstances size = 1.
		lockAssert signal.	
	]. 
	

	self deny: (lockAssert waitTimeoutSeconds: 2). 
	
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
TestConnector >> testSpawnEnableNoticationCrashConnectorAndDestroyRobot [
	| lockAssert |
	
	self spawnRobot.
	
	( Delay forSeconds: 1 ) wait.
	
	lockAssert := Semaphore new.
	
	robot enableNotificationsForService: LocalizationService doing: [: n | 
		PureConnector allInstances do: #stop.
		lockAssert signal.	
	]. 
	

	self deny: (lockAssert waitTimeoutSeconds: 2). 
	
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
TestConnector >> testSpawnEnableNoticationCrashNotificatorAndDestroyRobot [
	| lockAssert |
	
	self spawnRobot.
	
	( Delay forSeconds: 1 ) wait.
	
	lockAssert := Semaphore new.
	
	robot enableNotificationsForService: LocalizationService doing: [: n | 
		NotificationConsumerProcess allInstances do: #stop.
		lockAssert signal.	
	]. 
	

	self deny: (lockAssert waitTimeoutSeconds: 2). 
	
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
TestConnector >> testSpawnEnableNoticationCrashProcessesAndDestroyRobot [
	| lockAssert |
	
	self spawnRobot.
	
	( Delay forSeconds: 1 ) wait.
	
	lockAssert := Semaphore new.
	
	robot enableNotificationsForService: LocalizationService doing: [: n | 
		PureProcess allSubInstances do: #stop.
		
		lockAssert signal.	
	]. 
	

	self deny: (lockAssert waitTimeoutSeconds: 2). 
	
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
TestConnector >> testSpawnLoadAndDestroyRobot [

	self spawnRobot.
	( Delay forSeconds: 1 ) wait.
	
	robot with: LocalizationService do: #load.
	
	self destroyRobot.
	
	PureProcess allSubInstances do: [
		:p | 
		self assert: p isRunning not.	
	].
	
	robot := nil. 	
	Smalltalk garbageCollect.	
	Smalltalk garbageCollect.
	
	self assert: PureProcess allSubInstances size = 0.
	self assert: RobulabService allSubInstances size = 0.
	self assert: Robulab  allInstances size = 0.
	

	


]
