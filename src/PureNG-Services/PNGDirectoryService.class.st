"
This service lists all the available services instances available on a PURE controller, including itself. 
There is always at least one instance running on a PURE controller, with instance number 0. This gives an entry point for discovery of the robot services.

Instance Variables:
	robot	<PNGRobulab>
	services	<(Collection of: PNGService)>
"
Class {
	#name : #PNGDirectoryService,
	#superclass : #PNGService,
	#instVars : [
		'robot',
		'services'
	],
	#category : #'PureNG-Services'
}

{ #category : #'instance creation' }
PNGDirectoryService class >> for: robulab [
	^self new
		robot: robulab;
		yourself
]

{ #category : #constants }
PNGDirectoryService class >> serviceType [ 
	^16r0000
]

{ #category : #'initialize-release' }
PNGDirectoryService >> initServices [ 
	|  encodedResponse serviceType instanceCode serviceClass  |
	services := Set with: self.		
	encodedResponse := self robot sendAndWaitForResult: PNGCommandStrings directoryServiceGetEntries.
	[encodedResponse hasData ] whileTrue: [
		serviceType :=  encodedResponse nextEncodedUInt16.
		instanceCode := encodedResponse nextEncodedUInt16.
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
