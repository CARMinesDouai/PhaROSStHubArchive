Trait {
	#name : #NeTResetTrackedUsedPortsOnStartUp,
	#category : #'NetworkExtras-UDP-Kernel'
}

{ #category : #initialization }
NeTResetTrackedUsedPortsOnStartUp classSide >> initialize [
	Smalltalk addToStartUpList: self
]

{ #category : #'system startup' }
NeTResetTrackedUsedPortsOnStartUp classSide >> startUp: isImageStarting [
	isImageStarting ifFalse: [ ^self ].
	self resetUsedPorts.
]
