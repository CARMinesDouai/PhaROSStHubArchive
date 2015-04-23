"
I am a simple API that uses the ROS command line utilities to interact with ROS. I am intended as a lightweight bridge to ROS.

I am stateless, see my class side for my provided functionality. 
"
Class {
	#name : #PRRosCalloutAPI,
	#superclass : #Object,
	#category : #'PhaROSTestROS-SimpleAPI'
}

{ #category : #services }
PRRosCalloutAPI class >> call: aService [ 
	
	OSProcess waitForCommand: 'rosservice call ', aService. 
]

{ #category : #services }
PRRosCalloutAPI class >> call: aService withArgs: someArguments [
	
	OSProcess waitForCommand: 'rosservice call ', aService , '  ', someArguments. 
]

{ #category : #'publish-subscribe' }
PRRosCalloutAPI class >> peek: aTopic [
	| command result id |
	
	"Unique id for today"
	id := 'PRRosCalloutAPIPeek', Time now asNanoSeconds asString.

	command := String streamContents: [ :str |
		str	nextPutAll: 'rostopic echo ';
			nextPutAll: aTopic;
			nextPutAll: ' __name:=';
			nextPutAll: id].
	
	[result :=  self readMessageFrom:  (PipeableOSProcess  command: command).]
		ensure: [ OSProcess command: 'rosnode kill /',id].
	^result.

]

{ #category : #'publish-subscribe' }
PRRosCalloutAPI class >> publish: aMessage ofType: aType on: aTopic [
	| command |
	
	command := String streamContents: [ :str |
		str	nextPutAll: 'rostopic pub -1 ';
			nextPutAll: aTopic;
			nextPutAll: ' ';
			nextPutAll: aType;
			nextPutAll: ' ';
			nextPutAll: aMessage.
		 ].
	
	OSProcess waitForCommand: command.
]

{ #category : #utility }
PRRosCalloutAPI class >> readMessageFrom: aProcess [
	| output char  |
	
	output := WriteStream on: (String new: 100).
	[true] whileTrue: [ |contents|
		"read while not hogging the CPU"
		[(char := aProcess next) isNil] whileTrue: [Processor yield].
		output nextPut: char.
		"slightly clever testing for end of message"
		((char = $-) and: [contents := output contents. contents endsWith: '---']) ifTrue: [
			"swallow the newline"
			[aProcess next isNil] whileTrue: [Processor yield].
			^(contents copyFrom: 1 to: contents size - 3)]].
]

{ #category : #'publish-subscribe' }
PRRosCalloutAPI class >> subscribeTo: aTopic [
	"Returns an association with 
		key: { ID of the echo node . forked thread }
		value: the last message read.
	 Don't forget to terminate the subscription! Call unsubscribe: with as argument retval."
	| retval key thread command |
	
	retval := Association new.
	"A simple attempt at a unique key"
	key := 'PRRosCalloutAPISub', Time now asNanoSeconds asString, 100000 atRandom asString.

	command := String streamContents: [ :str |
		str	nextPutAll: 'rostopic echo ';
			nextPutAll: aTopic;
			nextPutAll: ' __name:=';
			nextPutAll: key].
	
	thread := [| process |
			process := (PipeableOSProcess command: command).
			[true] whileTrue: [ retval value: (self readMessageFrom: process).]
		] fork.

	retval key: { key . thread }.
	^ retval.
]

{ #category : #'publish-subscribe' }
PRRosCalloutAPI class >> unsubscribe: aSubscriptionAssoc [
	"Pass me the result of the subscribeTo: call"
	OSProcess command: 'rosnode kill /', (aSubscriptionAssoc key first).
	aSubscriptionAssoc key second terminate.
]
