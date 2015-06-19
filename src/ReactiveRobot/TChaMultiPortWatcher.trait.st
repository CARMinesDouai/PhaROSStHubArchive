Trait {
	#name : #TChaMultiPortWatcher,
	#category : #'ReactiveRobot-EmergencyStop'
}

{ #category : #'instance creation' }
TChaMultiPortWatcher classSide >> on: components [
	^self onPorts: (components collect: [ : each | each outputPort])
]

{ #category : #'instance creation' }
TChaMultiPortWatcher classSide >> onPorts: ports [
	^self new
		watchedPorts: ports;
		yourself
]

{ #category : #accessing }
TChaMultiPortWatcher >> watchedPorts: ports [
	self explicitRequirement
]
