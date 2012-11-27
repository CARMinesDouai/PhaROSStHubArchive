Class {
	#name : #PureClientUsesExamples,
	#superclass : #Object,
	#category : #'Pure-Examples'
}

{ #category : #'as yet unclassified' }
PureClientUsesExamples >> workspaceBrowsingServices [
| pdr |

pdr := nil .
Smalltalk garbageCollect .
self assert: LaserService allInstances size = 0.
self assert: Robulab  allInstances size = 0.


pdr := Robulab newWith: #[192 168 1 2] and: 60000.


"NotificationManager".
pdr with: NotificationManagerService do: [
	: service |
	service getData.
	
	pdr with: LocalizationService  do: [
		:laser |
		service addNotificationRecordToInstance: laser withPeriod:  2.
		
	].
].


"IO Service"
pdr with: IOService do: [
	: service |
	service getData .
].


"Differential Drive"
pdr with: DifferentialDriveService do: [
	: service |
	service getData .
	service printCurrentAndTargetValues. 
	service setTargetLinearSpeed: 0.0 andTargetAngularSpeed: 0.4.	
].



"Service Laser"
pdr with: LaserService do: [
	: service |
	service getData .
	service printEchos .
].



]

{ #category : #'as yet unclassified' }
PureClientUsesExamples >> workspaceGMappingBridge [
	| robot tf scan master|



 " 
 Stopping 
"
	
	PhaROSTypeBrowser reset.
	PhaROSTypeBrowser instance definition: 'sensor_msgs/LaserScan'.

	
	PhaROSMaster stopAndUnregisterUrl: 'http://127.0.0.1:11311/'.
	PhaROSSystemLauncher instance  shutdownGMapping.
	PhaROSSystemLauncher instance  shutdownMaster.

	robot := nil .
	master := nil. 
	tf := nil.
	scan := nil.
	
	Smalltalk garbageCollect .
	self assert: LaserService allInstances size = 0.
	self assert: Robulab  allInstances size = 0.
	self assert: PhaROSMaster allInstances size = 0.


" 
starting 
"

	PhaROSSystemLauncher instance startUpMaster.	
	PhaROSSystemLauncher instance startUpGMapping.	
	master := PhaROSMaster url: 'http://127.0.0.1:11311/' .



	robot := Robulab newWith: #[192 168 1 2] and: 60000.
	

	tf := master create: PurePhaROSTFOdometryBroadcaster named: '/OdometryBroadcaster' domain: '127.0.0.1' tcpPort: 9998 xmlRpcPort:  6125.
		
	scan :=  master create: PurePhaROSLaserBroadcaster named: '/LaserBroadcaster' domain: '127.0.0.1' tcpPort: 9999  xmlRpcPort:  6123.
	
	tf robot: robot ; setUp.
	scan robot: robot; setUp.
	
	
	
	



]

{ #category : #'as yet unclassified' }
PureClientUsesExamples >> workspaceKillingProcess [

	Process allInstances "allSubInstances" select: [:aProcess | aProcess priority = 30] thenDo: [:p| p terminate ]
]
