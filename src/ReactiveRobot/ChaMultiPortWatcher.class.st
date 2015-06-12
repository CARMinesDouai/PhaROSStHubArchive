Class {
	#name : #ChaMultiPortWatcher,
	#superclass : #ChaDefaultInOutComponent,
	#instVars : [
		'watchedPorts'
	],
	#category : #'ReactiveRobot-EmergencyStop'
}

{ #category : #'instance creation' }
ChaMultiPortWatcher class >> on: components [
	^self onPorts: (components collect: [ : each | each outputPort])
]

{ #category : #'instance creation' }
ChaMultiPortWatcher class >> onPorts: ports [
	^self new
		watchedPorts: ports;
		yourself
]

{ #category : #accessing }
ChaMultiPortWatcher >> watchedPorts [
	^ watchedPorts
]

{ #category : #accessing }
ChaMultiPortWatcher >> watchedPorts: ports [
	watchedPorts := ports.
	watchedPorts do: [ : each |
		each connectTo: #input: of: self]
]
