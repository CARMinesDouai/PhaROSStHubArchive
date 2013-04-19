Class {
	#name : #PhaROSBaseCase,
	#superclass : #TestCase,
	#instVars : [
		'masterProcess',
		'turtleProcess',
		'master',
		'masterUrl',
		'masterURL'
	],
	#category : #'PhaROS-Kernel-Test'
}

{ #category : #accessing }
PhaROSBaseCase >> callerId [
	^ '/testId'.
]

{ #category : #'default parameters' }
PhaROSBaseCase >> defaultMasterIp [
	^ '10.1.160.135'
]

{ #category : #'default parameters' }
PhaROSBaseCase >> defaultMasterPort [
	^ 11311
]

{ #category : #accessing }
PhaROSBaseCase >> masterURL [
	^ masterURL ifNil: [ masterURL := 'http://', self defaultMasterIp, ':', self defaultMasterPort asString ] 
]

{ #category : #accessing }
PhaROSBaseCase >> masterURL: aString [
	masterURL := aString
]

{ #category : #'setup / teardown' }
PhaROSBaseCase >> setUp [
	masterUrl := self masterURL.
	master := PhaROSMaster url: masterUrl
]

{ #category : #actions }
PhaROSBaseCase >> shutdownMaster [
	PhaROSSystemLauncher instance shutdownMaster
]

{ #category : #actions }
PhaROSBaseCase >> shutdownTurtle [
	PhaROSSystemLauncher instance shutdownTurtle.

]

{ #category : #accessing }
PhaROSBaseCase >> spin: times [
	PhaROSSystemLauncher instance spin: times.
		

]

{ #category : #actions }
PhaROSBaseCase >> startUpMaster [
	PhaROSSystemLauncher instance startUpMaster.
	

]

{ #category : #actions }
PhaROSBaseCase >> startUpTurtle [
	PhaROSSystemLauncher instance startUpTurtle.
]

{ #category : #'setup / teardown' }
PhaROSBaseCase >> tearDown [ 
	PhaROSMaster stopAndUnregisterUrl: self masterURL.
	self shutdownMaster.
	self shutdownTurtle.
]
