Class {
	#name : #PhaROSBaseCase,
	#superclass : #TestCase,
	#instVars : [
		'masterProcess',
		'turtleProcess',
		'master',
		'masterUrl'
	],
	#category : #'PhaROS-Kernel-Test'
}

{ #category : #accessing }
PhaROSBaseCase >> callerId [
	^ '/testId'.
]

{ #category : #accessing }
PhaROSBaseCase >> setUp [ 


	masterUrl := 'http://localhost:11311/' .
	
	master := PhaROSMaster url: masterUrl.
]

{ #category : #'as yet unclassified' }
PhaROSBaseCase >> shutdownMaster [
	PhaROSSystemLauncher instance shutdownMaster
]

{ #category : #'as yet unclassified' }
PhaROSBaseCase >> shutdownTurtle [
	PhaROSSystemLauncher instance shutdownTurtle.

]

{ #category : #'as yet unclassified' }
PhaROSBaseCase >> spin: times [
	PhaROSSystemLauncher instance spin: times.
		

]

{ #category : #'as yet unclassified' }
PhaROSBaseCase >> startUpMaster [
	PhaROSSystemLauncher instance startUpMaster.
	

]

{ #category : #'as yet unclassified' }
PhaROSBaseCase >> startUpTurtle [
	PhaROSSystemLauncher instance startUpTurtle.
]

{ #category : #'as yet unclassified' }
PhaROSBaseCase >> tearDown [ 
	PhaROSMaster stopAndUnregisterUrl: 'http://127.0.0.1:11311/'.
	self shutdownMaster.
	self shutdownTurtle.
]
