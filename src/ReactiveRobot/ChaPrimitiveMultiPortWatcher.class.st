Class {
	#name : #ChaPrimitiveMultiPortWatcher,
	#superclass : #ChaDefaultInOutComponent,
	#traits : 'TChaMultiPortWatcher',
	#classTraits : 'TChaMultiPortWatcher classTrait',
	#instVars : [
		'watchedPorts'
	],
	#category : #'ReactiveRobot-01-EmergencyStop'
}

{ #category : #'instance creation' }
ChaPrimitiveMultiPortWatcher class >> on: components [
	^self onPorts: (components collect: [ : each | each outputPort])
]

{ #category : #'instance creation' }
ChaPrimitiveMultiPortWatcher class >> onPorts: ports [
	^self new
		watchedPorts: ports;
		yourself
]

{ #category : #accessing }
ChaPrimitiveMultiPortWatcher >> watchedPorts [
	^ watchedPorts
]

{ #category : #accessing }
ChaPrimitiveMultiPortWatcher >> watchedPorts: ports [
	watchedPorts := ports.
	watchedPorts do: [ : each |
		each connectTo: #input: of: self]
]
