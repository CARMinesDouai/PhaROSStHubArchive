Class {
	#name : #ChaPrimitiveMultiPortWatcher,
	#superclass : #ChaDefaultInOutComponent,
	#traits : 'TChaMultiPortWatcher',
	#classTraits : 'TChaMultiPortWatcher classTrait',
	#instVars : [
		'watchedPorts'
	],
	#category : #'ReactiveRobot-EmergencyStop'
}

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
