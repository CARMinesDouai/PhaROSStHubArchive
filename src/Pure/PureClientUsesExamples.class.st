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
	| robot tf scan master notication service laserNot laser |


 " 
 Stopping 

PhaROSNode allSubInstances do: [: s | s master: nil. s topics removeAll . s initialize ].
robot := nil.
master := nil.
publisher := nil.
slave := nil.
receiverDelegate:= nil.
"

 
	PhaROSTypeBrowser reset.
	PhaROSTypeBrowser instance definition: 'sensor_msgs/LaserScan'.

	
	PhaROSMaster stopAndUnregisterUrl: 'http://127.0.0.1:11311/'.
	robot destroy .
	PhaROSSystemLauncher instance  shutdownGMapping.
	PhaROSSystemLauncher instance  shutdownMaster.

	robot := nil .
	master := nil. 
	tf:=nil.
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

	master setParam:''  named:'/slam_gmapping/maxRange'  with: 10.0.
	master setParam:''  named:'/slam_gmapping/maxUrange'  with: 6.0.
      
	robot := Robulab newWith: #[192 168 1 2] and: 60000.
	robot subscribe: LaserNotification  do: [ :not | Transcript show: 'Laser!'; cr. ].
	robot subscribe: LocalizationNotification   do: [ :not | Transcript show: 'Local!'; cr. ].



	
	
	tf := master create: PurePhaROSTFOdometryBroadcaster named: '/OdometryBroadcaster' domain: '127.0.0.1' tcpPort: 9998 xmlRpcPort:  6125.
	
	scan :=  master create: PurePhaROSLaserBroadcaster named: '/LaserBroadcaster' domain: '127.0.0.1' tcpPort: 9999  xmlRpcPort:  6123.


	
	PhaROSTypeBrowser instance definition: 'tf/tfMessage'.
	
	
	tf robot: robot ; setUp.
	scan robot: robot; setUp.
	
	
	
"
	
	
	robot with: DifferentialDriveService do: [
	: service |
	service getData .
	service printCurrentAndTargetValues. 
	service setTargetLinearSpeed: 0.0 andTargetAngularSpeed: 0.4.	
].

	
	
	service := nil.
	notification := nil 
	service := LocalizationService new  xPos: 2100.0; yPos: 0.0; orientation: 0.0; status:0 ; yourself.
	notication := LocalizationNotification new xPos: 2100.0; yPos: 0.0; orientation: 0.0; status: 0 ; yourself.
	
	
	laser := LaserService new echoNumber: 255; echos: {}; orientation: 0.0; xposition: 0.0; yposition: 0.0; yourself.
	
	
	laserNot := LaserNotification new .
	
	1 to: 720 do: [
		:i |
		laserNot addEcho: (i*0.5) and: ((i*0.25) degreesToRadians) +(Float pi)
	].
	 
  "
	robot:= PureMockulab new.
	tf broadcast: notication from: service .
	
	scan broadcast: laserNot from: laser.







]

{ #category : #'as yet unclassified' }
PureClientUsesExamples >> workspaceKillingProcess [

	Process allInstances "allSubInstances" select: [:aProcess | aProcess priority = 30] thenDo: [:p| p terminate ]
]

{ #category : #'as yet unclassified' }
PureClientUsesExamples >> workspaceUsingNotifications [
	| robot |
	
	robot := nil.
	Smalltalk garbageCollect .
	
	
	robot := Robulab newWith: #[192 168 1 2] and: 60000.
	
	robot subscribe: LaserNotification  do: [ :not | Transcript show: 'Laser!'; cr. ].
	robot subscribe: LocalizationNotification   do: [ :not | Transcript show: 'Local!'; cr. ].
	
	
	
	robot with: NotificationManagerService  do: [
		: notifications | 
		
		robot with: LaserService do: [
			: laser | 
			notifications addNotificationRecordToInstance: laser withPeriod: 1.
		].
		robot with: LocalizationService do: [
			: local | 
			notifications addNotificationRecordToInstance: local withPeriod: 0.
		].
	].
	
]
