Class {
	#name : #PureDebugUtil,
	#superclass : #Object,
	#instVars : [
		'robot'
	],
	#category : #'Pure-Examples'
}

{ #category : #'as yet unclassified' }
PureDebugUtil >> initialize [
	robot := Robulab newWith: #[192 168 1 2] and: 60000.
]

{ #category : #'as yet unclassified' }
PureDebugUtil >> laserScanDefinition [

	^ PhaROSTypeBrowser instance definition: 'sensor_msgs/LaserScan'.	

]

{ #category : #'as yet unclassified' }
PureDebugUtil >> laserStopTranscript [

	robot with: LocalizationService do: [ : aLocalizationService | 
		aLocalizationService disableNotifications.
	].
]

{ #category : #'as yet unclassified' }
PureDebugUtil >> moveForward: aVelocity [

	robot with: DifferentialDriveService do: [
		: service |
		service load .
		service printCurrentAndTargetValues. 
		service setTargetLinearSpeed: aVelocity andTargetAngularSpeed: 0.0.	
	].

]

{ #category : #'as yet unclassified' }
PureDebugUtil >> odometryStopTranscript [

	robot with: LocalizationService do: [ : aLocalizationService | 
		aLocalizationService disableNotifications.
	].
]

{ #category : #'as yet unclassified' }
PureDebugUtil >> odometryTranscript [

	robot with: LocalizationService do: [ : aLocalizationService | 
		aLocalizationService enableNotifications .
		aLocalizationService whenANotificationArrivesDo: [ : aNotification | 
			Transcript show: '[x:', aNotification xPos asString,'] y:[', aNotification yPos asString,  '] o:[', aNotification orientation  asString,'] stat:[', aNotification status asString, ']' ; cr.
		].		
	].
]

{ #category : #'as yet unclassified' }
PureDebugUtil >> resetLocalizationService [

	robot with: LocalizationService do: [ : service | 
		
		service resetLocalization.
	].
]

{ #category : #'as yet unclassified' }
PureDebugUtil >> rotate: aVelocity [

	robot with: DifferentialDriveService do: [
		: service |
		service load .
		service printCurrentAndTargetValues. 
		service setTargetLinearSpeed: 0.0 andTargetAngularSpeed: aVelocity.	
	].

]

{ #category : #'as yet unclassified' }
PureDebugUtil >> tfMessageDefinition [

	^	PhaROSTypeBrowser instance definition: 'tf/tfMessage'.
	

]
