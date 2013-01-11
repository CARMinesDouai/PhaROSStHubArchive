Class {
	#name : #PNGDirectoryService,
	#superclass : #PNGService,
	#instVars : [
		'robot',
		'services'
	],
	#category : #'PureNG-Kernel'
}

{ #category : #'instance creation' }
PNGDirectoryService class >> for: robulab [
	^self new
		robot: robulab;
		yourself
]

{ #category : #constants }
PNGDirectoryService class >> serviceType [ 
	^0
]

{ #category : #'initialize-release' }
PNGDirectoryService >> initServices [ 
	| rawResult decoder serviceType instanceCode serviceClass rawSize response sendInfo stream |
	services := Set with: self.
	rawResult := ByteArray new: 1024.
	rawSize := (self robot sendAndWaitForResult: PNGCommandStrings directoryServiceGetEntries withAnswer:  rawResult) at: 1.
	stream := (rawResult copyFrom: 1 to: rawSize).
	response := PureResponse initializeFromArray: (stream copyFrom: 2 to: rawSize) forRobot: robot.	
	
	decoder := PureDecoder for: (ReadStream on: response data).
	
	[decoder hasData ] whileTrue: [
		serviceType :=  decoder nextEncodedUInt16.
		instanceCode := decoder nextEncodedUInt16.
		serviceType ~= PNGDirectoryService serviceType ifTrue:[
			serviceClass := PNGService serviceClassForType: serviceType.
			services add: (serviceClass newWithId: instanceCode).
		]
	].
]

{ #category : #'initialize-release' }
PNGDirectoryService >> initialize [ 
	super initialize.
	id := self class serviceType

]

{ #category : #accessing }
PNGDirectoryService >> instanceRelatedTo: anInstanceID [
	^services detect: [:service | service id = anInstanceID].
]

{ #category : #accessing }
PNGDirectoryService >> robot [
	^ robot
]

{ #category : #accessing }
PNGDirectoryService >> robot: aRobulab [
	robot := aRobulab.
	aRobulab directoryService: self.
	self initServices
]

{ #category : #accessing }
PNGDirectoryService >> services [
	^services
]
