Class {
	#name : #PNGServiceDiscoveryTest,
	#superclass : #TestCase,
	#instVars : [
		'robulab'
	],
	#category : #'PureNG-Kernel-Test'
}

{ #category : #testing }
PNGServiceDiscoveryTest >> setUp [
	super setUp.
	robulab := PNGRobulab ip: #[192 168 1 2] port: 60000.
]

{ #category : #testing }
PNGServiceDiscoveryTest >> testServicesCount [
	self assert: robulab services size > 0
]

{ #category : #testing }
PNGServiceDiscoveryTest >> testThereMustBeAtLeastOneDirectoryService [
	| dirServices |
	dirServices := robulab services select: [:each| each isKindOf: PNGDirectoryService].
	self assert: dirServices size > 0
]

{ #category : #testing }
PNGServiceDiscoveryTest >> testThereMustBeNoUnknownService [
	| services |
	services := robulab services 
		select: [:each| each isKindOf: PNGUnknownService].
	self assert: services isEmpty

]

{ #category : #testing }
PNGServiceDiscoveryTest >> testThereMustBeOneBatteryService [
	| services |
	services := robulab services 
		select: [:each| each isKindOf: PNGBatteryService].
	self assert: services size = 1

]

{ #category : #testing }
PNGServiceDiscoveryTest >> testThereMustBeOneDiagnosticService [
	| services |
	services := robulab services 
		select: [:each| each isKindOf: PNGDiagnosticService].
	self assert: services size = 1

]

{ #category : #testing }
PNGServiceDiscoveryTest >> testThereMustBeOneDifferentialService [
	| services |
	services := robulab services 
		select: [:each| each isKindOf: PNGDifferentialService].
	self assert: services size = 1

]

{ #category : #testing }
PNGServiceDiscoveryTest >> testThereMustBeOneDriveService [
	| services |
	services := robulab services 
		select: [:each| each isKindOf: PNGDriveService].
	self assert: services size = 1

]

{ #category : #testing }
PNGServiceDiscoveryTest >> testThereMustBeOneIOService [
	| services |
	services := robulab services 
		select: [:each| each isKindOf: PNGIOService].
	self assert: services size = 1

]

{ #category : #testing }
PNGServiceDiscoveryTest >> testThereMustBeOneLaserService [
	| services |
	services := robulab services 
		select: [:each| each isKindOf: PNGLaserService].
	self assert: services size = 1

]

{ #category : #testing }
PNGServiceDiscoveryTest >> testThereMustBeOneLocalizationService [
	| services |
	services := robulab services 
		select: [:each| each isKindOf: PNGLocalizationService].
	self assert: services size = 1

]

{ #category : #testing }
PNGServiceDiscoveryTest >> testThereMustBeOneNotificationService [
	| services |
	services := robulab services 
		select: [:each| each isKindOf: PNGNotificationService].
	self assert: services size = 1

]

{ #category : #testing }
PNGServiceDiscoveryTest >> testThereMustBeOneStepService [
	| services |
	services := robulab services 
		select: [:each| each isKindOf: PNGStepService].
	self assert: services size = 1

]

{ #category : #testing }
PNGServiceDiscoveryTest >> testThereMustBeOneTrajectoryService [
	| services |
	services := robulab services 
		select: [:each| each isKindOf: PNGTrajectoryService].
	self assert: services size = 1

]

{ #category : #testing }
PNGServiceDiscoveryTest >> testThereMustBeTwoTelemeterServices [
	| services |
	services := robulab services 
		select: [:each| each isKindOf: PNGTelemeterService].
	self assert: services size = 2
]
