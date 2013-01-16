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

{ #category : #actions }
PNGDirectoryService >> get [ 
	"Answers a collection of services available on the robot"
	| services encodedResponse serviceType instanceCode serviceClass  |
	services := Set with: self.		
	encodedResponse := self robot sendAndWaitForResult: PNGCommandStrings directoryServiceGetEntries.
	[encodedResponse hasData ] whileTrue: [
		serviceType :=  encodedResponse decoder nextEncodedUInt16.
		instanceCode := encodedResponse decoder nextEncodedUInt16.
		serviceType ~= PNGDirectoryService serviceType ifTrue:[
			serviceClass := PNGService serviceClassForType: serviceType.
			services add: (serviceClass newWithId: instanceCode).
		]
	].
	^services
]
