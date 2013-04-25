Class {
	#name : #PhaROSTurtleDriver,
	#superclass : #PhaROSNode,
	#instVars : [
		'isStarted'
	],
	#category : #'PhaROS-Experiments-RoboShopDeliverable1'
}

{ #category : #examples }
PhaROSTurtleDriver class >> driverExample [
	"self driverExample"
	| master |
	master := PhaROSMaster url: 'http://127.0.0.1:11311/'.
	^ master
		create: self
		named: '/myTurtleDriver'
		domain: '127.0.0.1'
		tcpPort: 20202 
		xmlRpcPort: 21212
]

{ #category : #controlling }
PhaROSTurtleDriver >> start [
	|delay|
	super start.
	delay := 1 second asDelay.
	isStarted := true.
	[[isStarted] whileTrue: [    delay wait.
            self sendTo: '/turtle1/command_velocity' a: [ :msg |
                msg angular: 1.0.
                msg linear: -2.0	
            ]. 
        ]] forkAt: Processor userBackgroundPriority named: self printString
]

{ #category : #controlling }
PhaROSTurtleDriver >> stop [
	super stop.
	isStarted := false
]
