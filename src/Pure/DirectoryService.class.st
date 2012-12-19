Class {
	#name : #DirectoryService,
	#superclass : #RobulabService,
	#instVars : [
		'services'
	],
	#category : #'Pure-Services'
}

{ #category : #service }
DirectoryService >> destroy [
	services do: [ :s | ((s isKindOf: DirectoryService) ) ifFalse: [ s destroy ]].
	super destroy.
]

{ #category : #accessing }
DirectoryService >> instanceRelatedTo: anInstanceID [
	^services at: anInstanceID.
]

{ #category : #accessing }
DirectoryService >> instancesRelatedWith: aServiceClass [ 
	| selected |
	selected := services values select: [ : s | s isKindOf: aServiceClass ].
	self assert: selected size > 0.
	^ selected. 
]

{ #category : #accessing }
DirectoryService >> interestedAnnouncements [
	^ {   } 
]

{ #category : #'initialize-release' }
DirectoryService >> load: aConnector [

| decoder  instanceCode serviceType |

	(self services isNil)ifTrue: [
		self services: Dictionary new.
		self services at:0 put: self.
	].

	" Transform this call into a common get call just to keep consistence"
	self flag: #TODO.


	decoder := (self robulab discoverServices) decoder.

	

	[decoder hasData ] whileTrue: [

		serviceType :=  decoder nextEncodedUInt16.

		instanceCode := decoder nextEncodedUInt16.
		
		ConstantesRobulab serviceClassPerType at: serviceType ifPresent: [ :v |
			((ConstantesRobulab serviceClassPerType at: serviceType) = DirectoryService) ifFalse:  [
				self services at: (instanceCode) put:(RobulabService createFromRobulab: (self robulab) Type: (serviceType)) .
			].
 			Transcript show: ((ConstantesRobulab codesServices at: serviceType),' ',instanceCode asString ,': ',serviceType asString );cr.
		] ifAbsent: [
			Transcript show:  serviceType hex asString, ' -> not yet implemented'; cr
		]
	].


]

{ #category : #accessing }
DirectoryService >> relatedNotificationClass [
	^ self error: 'This service has not notifications'
]

{ #category : #accessing }
DirectoryService >> services [
	^ services
]

{ #category : #accessing }
DirectoryService >> services: anObject [
	services := anObject
]
