Class {
	#name : #OCNNetCatBasedServer,
	#superclass : #Object,
	#instVars : [
		'process',
		'port'
	],
	#category : #'Ocean-Kernel-TestSupport'
}

{ #category : #'instance creation' }
OCNNetCatBasedServer class >> port: anInteger [
	^self new
		port: anInteger;
		yourself
]

{ #category : #testing }
OCNNetCatBasedServer >> isRunning [
	^self process notNil
]

{ #category : #accessing }
OCNNetCatBasedServer >> port [
	^ port
]

{ #category : #accessing }
OCNNetCatBasedServer >> port: anObject [
	port := anObject
]

{ #category : #accessing }
OCNNetCatBasedServer >> process [
	^ process
]

{ #category : #accessing }
OCNNetCatBasedServer >> process: anObject [
	process := anObject
]

{ #category : #accessing }
OCNNetCatBasedServer >> processPid [
	^self process pid 
]

{ #category : #'process lifecycle' }
OCNNetCatBasedServer >> start [
	self process: (OSProcess command: 'nc -l localhost ', self port printString)
]

{ #category : #'process lifecycle' }
OCNNetCatBasedServer >> stop [
	"kill -3 == sends the QUIT signal to the process (equivalent to Ctl-C)"
	self isRunning ifTrue: [
		OSProcess waitForCommand: 'kill -3 ', self processPid printString].
	self process: nil
]
