Class {
	#name : #TestProcesses,
	#superclass : #TestCase,
	#instVars : [
		'robot',
		'connector'
	],
	#category : #'Pure-Test-RobotDependent'
}

{ #category : #auxiliar }
TestProcesses >> destroyConnector [
	connector destroy.
	
	
	
]

{ #category : #auxiliar }
TestProcesses >> destroyRobot [
	robot destroy.
]

{ #category : #auxiliar }
TestProcesses >> expectedNotifications [
	^ 10.
]

{ #category : #auxiliar }
TestProcesses >> spawnConnector [ 
	connector := PureConnector ip: #[192 168 1 2] port: 60000.
]

{ #category : #auxiliar }
TestProcesses >> spawnRobot [
	robot := Robulab newWith: #[192 168 1 2] and: 60000.
]

{ #category : #configuration }
TestProcesses >> tearDown [ 
	super tearDown.
	Smalltalk garbageCollect.
	Smalltalk garbageCollect.
	Smalltalk garbageCollect.
	Smalltalk garbageCollect.
]

{ #category : #tests }
TestProcesses >> testSpawnAndDestroyConnector [

	self spawnConnector.
	(Delay forSeconds: 1) wait.
	self destroyConnector.

	self assert: connector isRunning not.
	connector := nil. 
	
	Smalltalk garbageCollect.	
	Smalltalk garbageCollect.
	self assert: (PureConnector allInstances size = 0).
	



]

{ #category : #tests }
TestProcesses >> testSpawnAndDestroyRobot [

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

{ #category : #'freezing-test' }
TestProcesses >> testSpawnEnableAndReceiveNoticationAndDestroyRobot [
	| localizationAssert laserAssert localizationNotifications laserNotifications |
	
	self spawnRobot.
	
	( Delay forSeconds: 1 ) wait.
	
	localizationAssert := Semaphore new.
	laserAssert := Semaphore new.
	
	localizationNotifications := 0.
	laserNotifications := 0.
	
	
	robot with: LocalizationService do: [ : localization | 
		localization whenANotificationArrivesDo: [
			:n |	
				localizationNotifications := localizationNotifications +1.
				localizationNotifications >= self expectedNotifications  ifTrue: [
					localization disableNotifications.
					localizationAssert signal.
				].
		].	
		localization enableNotifications.
	
	]. 


	robot with: LaserService do: [ : laser | 
		laser whenANotificationArrivesDo: [
			:n |	
				laserNotifications := laserNotifications +1.
				laserNotifications >= self expectedNotifications  ifTrue: [
					laser disableNotifications.
					laserAssert signal.
				].
		].	
		laser enableNotifications.
	]. 




	self assert: ((localizationAssert waitTimeoutSeconds: 10) not or:[ laserNotifications = 10 & localizationNotifications =10]). 
	self assert: ((laserAssert waitTimeoutSeconds: 10 ) not or:[ laserNotifications = 10 & localizationNotifications =10]). 
	
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

{ #category : #'tests-with-crash' }
TestProcesses >> testSpawnEnableAndReceiveNoticationCrashProcessAndDestroyRobot [
	| localizationAssert laserAssert localizationNotifications laserNotifications |
	
	self spawnRobot.
	
	( Delay forSeconds: 1 ) wait.
	
	localizationAssert := Semaphore new.
	laserAssert := Semaphore new.
	
	localizationNotifications := 0.
	laserNotifications := 0.
	
	
	robot enableNotificationsForService: LocalizationService doing: [: n | 
		localizationNotifications := localizationNotifications +1.
		localizationNotifications >= self expectedNotifications  ifTrue: [
			robot disableNotificationsForService: LocalizationService.
			localizationAssert signal.
		].
	]. 
	
	robot enableNotificationsForService: LaserService  doing: [: n | 
		laserNotifications := laserNotifications +1.
		laserNotifications >= self expectedNotifications  ifTrue: [
			robot disableNotificationsForService: LaserService .
			laserAssert signal.
		].
	]. 

	
	(Delay forSeconds: 1) wait.
	
	PureProcess allSubInstances do: #stop.
	localizationAssert waitTimeoutSeconds: 2.
	laserAssert waitTimeoutSeconds: 2.
	
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

{ #category : #tests }
TestProcesses >> testSpawnEnableDisableNoticationAndDestroyRobot [
	| lockAssert |
	
	self spawnRobot.
	
	( Delay forSeconds: 1 ) wait.
	
	lockAssert := Semaphore new.
	
	robot with: LocalizationService do: [:  localization  | 
		localization whenANotificationArrivesDo: [
		      self assert: PureConnector allInstances size =  2.
			self assert: NotificationConsumerProcess allInstances size = 1.			
			lockAssert signal.	
		].
		localization enableNotifications.
	]. 
	

	self deny: (lockAssert waitTimeoutSeconds: 2). 
	
	robot with: LocalizationService do: [:  localization  | 
		localization disableNotifications .		
	].

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

{ #category : #tests }
TestProcesses >> testSpawnEnableNoticationAndDestroyRobot [
	| lockAssert |
	
	self spawnRobot.
	
	( Delay forSeconds: 1 ) wait.
	
	lockAssert := Semaphore new.
	
	robot enableNotificationsForService: LocalizationService doing: [: n | 
		| a | 
		
            self assert: (PureConnector allInstances select: [: p | p isRunning ]) size =  2.
		self assert: (NotificationConsumerProcess allInstances  select: [: p | p isRunning ]) size = 1.
		lockAssert signal.	
	]. 
	

	self deny: (lockAssert waitTimeoutSeconds: 2). 
	
	self destroyRobot.
	
	PureProcess allSubInstances do: [
		:p | 
		self assert: p isRunning not.	
	].
	
	robot := nil. 	
	
	( Delay forMilliseconds: 200 ) wait.
	
	20 timesRepeat: [
		Smalltalk garbageCollect.		
	].

	self assert: (PureProcess allSubInstances select: [: p | p isRunning ]) size = 0.
	self assert: RobulabService allSubInstances size = 0.
	self assert: Robulab  allInstances size = 0.
	

	


]

{ #category : #'tests-with-crash' }
TestProcesses >> testSpawnEnableNoticationCrashConnectorAndDestroyRobot [
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

{ #category : #'tests-with-crash' }
TestProcesses >> testSpawnEnableNoticationCrashNotificatorAndDestroyRobot [
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

{ #category : #'tests-with-crash' }
TestProcesses >> testSpawnEnableNoticationCrashProcessesAndDestroyRobot [
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

{ #category : #tests }
TestProcesses >> testSpawnLoadAndDestroyRobot [

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
