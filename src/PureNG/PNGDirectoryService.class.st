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

{ #category : #constants }
PNGDirectoryService class >> serviceType [ 
	^16r0000
]

{ #category : #public }
PNGDirectoryService >> allServices [
	^self get
]

{ #category : #actions }
PNGDirectoryService >> decodeGetResponseFrom: decoder [ 
	| services serviceType instanceCode serviceClass  |
	services := Set with: self.		
	[decoder hasData] whileTrue: [
		serviceType := decoder nextEncodedUInt16.
		instanceCode := decoder nextEncodedUInt16.
		serviceType ~= PNGDirectoryService serviceType ifTrue:[
			serviceClass := PNGService serviceClassForType: serviceType.
			services add: (serviceClass newWithId: instanceCode).
		]
	].
	^services
]

{ #category : #actions }
PNGDirectoryService >> getCommandString [ 

	^ '01000000'
]
